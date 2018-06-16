usage()
    quit

len(value)
    new res set res=""
    quit:'value $zchar(0,0,0,0)
    for  quit:'value  set res=$zchar(value#256)_res,value=value\256
    quit:$ZLength(res)=4 res
    quit:$ZLength(res)=3 $zchar(0)_res
    quit:$ZLength(res)=2 $zchar(0,0)_res
    quit $zchar(0,0,0)_res

binary(value)
    new l set l=$ZLength(value)
    new len set len=$$len(l)
    quit $zchar(109)_len_value

list(count)
    quit $zchar(108)_$$len(count)


k1v(result,dir,max)
    new r,total,element
    quit:$data(result)<10 0 ; if nothing returns 0
    set dir=$Get(dir,1)
    set max=$Get(max,255)
    set element=$Order(result(""),dir)
    set r=$zchar(104,2)_$$binary(element)_$$binary(result(element))
    for total=1:1 set element=$Order(result(element),dir) quit:element=""  do:total<max
    . set r=r_$zchar(104,2)_$$binary(element)_$$binary(result(element))
    quit $zchar(131)_$zchar(108)_$$len(total)_r_$zchar(106)


k2v(gbl)
    new r,sr,total1,total2,total3,sub1,sub2,sub3
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set (r,sr,sub1,sub2,sub3)=""
    for total1=0:1 set sub1=$Order(@gbl@(sub1)) quit:sub1=""  do
    . set sr=""
    . for total2=0:1 set sub2=$Order(@gbl@(sub1,sub2)) quit:sub2=""  do
    . . set sr=sr_$zchar(104,2)_$$binary(sub2)_$$binary(@gbl@(sub1,sub2))
    . set r=r_$zchar(104,2)_$$binary(sub1)_$zchar(108)_$$len(total2)_sr_$zchar(106)
    quit $zchar(108)_$$len(total1)_r_$zchar(106)

k3v(gbl)
    new r,sr,ssr,total1,total2,total3,sub1,sub2,sub3
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set (r,sr,ssr,sub1,sub2,sub3)=""
    for total1=0:1 set sub1=$Order(@gbl@(sub1)) quit:sub1=""  do
    . set sr=""
    . for total2=0:1 set sub2=$Order(@gbl@(sub1,sub2)) quit:sub2=""  do
    . . set ssr=""
    . . for total3=0:1 set sub3=$Order(@gbl@(sub1,sub2,sub3)) quit:sub3=""  do
    . . . set ssr=ssr_$zchar(104,2)_$$binary(sub3)_$$binary(@gbl@(sub1,sub2,sub3))
    . . set sr=sr_$zchar(104,2)_$$binary(sub2)_$zchar(108)_$$len(total3)_ssr_$zchar(106)
    . set r=r_$zchar(104,2)_$$binary(sub1)_$zchar(108)_$$len(total2)_sr_$zchar(106)
    quit $zchar(108)_$$len(total1)_r_$zchar(106)

k4v(gbl)
    new r,sr,ssr,sssr,total1,total2,total3,total4,sub1,sub2,sub3,sub4
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set (r,sr,ssr,sssr,sub1,sub2,sub3,sub4)=""
    for total1=0:1 set sub1=$Order(@gbl@(sub1)) quit:sub1=""  do
    . set sr=""
    . for total2=0:1 set sub2=$Order(@gbl@(sub1,sub2)) quit:sub2=""  do
    . . set ssr=""
    . . for total3=0:1 set sub3=$Order(@gbl@(sub1,sub2,sub3)) quit:sub3=""  do
    . . . set sssr=""
    . . . for total4=0:1 set sub4=$Order(@gbl@(sub1,sub2,sub3,sub4)) quit:sub4=""  do
    . . . . set sssr=sssr_$zchar(104,2)_$$binary(sub4)_$$binary(@gbl@(sub1,sub2,sub3,sub4))
    . . . set ssr=ssr_$zchar(104,2)_$$binary(sub3)_$zchar(108)_$$len(total4)_sssr_$zchar(106)
    . . set sr=sr_$zchar(104,2)_$$binary(sub2)_$zchar(108)_$$len(total3)_ssr_$zchar(106)
    . set r=r_$zchar(104,2)_$$binary(sub1)_$zchar(108)_$$len(total2)_sr_$zchar(106)
    quit $zchar(108)_$$len(total1)_r_$zchar(106)

