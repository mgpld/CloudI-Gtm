/* -*- coding: utf-8; Mode: C; tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 * ex: set softtabstop=4 tabstop=4 shiftwidth=4 expandtab fileencoding=utf-8:
 * 
 */
#include "cloudi.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <errno.h>
#include <gtmxc_types.h>

// GT.M limits - you can use smaller numbers if your application doesn't need such large strings
#define maxcode 8192 // maximum length of a line of code for the compiler / variable name
#define maxmsg 2048 // maximum length of a GT.M message
#define maxstr 1048576 // maximum length of a value

// GT.M call wrapper - if an error in call or untrappable error in GT.M, print error on STDERR, clean up and exit
#define CALLGTM(xyz) status = xyz ;             \
  if (0 != status ) {                           \
    gtm_zstatus( msg, maxmsg );                 \
    fprintf( stdout, __FILE__  ":%d Error: %s\n", __LINE__, msg );             \
  }


#define GTMAPI(call) status = call;             \
  if (0 != status ) {                           \
    gtm_zstatus( msg, maxmsg );                 \
    fprintf( stdout, __FILE__  ":%d Error: %s\n", __LINE__, msg );             \
    goto error; \
  }

#define LOG(msg) \
    fprintf( stdout, __FILE__ ":%d %s\n", __LINE__, msg);

/*
    cloudi_return(api, command, name, pattern, "", 0, \
              msg, strlen(msg), \
              timeout, trans_id, pid, pid_size); \
  } \
*/

typedef struct
{
    int thread_index;

} process_requests_t;

uint16_t uint16_read_big(const char *);

/* ERLANG side: (not inside an handler)
Priority = undefined,
Timeout = 5000,
cloudi:send_sync(C, "/ds/write/execute/post", <<"method",0,"create",0,"module",0,"photo",0>>, <<"data">>, Timeout, Priority).
cloudi:send_sync(C, "/ds/write/execute/post", iolist_to_binary([ <<"method",0>>, <<"create",0,"module",0,"photo",0>>]), <<"data">>, 5000, undefined).
*/

