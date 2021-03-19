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
    return - 0.000175781*(1 - e**(11.4369*x))
}
filmic_2_lin(x) {
    tmp := (acos(1-2*x**0.025)/pi)**5.8
    return filmic_log_2_lin(tmp)
}


;bl_col_check := False
;#MaxThreadsPerHotkey 2
;XButton1 & b::
;bl_col_check := !bl_col_check

loop {

    MouseGetPos, x, y
    PixelGetColor, col, %x%, %y%, RGB

    r_srgb := Format("{1:u}", "0x" SubStr(col, 3, 2))/255
    g_srgb := Format("{1:u}", "0x" SubStr(col, 5, 2))/255
    b_srgb := Format("{1:u}", "0x" SubStr(col, 7, 2))/255

    r := round(filmic_2_lin(r_srgb), 2)
    g := round(filmic_2_lin(g_srgb), 2)
    b := round(filmic_2_lin(b_srgb), 2)

    x_txt := x + 24 ; offset to the right
    y_txt := y

    ToolTip, R = %r%`nG = %g%`nB = %b%, %x_txt%, %y_txt%
    
}

;RemoveToolTip:
;b    ToolTip

return