k5v(gbl)
    new r,sr,ssr,sssr,ssssr,total1,total2,total3,total4,total5,sub1,sub2,sub3,sub4,sub5
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set (r,sr,ssr,sssr,ssssr,sub1,sub2,sub3,sub4,sub5)=""
    for total1=0:1 set sub1=$Order(@gbl@(sub1)) quit:sub1=""  do
    . set sr=""
    . for total2=0:1 set sub2=$Order(@gbl@(sub1,sub2)) quit:sub2=""  do
    . . set ssr=""
    . . for total3=0:1 set sub3=$Order(@gbl@(sub1,sub2,sub3)) quit:sub3=""  do
    . . . set sssr=""
    . . . for total4=0:1 set sub4=$Order(@gbl@(sub1,sub2,sub3,sub4)) quit:sub4=""  do
    . . . . set ssssr=""
    . . . . for total5=0:1 set sub5=$Order(@gbl@(sub1,sub2,sub3,sub4,sub5)) q:sub5=""  do
    . . . . . set ssssr=ssssr_$zchar(104,2)_$$binary(sub5)_$$binary(@gbl@(sub1,sub2,sub3,sub4,sub5))
    . . . . set sssr=sssr_$zchar(104,2)_$$binary(sub4)_$zchar(108)_$$len(total5)_ssssr_$zchar(106)
    . . . set ssr=ssr_$zchar(104,2)_$$binary(sub3)_$zchar(108)_$$len(total4)_sssr_$zchar(106)
    . . set sr=sr_$zchar(104,2)_$$binary(sub2)_$zchar(108)_$$len(total3)_ssr_$zchar(106)
    . set r=r_$zchar(104,2)_$$binary(sub1)_$zchar(108)_$$len(total2)_sr_$zchar(106)
    quit $zchar(108)_$$len(total1)_r_$zchar(106)

%k1v(gbl,dir,max)
    new r,total,element
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set dir=$get(dir,1)
    set max=$get(max,255)
    set element=$Order(@gbl@(""),dir)
    set r=$zchar(104,2)_$$binary(element)_$$binary(@gbl@(element))
    for total=1:1 set element=$Order(@gbl@(element),dir) quit:element=""  do:total<max
    . set r=r_$zchar(104,2)_$$binary(element)_$$binary(@gbl@(element))
    quit $zchar(108)_$$len(total)_r_$zchar(106)

%k2v(gbl,dir,max)
    new r,sr,total,subtotal,element,subelement
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set dir=$Get(dir,1)
    set max=$Get(max,255)
    set (r,sr,element,subelement)=""
    for total=0:1 set element=$Order(@gbl@(element),dir) quit:element=""  do:total<max
    . set sr=""
    . for subtotal=0:1 set subelement=$Order(@gbl@(element,subelement),dir) quit:subelement=""  do
    . . set sr=$$%k1v($na(@gbl@(element)),dir,max)
    . set r=r_$zchar(104,2)_$$binary(element)_sr
    quit $zchar(108)_$$len(total)_r_$zchar(106)

%k3v(gbl,dir,max)
    new r,sr,total,subtotal,element,subelement
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set dir=$Get(dir,1)
    set max=$Get(max,255)
    set (r,sr,element,subelement)=""
    for total=0:1 set element=$Order(@gbl@(element),dir) quit:element=""  do:total<max
    . set sr=""
    . for subtotal=0:1 set subelement=$Order(@gbl@(element,subelement),dir) quit:subelement=""  do
    . . set sr=$$%k2v($na(@gbl@(element)),dir,max)
    . set r=r_$zchar(104,2)_$$binary(element)_sr
    quit $zchar(108)_$$len(total)_r_$zchar(106)

%k4v(gbl,dir,max)
    new r,sr,total,subtotal,element,subelement
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set dir=$Get(dir,1)
    set max=$Get(max,255)
    set (r,sr,element,subelement)=""
    for total=0:1 s element=$Order(@gbl@(element),dir) quit:element=""  do:total<max
    . set sr=""
    . for subtotal=0:1 set subelement=$Order(@gbl@(element,subelement),dir) quit:subelement=""  do
    . . ; w $zh," 4v: ",subelement,!
    . . set sr=$$%k3v($na(@gbl@(element)),dir,max)
    . set r=r_$zchar(104,2)_$$binary(element)_sr
    quit $zchar(108)_$$len(total)_r_$zchar(106)

