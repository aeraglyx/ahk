#NoEnv
#SingleInstance Force
#Persistent
SendMode Input
;#NoTrayIcon


global e :=  2.71828182846
global pi := 3.14159265359

sRGB2lin(x) {
    return (x <= 0.04045) ? x/12.92 : ((x + 0.055)/1.055)**2.4
}
lin2sRGB(x) {
    return (x <= 0.0031308) ? x*12.92 : 1.055*x**(1/2.4) - 0.055
}
filmic_log_2_lin(x) {
    return 2**(16.5*x - 12.473931188)
}
filmic_2_lin(x) {
    tmp := (acos(1-2*x**0.025)/pi)**5.8
    return filmic_log_2_lin(tmp)
}

filmic_2_lin_v2(x) {
    line := x + 1
    FileReadLine, out, support_files\test.txt, %line%
    return %out%
}



;debug := x
;MsgBox, %debug%

loop {

    MouseGetPos, x, y
    PixelGetColor, col, %x%, %y%, RGB

    r_int := Format("{1:u}", "0x" SubStr(col, 3, 2))
    g_int := Format("{1:u}", "0x" SubStr(col, 5, 2))
    b_int := Format("{1:u}", "0x" SubStr(col, 7, 2))

    r := round(filmic_2_lin_v2(r_int), 2)
    g := round(filmic_2_lin_v2(g_int), 2)
    b := round(filmic_2_lin_v2(b_int), 2)

    x_txt := x + 24 ; offset to the right
    y_txt := y

    ToolTip, %col%`nR = %r%`nG = %g%`nB = %b%, %x_txt%, %y_txt%

    ; Sleep, 32
    
}

return