; Utils for CloudI interface
; FIXME no error handling atm

; WARNING q:$quit is not working WARNING
; WARNING the service must be restarted to take
; Any modification of this file
; (seems that the call interface .ci files are not
; auto-relink aware)

usage()
    q

version()
    q $zv

entity()
    q "util"

error(result,code,msg)
    d ^errors(.result,$$entity,code,msg)
    q

signature(module,action)
    i (module="") q 0
    i (action="") q 0

    ; @doc Check that module is exported.
    i '$d(^fqids(module)) w $zpos," no module: ",module,! q 0
    ; @doc check that action for that module is exported.
    i '$d(^fqids(module,"action",action)) w $zpos," no callable entrypoint: ",action,"  for module: ",module,! q 0

    n result,arg,pos,total
    d doc(.result,module,action)

    ; @doc If doc didn't found the module action, quits
    if '$d(result) w $zpos," no entrypoint: ",action,"  for module: ",module,!  q 0

    q $$kv(.result) 

%signature(result,client,module,action)
    if (module="") do error(.result,61,"missing module") quit
    if (action="") do error(.result,62,"missing action") quit

    ; @doc Check that module is expored.
    if '$d(^fqids(module)) d error(.result,65,"invalid module") quit
    ; @doc check that action for that module is exported.
    if '$d(^fqids(module,"action",action)) do error(.result,67,"invalid action") quit

    new arg,pos,total
    do doc(.result,module,action)

    ; @doc If doc didn't found the module action, quits
    if '$data(result) do error(.result,73,"invalid call") quit

    set result(.1,1)=0
    set result(.1,2)=1

    q 

; @doc Simple call
; Only client identifier: parameter 'a'.
call01(module,action,a)
    n result,cmd,elapsed
    s cmd=$$callexpr(module,action,1)

    w $zpos," cmd: ",cmd,!

    s elapsed=$zut
    g execcall
    q

call02(module,action,a,b)
    n result,cmd,elapsed,call
    s cmd=$$callexpr(module,action,2)
    
    n day,time,ms,now
    s now=$zh
    s day=$p(now,",",1)
    s time=$p(now,",",2)
    s ms=$p(now,",",3)

    s call(1)=$zl(b)
    m ^log(a,module,action,day,time,ms)=call

    s elapsed=$zut
    g execcall
    q

call03(module,action,a,b,c)
    n result,cmd,now,elapsed,call
    s cmd=$$callexpr(module,action,3)
    
    n day,time,ms,now
    s now=$zh
    s day=$p(now,",",1)
    s time=$p(now,",",2)
    s ms=$p(now,",",3)

    s call(1)=$zl(b)
    s call(2)=$zl(c)
    m ^log(a,module,action,day,time,ms)=call

    s elapsed=$zut
    g execcall
    q

call04(module,action,a,b,c,d)
    n result,cmd,now,elapsed,call
    s cmd=$$callexpr(module,action,4)

    n day,time,ms,now
    s now=$zh
    s day=$p(now,",",1)
    s time=$p(now,",",2)
    s ms=$p(now,",",3)
    
    s call(1)=$zl(b)
    s call(2)=$zl(c)
    s call(3)=$zl(d)
    m ^log(a,module,action,day,time,ms)=call

    s elapsed=$zut
    g execcall
    q

call05(module,action,a,b,c,d,e)
    n result,cmd,now,elapsed,call
    s cmd=$$callexpr(module,action,5)
    
    n day,time,ms,now
    s now=$zh
    s day=$p(now,",",1)
    s time=$p(now,",",2)
    s ms=$p(now,",",3)

    s call(1)=$zl(b)
    s call(2)=$zl(c)
    s call(3)=$zl(d)
    s call(4)=$zl(e)
    m ^log(a,module,action,day,time)=call

    s elapsed=$zut
    g execcall
    q

call06(module,action,a,b,c,d,e,f)
    n result,cmd,now,elapsed,call
    s cmd=$$callexpr(module,action,6)
    
    n day,time,ms,now
    s now=$zh
    s day=$p(now,",",1)
    s time=$p(now,",",2)
    s ms=$p(now,",",3)

    s call(1)=$zl(b)
    s call(2)=$zl(c)
    s call(3)=$zl(d)
    s call(4)=$zl(e)
    s call(5)=$zl(f)
    m ^log(a,module,action,day,time,ms)=call

    s elapsed=$zut
    g execcall
    q

call07(module,action,a,b,c,d,e,f,g)
    n result,cmd,now,elapsed,call
    s cmd=$$callexpr(module,action,7)
    
    n day,time,ms,now
    s now=$zh
    s day=$p(now,",",1)
    s time=$p(now,",",2)
    s ms=$p(now,",",3)

    s call(1)=$zl(b)
    s call(2)=$zl(c)
    s call(3)=$zl(d)
    s call(4)=$zl(e)
    s call(5)=$zl(f)
    s call(6)=$zl(g)
    m ^log(a,module,action,day,time,ms)=call

    s elapsed=$zut
    g execcall
    q

call08(module,action,a,b,c,d,e,f,g,h)
    n result,cmd,now,elapsed,call
    s cmd=$$callexpr(module,action,8)
    
    n day,time,ms,now
    s now=$zh
    s day=$p(now,",",1)
    s time=$p(now,",",2)
    s ms=$p(now,",",3)

    s call(1)=$zl(b)
    s call(2)=$zl(c)
    s call(3)=$zl(d)
    s call(4)=$zl(e)
    s call(5)=$zl(f)
    s call(6)=$zl(g)
    s call(7)=$zl(h)
    m ^log(a,module,action,day,time,ms)=call

    s elapsed=$zut
    g execcall
    q

