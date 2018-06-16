; errors management

error(result,module,id,message)
    ; @doc set format to keyvalue
    ; set type to error: 1

    s result(.1,1)=-1
    s result(.1,2)=1
    s result("eid")=$$shrt(module)_id
    s result("description")=message
    q 

shrt(value)
    n up,lo
    set lo="abcdefghijklmnopqrstuvwxyz"
    set up="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    s value=$ztr(value,lo,up)
    q $e(value,1)_$ztr(value,"AEOUIY")