static void request(int const command,
                    char const * const name,
                    char const * const pattern,
                    void const * const request_info,
                    uint32_t const request_info_size,
                    void const * const request,
                    uint32_t const request_size,
                    uint32_t timeout,
                    int8_t priority,
                    char const * const trans_id,
                    char const * const pid,
                    uint32_t const pid_size,
		    void * state,
		    cloudi_instance_t * api)
{
    const char	*apicall = 0;

    gtm_char_t msg[maxmsg], dbresponse[maxstr];
    gtm_status_t status;
    gtm_string_t api_return_value;
    gtm_long_t   count = 0;

    size_t  offset;
    uint16_t len = 0;
    
    char const * signature = "signature";

    gtm_string_t call[2] = {
        {0,0},
        {0,0}
    };
    gtm_string_t *method = 0;
    gtm_string_t *module = 0;

    gtm_string_t arguments[12] = { 
        {0,0}, {0,0}, {0,0}, {0,0}, {0,0}, 
        {0,0}, {0,0}, {0,0}, {0,0}, {0,0},
	{0,0}, {0,0}
    };

    size_t i,j;

    for (j = 0, offset = 0; offset < request_info_size;) {
        len = uint16_read_big(request_info + offset);
        call[j].address = (xc_char_t *) request_info + offset + 2;
        call[j].length = (gtm_long_t) len;
        offset += 2 + len;
        j++;
    }

    method = &call[0];
    module = &call[1];

    api_return_value.address = (xc_char_t *) &dbresponse;
    api_return_value.length = 0;

    // Check the signature of the call. If not found -> fail.
    GTMAPI( gtm_ci( signature, &api_return_value, module, method ) );
    if (api_return_value.length == 0) {
	goto fail;
    }

    if (api_return_value.length == 1) {
	// fprintf( stdout, "returned bytes: '%.*s', %c\n", api_return_value.length, api_return_value.address, api_return_value.address[0]);
	if ( api_return_value.address[0] == '0' ) {
	    goto fail;
	}
    }

    char const ** parameters = cloudi_info_key_value_parse(api_return_value.address, api_return_value.length);
    // @doc Count how many parameters we have.
    for (i = 0; parameters[i]; i++) {
        // fprintf( stdout, "parameters i: %zu, %s\n", i, parameters[i]);
    }

    if (i && (request_size == 0) ) {
	fprintf( stdout, "Missing arguments: need %zu got 0\n", i);
	goto fail;
    }

    // fprintf( stdout, "request_size: %d\n", request_size);
    //fprintf( stdout, "PARSING REQUEST\n");
    //for (j = 0, offset = 0; offset <= request_size, j < i;) {
    for (j = 0, offset = 0; j < i;) {
        len = uint16_read_big(request+offset);
        // fprintf( stdout, "offset: %d, read: %d out of %d\n", (int) offset, (int) len, request_size);
        arguments[j].address = (xc_char_t *) request + offset + 2;
        arguments[j].length = (gtm_long_t) len;
        //fprintf( stdout, "offset: %d, %d, %d: %.*s\n", (int) offset, (int) j, (int) arguments[j].length, (int) arguments[j].length, arguments[j].address);
        offset += 2 + len;
        j++;
	/* Quit if request_size bytes have already been scanned ... */
	if (offset >= request_size) break;
    }

    // fprintf( stdout, "arguments: need %d got %d\n", i, j);

    /* Check that all arguments are present */
    if ( j < i ) {
	fprintf( stdout, "Missing arguments: need %zu got %zu\n", i, j);
	goto fail;
    }

    count = j;

    // fprintf( stdout, "Calling: c0%d(\"%.*s\",\"%.*s\"", (int) count, (int) method->length, method->address, (int) module->length, module->address );
    // for (i = 0; i < count; i++) {
    //     fprintf( stdout, ",\"<%s:%ld>\"", parameters[i], arguments[i].length);
    // }
    // fprintf( stdout, ")\n");

    cloudi_info_key_value_destroy(parameters);

    // Check that we have at least one argument 
    if (count == 0) {
        goto fail;
    }

    // Execute the real call
    api_return_value.address = (xc_char_t *) &dbresponse;
    api_return_value.length = 0;

    switch ( count ) {
        case 1:
	    apicall = "c01";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0]) );
            break;
        case 2:
	    apicall = "c02";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0], &arguments[1]) );
            break;
        case 3:
	    apicall = "c03";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0], &arguments[1], &arguments[2]) );
            break;
        case 4:
	    apicall = "c04";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0], &arguments[1], &arguments[2], &arguments[3]) );
            break;
        case 5:
	    apicall = "c05";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0], &arguments[1], &arguments[2], &arguments[3], &arguments[4]) );
            break;
        case 6:
	    apicall = "c06";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0], &arguments[1], &arguments[2], &arguments[3], &arguments[4], 
                &arguments[5]) );
            break;
        case 7:
	    apicall = "c07";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0], &arguments[1], &arguments[2], &arguments[3], &arguments[4], 
                &arguments[5], &arguments[6]) );
            break;
        case 8:
	    apicall = "c08";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0], &arguments[1], &arguments[2], &arguments[3], &arguments[4], 
                &arguments[5], &arguments[6], &arguments[7]) );
            break;
        case 9:
	    apicall = "c09";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0], &arguments[1], &arguments[2], &arguments[3], &arguments[4], 
                &arguments[5], &arguments[6], &arguments[7], &arguments[8]) );
            break;
        case 10:
	    apicall = "c10";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0], &arguments[1], &arguments[2], &arguments[3], &arguments[4], 
                &arguments[5], &arguments[6], &arguments[7], &arguments[8], &arguments[9]) );
            break;
        case 11:
	    apicall = "c11";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0], &arguments[1], &arguments[2], &arguments[3], &arguments[4], 
                &arguments[5], &arguments[6], &arguments[7], &arguments[8], &arguments[9],
                &arguments[10]) );
            break;
        case 12:
	    apicall = "c12";
            GTMAPI( gtm_ci( apicall, &api_return_value, module, method, 
                &arguments[0], &arguments[1], &arguments[2], &arguments[3], &arguments[4], 
                &arguments[5], &arguments[6], &arguments[7], &arguments[8], &arguments[9],
                &arguments[10], &arguments[11]) );
            break;
        default:
            fprintf(stdout, "%d is not valid\n", (int) count);
            break;
    }

    cloudi_return(api, command, name, pattern, apicall, 3,
              api_return_value.address, api_return_value.length,
              timeout, trans_id, pid, pid_size);

fail:
    cloudi_return(api, command, name, pattern, 
	"fail", 4,
	"ko", 2,
	timeout, trans_id, pid, pid_size);

error:
    //cloudi_info_key_value_destroy(infos);
    cloudi_return(api, command, name, pattern, "error", 5,
              "error", 5,
              timeout, trans_id, pid, pid_size);
}

void process_requests(void * p)
{
    cloudi_instance_t api;
    int	result;

    gtm_char_t msg[maxmsg];
    gtm_status_t status;

    //process_requests_t * data = (process_requests_t *) p;

    result = cloudi_initialize(&api, 0, 0);
    assert(result == cloudi_success);

    setlinebuf(stdout);
    setlinebuf(stderr);

    // Initialize GT.M runtime
    CALLGTM( gtm_init() );

    LOG("gtm_api init done");

    result = cloudi_subscribe(&api, "execute/*", &request);
    assert(result == cloudi_success);

    result = cloudi_poll(&api, -1);

    for (;;) {
        result = cloudi_poll(&api, -1);
        switch ( result ) {
            case cloudi_success:
                goto exit;
            case cloudi_terminate:
                goto exit;
            case cloudi_error_poll_EINTR: // 106
                // GTM is signalling
                errno = 0;
                break;;
            default:
                fprintf(stdout, "cloudi_poll: %d\n", result);
                goto exit;
        }
    }

exit:
    fprintf(stdout, "error %d\n", result);
    fprintf(stdout, "terminate " __FILE__ " %c\n", result);

    CALLGTM(gtm_exit());
    cloudi_destroy(&api);
}

int main(int argc, char ** argv)
{
    unsigned int thread_count;
    int result = cloudi_initialize_thread_count(&thread_count);

    assert(result == cloudi_success);
    assert(thread_count == 1);

    process_requests_t data = {0};
    process_requests(&data);

    return 0;
}


uint16_t uint16_read_big(const char *in) {
  return (unsigned short)((((unsigned char) in[0]) << 8) | (unsigned char)in[1]);
}

