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

; debug := x
; MsgBox, %debug%
;/*
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

    x_txt := x + 24 ; offset to the right
    y_txt := y
    
    ToolTip, R = %r_lin%`nG = %g_lin%`nB = %b_lin%, %x_txt%, %y_txt%

    if (GetKeyState("LCtrl" , "P") && GetKeyState("c" , "P")) {
        clipboard := ""
        clipboard := bl_copy
        ClipWait
        ; TrayTip , Colour Picker, Copied!, 1
    }
    ;Sleep, 16
}
*/
/*
loop {

    MouseGetPos, x_orig, y_orig

    n := 9
    i := 0
    loop, %n% {
        PixelGetColor, col, %x_orig%, %y_orig%, RGB

        r_int := Format("{1:u}", "0x" SubStr(col, 3, 2))
        g_int := Format("{1:u}", "0x" SubStr(col, 5, 2))
        b_int := Format("{1:u}", "0x" SubStr(col, 7, 2))

        r_full += r_int
        g_full += g_int
        b_full += b_int
    }

    r_full /= n
    g_full /= n
    b_full /= n

    r_lin := filmic_2_lin(round(r_full))
    g_lin := filmic_2_lin(round(g_full))
    b_lin := filmic_2_lin(round(b_full))

    ;bl_copy := "[" r_lin ", " g_lin ", " b_lin ", 1.000000]"
    ; Blender uses this format
    ; [0.500000, 0.500000, 0.500000, 1.000000]

    x_txt := x_orig + 24 ; offset to the right
    y_txt := y_orig
    
    ToolTip, R = %r_lin%`nG = %g_lin%`nB = %b_lin%, %x_txt%, %y_txt%

    if (GetKeyState("LCtrl" , "P") && GetKeyState("c" , "P")) {
        clipboard := ""
        clipboard := bl_copy
        ClipWait
        ; TrayTip , Colour Picker, Copied!, 1
    }
    
}
*/
return