#NoEnv
#SingleInstance Force
#Persistent
;SendMode Input
Menu, Tray, icon, %A_ScriptDir%\icons\col_bl_18px_v1.ico

filmic_2_lin(x) {
    line := x + 1
    FileReadLine, out, support_files\test.txt, %line%
    ; 0.00017578125003936407
    ; TODO other looks, Log, sRGB & switching between them
    return %out%
}

loop {

    MouseGetPos, x, y
    PixelGetColor, col, %x%, %y%, RGB

    r_int := Format("{1:u}", "0x" SubStr(col, 3, 2))
    g_int := Format("{1:u}", "0x" SubStr(col, 5, 2))
    b_int := Format("{1:u}", "0x" SubStr(col, 7, 2))

    r_lin := round(filmic_2_lin(r_int), 6)
    g_lin := round(filmic_2_lin(g_int), 6)
    b_lin := round(filmic_2_lin(b_int), 6)

    bl_copy := "[" r_lin ", " g_lin ", " b_lin ", 1.000000]"
    ; Blender uses this format
    ; [0.500000, 0.500000, 0.500000, 1.000000]

    r_txt := round(r_lin, 2)
    g_txt := round(g_lin, 2)
    b_txt := round(b_lin, 2)

    x_txt := x + 24 ; offset to the right
    y_txt := y
    
    ToolTip, R = %r_txt%`nG = %g_txt%`nB = %b_txt%, %x_txt%, %y_txt%

    if (GetKeyState("LCtrl" , "P") && GetKeyState("c" , "P")) {
        clipboard := ""
        clipboard := bl_copy
        ClipWait
        ; TrayTip , Colour Picker, Copied!, 1
    }
    ;Sleep, 16
}

return