%k5v(gbl,dir,max)
    new r,sr,total,subtotal,element,subelement
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set dir=$Get(dir,1)
    set max=$Get(max,255)
    set (r,sr,element,subelement)=""
    for total=0:1 s element=$Order(@gbl@(element),dir) quit:element=""  do:total<max
    . set sr=""
    . for subtotal=0:1 set subelement=$Order(@gbl@(element,subelement),dir) quit:subelement=""  do
    . . set sr=$$%k4v($na(@gbl@(element)),dir,max)
    . set r=r_$zchar(104,2)_$$binary(element)_sr
    quit $zchar(108)_$$len(total)_r_$zchar(106)

; Experimental
; e3v(gbl)
;     n r,sr,total1,total2,total3,sub1,sub2,sub3
;     q:$data(@gbl)<10 0 ; if nothing returns 0
;     s (r,sr,ssr,sub1,sub2,sub3)=""
;     f total1=0:1 s sub1=$Order(@gbl@(sub1)) q:sub1=""  d
;     . s sr=""
;     . f total2=0:1 s sub2=$Order(@gbl@(sub1,sub2)) q:sub2=""  d
;     . . s ssr=""
;     . . f total3=0:1 s sub3=$Order(@gbl@(sub1,sub2,sub3)) q:sub3=""  d
;     . . . s ssr=ssr_"^"_sub3_"^:^"_(@gbl@(sub1,sub2,sub3))_"^,"
;     . . s sr=sr_"^"_sub2_"^:["_total3_":"_ssr_"],"
;     . s r=r_"^"_sub1_"^:["_total2_":"_sr_"],"
;     q ":["_total1_":"_r_"]"

; Experimental
e2v(gbl)
    new r,sr,total1,total2,sub1,sub2
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set (r,sr,ssr,sub1,sub2,sub3)=""
    for total1=0:1 s sub1=$Order(@gbl@(sub1)) quit:sub1=""  do
    . set sub2=""
    . set sr=""
    . for total2=0:1 set sub2=$Order(@gbl@(sub1,sub2)) quit:sub2=""  do
    . . if total2 set sr=sr_","""_sub2_""":"""_$Get(@gbl@(sub1,sub2))_""""
    . . else  set sr=sr_""""_sub2_""":"""_$Get(@gbl@(sub1,sub2))_""""
    . if total1 set r=r_","""_sub1_""":{"_sr_"}"
    . else  set r=r_""""_sub1_""":{"_sr_"}"
    quit "{"_r_"}"

