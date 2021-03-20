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

    r_lin := round(filmic_2_lin_v2(r_int), 6)
    g_lin := round(filmic_2_lin_v2(g_int), 6)
    b_lin := round(filmic_2_lin_v2(b_int), 6)

    bl_copy := "[" r_lin ", " g_lin ", " b_lin ", 1.000000]"

    x_txt := x + 24 ; offset to the right
    y_txt := y
    
    ToolTip, R = %r_lin%`nG = %g_lin%`nB = %b_lin%, %x_txt%, %y_txt%

    ;/*
    if (GetKeyState("LCtrl" , "P") && GetKeyState("c" , "P")) {
        clipboard := ""
        clipboard := bl_copy
        ClipWait
        TrayTip , Colour Picker, Copied!, 1
        ;MsgBox, Copied
        ;[0.500000, 0.500000, 0.500000, 1.000000]
    }
    */
    ; Sleep, 32
    
}

return