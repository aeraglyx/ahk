; system
XButton1 & Volume_Down::
Send, {Volume_Down 20}
Return
XButton1 & Volume_Up::
Send, {Volume_Up 20}
Return

XButton1 & e::
;Send, {LWinDown}{LWinUp}night light{Enter}
Run, ms-settings:nightlight
Sleep, 250
Send, {Tab 3}{Enter}
Send, !{F4}
return

RAlt::Down


; info
:o:vm::Vladislav Mac{U+00ED}{U+010D}ek
:o:@me::vladislav.cam{2}{4}{@}gmail.com
:o*:v_m::v_macicek{Tab}
:o*:(::(){Left}

; format
:r*?:ttt::
FormatTime, time_now,, yyyyMMdd_HHmmss
SendInput, %time_now%
return

:r*?:mrcl::
FormatTime, date_now,, yyyyMMdd
SendInput, %date_now%
Send, _title_v_macicek_v01{Left 14}{Shift Down}{Left 5}{Shift Up}
return
:r*?:avcf::
Send, v_macicek_AV2FC_cviceni_2_v01{Left 4}{Shift Down}{Left}{Shift Up}
return

; websites

/*XButton1::
Run, https://keep.google.com/u/0/
return


*/

#g::
XButton1 & f::
;XButton1::
Run, https://www.google.com/
return

XButton1 & d::
Run, https://drive.google.com/drive/my-drive
return

#y::
XButton1 & t::
Run, https://www.youtube.com/
Sleep, 2000
Send, {Tab 4}           
return
#o::
XButton1 & w::
Run, https://www.youtube.com/playlist?list=WL
return

#n::
Run, https://www.notion.so/
return
XButton1::
Run, https://www.notion.so/Ideas-c162763c26ce4077a4eb4c55e6eedfb2
return

; latex
:o:ltx::/latex{Down}{Enter} 
:o:frac::\frac{{}{}}{{}{}}{Left 3}
:ro:fn::f(x)=
:ro:finv::f^{-1}(x)=

; scroll
;Scroll:


; After Effects
XButton1 & a::
Send, ^!y
Send, {Enter}glow{Enter}
Send, ^!y
Send, {Enter}chroma{Enter}
Send, ^!y
Send, {Enter}lin2log{Enter}
Send, ^!y
Send, {Enter}grain{Enter}
Send, ^!y
Send, {Enter}grade{Enter}
Return