; Experimental
e3v(gbl)
    new r,sr,ssr,total1,total2,total3,sub1,sub2,sub3
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set (r,sr,ssr,sub1,sub2,sub3)=""
    ; s r=""""_sub1_""":{"
    ; s sub1=$Order(@gbl@(""))
    ; . s r=""""_sub1_""":{"
    for total1=0:1 set sub1=$Order(@gbl@(sub1)) quit:sub1=""  do
    . set sub2=""
    . set sr=""
    . for total2=0:1 set sub2=$Order(@gbl@(sub1,sub2)) quit:sub2=""  do
    . . set sub3=""
    . . set ssr=""
    . . for total3=0:1 set sub3=$Order(@gbl@(sub1,sub2,sub3)) quit:sub3=""  do
    . . . if total3 set ssr=ssr_","""_sub3_""":"""_$$jescape($Get(@gbl@(sub1,sub2,sub3)))_""""
    . . . else  set ssr=ssr_""""_sub3_""":"""_$$jescape($Get(@gbl@(sub1,sub2,sub3)))_""""
    . . if total2 set sr=sr_","""_sub2_""":{"_ssr_"}"
    . . else  set sr=sr_""""_sub2_""":{"_ssr_"}"
    . if total1 set r=r_","""_sub1_""":{"_sr_"}"
    . else  set r=r_""""_sub1_""":{"_sr_"}"
    quit "{"_r_"}"

e4v(gbl)
    new r,sr,ssr,sssr,total1,total2,total3,total4,sub1,sub2,sub3,sub4
    quit:$data(@gbl)<10 0 ; if nothing returns 0
    set (r,sr,ssr,sssr,sub1,sub2,sub3,sub4)=""
    for total1=0:1 s sub1=$Order(@gbl@(sub1)) quit:sub1=""  do
    . set sub2=""
    . set sr=""
    . for total2=0:1 set sub2=$Order(@gbl@(sub1,sub2)) quit:sub2=""  do
    . . set sub3=""
    . . set ssr=""
    . . for total3=0:1 set sub3=$Order(@gbl@(sub1,sub2,sub3)) quit:sub3=""  do
    . . . set sub4=""
    . . . set sssr=""
    . . . for total4=0:1 set sub4=$Order(@gbl@(sub1,sub2,sub3,sub4)) quit:sub4=""  do
    . . . . if total4 set sssr=sssr_","""_sub4_""":"""_$Get(@gbl@(sub1,sub2,sub3,sub4))_""""
    . . . . else  set sssr=sssr_""""_sub4_""":"""_$Get(@gbl@(sub1,sub2,sub3,sub4))_""""
    . . . if total3 set ssr=ssr_","""_sub3_""":{"_sssr_"}"
    . . . else  set ssr=ssr_""""_sub3_""":{"_sssr_"}"
    . . if total2 set sr=sr_","""_sub2_""":{"_ssr_"}"
    . . else  set sr=sr_""""_sub2_""":{"_ssr_"}"
    . if total1 set r=r_","""_sub1_""":{"_sr_"}"
    . else  set r=r_""""_sub1_""":{"_sr_"}"
    quit "{"_r_"}"

; Return an escaped JSON string
jescape(txt)
    quit:txt="" ""
    ; q:txt?.N txt

    new escaped,i,a,len
    set escaped="",len=$ZLength(txt)
    if len=1 quit txt

    for i=1:1:len do
    . set a=$ZAscii(txt,i)
    . if ((a>31)&(a'=34)&(a'=92)) set escaped=escaped_$zchar(a)
    . else  set escaped=escaped_"\u00"_$$FUNC^%DH(a,2)

    quit escaped


test(mode)
    new t 
    set t=$$binary("abcdef")

    new result
    set result("k")="v"
    set result("k2")="v2"
    set t=$$k1v(.result)
    
    if mode=1 do 
    . set result(1,"k")="v"
    . set gbl="result(1)"
    . set t=$$%k1v(gbl)
    ; . zwr t 

    if mode=2 do
    . kill result
    . set result("one","type")="number"
    . set result("one","func")="execut"
    . set result("two","type")="string"
    . set result("two","func")="execut"
    . set gbl="result"
    . set t=$$e2v(gbl)
    ; . s t=$$%k2v(gbl)
    ; . zwr t

    if mode=3 do
    . kill result
    . set result("one",1,"type")="number1"
    . set result("one",1,"func")="execut2"
    . set result("one",2,"type")="number3"
    . set result("one",2,"func")="execut4"
    . set result("two",1,"type")="string5"
    . set result("two",1,"func")="execut6"
    . set result("two",2,"type")="string7"
    . set result("two",2,"func")="execut8"
    . set gbl="result"
    . set t=$$k3v(gbl)
    ; . s t=$$%k3v(gbl)
    ; . zwr t

    ; k result 
    ; d %discoverMedia^timelines("63816H1pqoaTjQ0BQJ3gW63816778412",.result,1002,"photo,article,message") 
    ; s gbl="result"
    ; k result("$$")
    ; s t=$$%k3v(gbl)
    ; zwr t

    if mode=4 do
    . kill result
    . set result("2015","01","01","33")="33"
    . set result("2015","01","02","34")="34"
    . set result("2015","01","03","35")="35"
    . set result("2015","02","01","10")="10"
    . set result("2015","02","01","11")="11"
    . set result("2015","02","01","12")="12"
    . set gbl="result"
    . set t=$$e4v(gbl)
    ; . s t=$$k4v(gbl)
    ; . s t=$$%k4v(gbl)
    ; . zwr t
    
    if mode=5 do
    . kill result
    . ; s result("2015","01","01","key","value")="photo"
    . ; s result("2015","01","01","key","type")="string"
    . ; s result("2015","01","01","key","date")="1"
    . ; s result("2016","01","01","key","value")="photo"
    . ; s result("2016","01","01","key","type")="string"
    . ; s result("2016","01","01","key","date")=2
    . ; s result("2016","02","01","key","value")="photo"
    . ; s result("2016","02","01","key","type")="string"
    . ; s result("2016","02","01","key","date")=3
    . ; s result("2016","02","01","key","value")="photo"
    . ; s result("2016","02","01","key","type")="string"
    . ; s result("2116","02","01","key","date")=3
    . ; s result("2117","02","01","key","value")="photo"
    . ; s result("2117","02","01","key","type")="string"
    . ; s result("2117","02","01","key","date")=3
    . ; s result("2117","02","01","key","value")="photo"
    . ; s result("2117","02","01","key","type")="string"
    . ; s result("2117","02","01","key","date")=3
    . ; s result("2117","02","01","key","date")=3
    . ; s result("2127","02","01","key","date")=3
    . ; s result("2127","02","01","key","date")=3
    . ; s result("2127","02","01","key","date")=3
    . ; s result("2127","02","01","key","date")=3
    . ; s result("2127","02","01","key","date")=3
    . ; s result("2127","02","01","key","date")=3
    . ; s result("2127","02","01","key","date")=3
    . ; s result("2127","02","01","key","date")=3
    . ; s gbl="result"
    . set gbl=$NAme(^bench(0))
    . set t=$$k5v(gbl)
    ; . s t=$$%k5v(gbl)
    ; . zwr t

    if mode="result" do
    . kill result
    . set result(0,"activity","likes")=1
    . set result(0,"activity","rate")=5
    . set result(0,"api","id")="123DvVkKpgUHYmMGrdE4p64221I60441"
    . set result(0,"api","type")="app"
    . set result(0,"author","avatar")=""
    . set result(0,"author","hid")=""
    . set result(0,"author","sex")=""
    . set result(1,"activity","likes")=1
    . set result(1,"activity","rate")=5
    . set result(1,"api","id")="123DvVkKpgUHYmMGrdE4p64221I60441"
    . set result(1,"api","type")="app"
    . set result(1,"author","avatar")=""
    . set result(1,"author","hid")=""
    . set result(1,"author","sex")=""
    . set result(0,"info","author")=123
    . set result(0,"info","avatar")="http://cdn.harmony-dev.com/harmony-zfmvaiwqnj.png"
    . set result(0,"info","bundle")="com.harmony.zfmvaiwqnj"
    . set result(0,"info","category")="store"
    . set result(0,"info","datetime")=1477846041
    . set result(0,"info","description")="New version of zfmvaiwqnj !"
    . set result(0,"info","parent")="?00054123GGW51j4CNBoHxwF8or64221U61378"
    . set result(0,"info","rating")=5
    . set result(0,"info","screenshots")=0
    . set result(0,"info","title")="Harmonyzfmvaiwqnj"
    . set result(0,"info","usersCount")=0
    . set result(0,"options","commentflag")=1
    . set result(0,"options","rateflag")=1
    . set result(0,"options","shareflag")=1
    . set result(0,"source","author")=123
    . set result(0,"source","avatar")="http://cdn.harmony-dev.com/harmony-drjmoeqihi.png"
    . set result(0,"source","datetime")=1477846978
    . set result(0,"source","title")=""
    . set result(0,"stats","likes")=1
    . set result(1,"activity","likes")=1
    . set result(1,"activity","rate")=5
    . set result(1,"api","id")="173eUnhEFCOWwGMgPktbE64221S57743"
    . set result(1,"api","type")="testimonial"
    . set result(1,"author","avatar")=""
    . set result(1,"author","hid")=""
    . set result(1,"author","sex")=""
    . set result(1,"info","author")=173
    . set result(1,"info","avatar")="http://cdn.harmony-dev.com/harmony-zfmvaiwqnj.png"
    . set result(1,"info","bundle")="com.harmony.zfmvaiwqnj"
    . set result(1,"info","category")="store"
    . set result(1,"info","datetime")=1477843343
    . set result(1,"info","description")="Description"
    . set result(1,"info","parent")="%00054123RnvBkq1LeLxZ38Q64864221P57743"
    . set result(1,"info","rating")=5
    . set result(1,"info","screenshots")=0
    . set result(1,"info","title")="Title"
    . set result(1,"info","usersCount")=0
    . set result(1,"options","commentflag")=1
    . set result(1,"options","rateflag")=1
    . set result(1,"options","shareflag")=1
    . set result(1,"source","author")=123
    . set result(1,"source","avatar")="http://cdn.harmony-dev.com/harmony-sl5vgg9wb2.png"
    . set result(1,"source","datetime")=1477843343
    . set result(1,"source","title")=""
    . set result(1,"stats","likes")=1
    . set gbl="result"
    . set t=$$e3v(gbl)
    ; . s t=$$k3v(gbl)
    ; . s t=$$%k3v(gbl)

    quit:$quit t
    ; q:$quit $zchar(131)_t
    quit