call09(module,action,a,b,c,d,e,f,g,h,i)
    n result,cmd,now,elapsed,call
    s cmd=$$callexpr(module,action,9)
    
    n day,time,ms,now
    s now=$zh
    s day=$p(now,",",1)
    s time=$p(now,",",2)
    s ms=$p(now,",",3)

    s call(1)=$zl(b)
    s call(2)=$zl(c)
    s call(3)=$zl(d)
    s call(4)=$zl(e)
    s call(5)=$zl(f)
    s call(6)=$zl(g)
    s call(7)=$zl(h)
    s call(8)=$zl(i)
    m ^log(a,module,action,day,time,ms)=call

    s elapsed=$zut
    g execcall
    q

call10(module,action,a,b,c,d,e,f,g,h,i,j)
    n result,cmd,now,elapsed,call
    s cmd=$$callexpr(module,action,10)
    
    n day,time,ms,now
    s now=$zh
    s day=$p(now,",",1)
    s time=$p(now,",",2)
    s ms=$p(now,",",3)

    s call(1)=$zl(b)
    s call(2)=$zl(c)
    s call(3)=$zl(d)
    s call(4)=$zl(e)
    s call(5)=$zl(f)
    s call(6)=$zl(g)
    s call(7)=$zl(h)
    s call(8)=$zl(i)
    s call(9)=$zl(j)
    m ^log(a,module,action,day,time,ms)=call

    s elapsed=$zut
    g execcall
    q


; Returns Keys and Values: Type is 2
; N Key1 Value1 Key2 Value2 ... KeyN-1 ValueN-1 KeyN ValueN
; Values may be empty
kv(result,dir,max)
    n r,total,element
    q:$d(result)'=10 0 ; if nothing returns 0
    s dir=$g(dir,1)
    s max=$g(max,500)
    s element=$o(result(""),dir)
    s r=$$pack(result(element))
    f total=1:1 s element=$o(result(element),dir) q:element=""  d:total<max
    . s r=r_$$pack(result(element))
    q r

v(result)
    q $$pack(result)

; write a integer on two bytes
; big endian
bigendian(value)
    n res s res=""
    q:'value $zch(0,0)
    f  q:'value  s res=res_$zch(value#256),value=value\256
    q:$zl(res)=2 res
    q res_$zch(0)

; write a integer on two bytes
; little endian
litendian(value)
    n res s res=""
    q:'value $zch(0,0)
    f  q:'value  s res=$zch(value#256)_res,value=value\256
    q:$zl(res)=2 res
    q $zch(0)_res

; pack a value
; prepend the value length to the value itself
pack(value)
    ; n l s l=$zl(value)
    ; n len s len=$$len(l)
    q value_$c(0)

; Errors handling
; format the error
%errors(code,message)
    q $$^errors("apiutils",code,message) 

; Build callable expression from arguments
callexpr(type,action,argcount)
    n i,args
    s args=""
    s cmd="%"_action_"^"_type_"s(.result"
    f i=1:1:argcount s args=args_","_$c(96+i) ; generate a list of 'a,b,c,d...'
    s cmd=cmd_args_")"
    q cmd

; Label to execute the call
execcall
    w $zpos," eval: ",cmd,!
     
    ; @doc Clean error
    set ($ecode,$zstatus)=""
    set $ztrap="zgoto "_$zlevel_"failure^fqids"

    ; execute the command
    do @(cmd)

    ; Call done
    w $zpos," call done time: ",$zut-elapsed,!

    ; return fail if result is empty
    if '$d(result) do error(.result,390,"f") quit

    w $zpos," data(result): ",$data(result),!

    ; @doc Check the result information.
    ; if unspecified then return as is
    if '$data(result(.1)) quit result

    ; w $zpos," $get(result(.1,1): ",$get(result(.1,1)),!
    ; @doc Check the result type and the result format
    if ($get(result(.1,1))="")!($get(result(.1,2))="") quit result

    ; n info
    ; s info(1)=type ; return the type
    ; s info(2)=id ; return the id
    ; s info(3)=argcount ; return the argcount

    ; if format is not defined return result as is
    set format=result(.1,2)
    set type=$fn(result(.1,1),"-") ; @doc Only positive values.

    ;set result("$t")="s" ; @doc Per default set result type to sucess 's'
    ;set:result(.1,1)=-1 result("$t")="f" ; @doc IF result is an error set type to failure 'f'

    ; remove subscript .1 from the final result, i.e. don't pollute
    kill result(.1) 

    new output

    if (format=1) set output=$$k1v^erlang("result") goto flush
    if (format=2) set output=$$k2v^erlang("result") goto flush
    if (format=3) set output=$$k3v^erlang("result") goto flush
    if (format=4) set output=$$k4v^erlang("result") goto flush
    if (format=5) set output=$$k5v^erlang("result") goto flush

flush
    w $zpos," encoding  time: ",$zut-elapsed,!
    quit $zchar(131,104,2,97,type)_output ; @doc Generate erlang tuple {,}

doc(result,module,action)
    new function,doc,arg,args,i

    set function="%"_action_"^"_module_"s"
    ; w $zpos," function: ",function,!
    set doc=$text(@function)

    ; @doc If function don't exists quit.
    if (doc="") quit

    ; w $zpos," text: ",doc,!
    set args=$l(doc,",")
    ; @doc Decrement, because first parameter is hidden from external.
    ; set args=args-1
    ; w $zpos," args: ",args,!

    ; @doc General case until the last parameter that contains the final right paren ')'
    f i=2:1:args-1 set arg=$p(doc,",",i) do
    . s result(i)=arg

    ; @doc Handle the last argument, remove the right paren ')'
    s arg=$p(doc,",",args)
    s arg=$tr(arg,")","")
    s result(args)=arg

    q
