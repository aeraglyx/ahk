#NoEnv
#SingleInstance Force
#Persistent
#NoTrayIcon

thr := 16 ; fastest scroll [ms]
max := 8 ; max scroll
exp := 16 ; spread, higher => bigger effect

last_down := A_TickCount - 1000
last_up := last_down

WheelDown::
	diff := A_TickCount - last_down
	n := ceil((max)*exp((- max(diff, thr) + thr)/exp))
	if WinActive("ahk_exe Fusion.exe")
		Send, ^{WheelDown %n%}
	else
		Send, {WheelDown %n%}
	last_down := A_TickCount
	;ToolTip, down`nd = %diff%`nn = %n%
	return

WheelUp::
	diff := A_TickCount - last_up
	n := ceil((max)*exp((- max(diff, thr) + thr)/exp))
	if WinActive("ahk_exe Fusion.exe")
		Send, ^{WheelUp %n%}
	else
		Send, {WheelUp %n%}
	last_up := A_TickCount
	;ToolTip, up`nd = %diff%`nn = %n%
	return