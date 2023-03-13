#SingleInstance Force
#Persistent
;SendMode Input
Menu, Tray, icon, %A_ScriptDir%\..\icons\col_bl_18px_v1.ico

filmic_2_lin(x) {
	line := x + 1
	FileReadLine, out, support_files\test.txt, %line%
	; 0.00017578125003936407
	; TODO other looks, Log, sRGB & switching between them
	return %out%
}

; sRGB_2_lin(x) {
; 	return (x <= 0.04045) ? x / 12.92 : ((x + 0.055) / 1.055) ** 2.4
; }

copy := 0
state_prev := 0

loop {

	if (GetKeyState("Tab", "P")) {
		if (state_prev == 0) {
			copy += 1
			if (copy > 1){
				copy := 0
			}
		}
		state_prev := 1
	} else {
		state_prev := 0
	}

	MouseGetPos, x, y
	PixelGetColor, col, %x%, %y%, RGB

	hex := "#" . SubStr(col, 3, 6)

	r_int := Format("{1:u}", "0x" SubStr(col, 3, 2))
	g_int := Format("{1:u}", "0x" SubStr(col, 5, 2))
	b_int := Format("{1:u}", "0x" SubStr(col, 7, 2))

	r_lin := round(filmic_2_lin(r_int), 6)
	g_lin := round(filmic_2_lin(g_int), 6)
	b_lin := round(filmic_2_lin(b_int), 6)

	; Blender uses this format [0.500000, 0.500000, 0.500000, 1.000000]
	bl_copy := "[" r_lin ", " g_lin ", " b_lin ", 1.000000]"

	r_txt := round(r_lin, 2)
	g_txt := round(g_lin, 2)
	b_txt := round(b_lin, 2)

	x_pos := x + 24 ; offset to the right
	y_pos := y

	if (copy == 0){
		copy_type := "Copying HEX"
	} else {
		copy_type := "Copying FILMIC"
	}

	ToolTip, %hex%`nR = %r_txt% | G = %g_txt% | B = %b_txt%`n%copy_type%, x_pos + 24, y_pos

	if (GetKeyState("LCtrl" , "P") && GetKeyState("c" , "P")) {
		clipboard := ""
		if (copy == 0) {
			clipboard := hex
		} else {
			clipboard := bl_copy
		}
		ClipWait
	}

	if (GetKeyState("Esc" , "P")){
		ExitApp
	}
}

Return