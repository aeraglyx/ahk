#SingleInstance Force
Persistent
#NoTrayIcon

^!+x::ExitApp

thr := 16 ; fastest scroll [ms]
speed_min :=  1 ; min scroll speed
speed_max := 12 ; max scroll speed
shaping := 32 ; spread, higher => bigger effect

global last_down := A_TickCount - 1000
global last_up := last_down

lines(x, thr, speed_min, speed_max, shaping) {
	out := round((speed_max - speed_min) * exp((thr - x) / shaping)) + speed_min
	return out
}

WheelDown:: {
	diff := A_TickCount - last_down
	n := lines(diff, thr, speed_min, speed_max, shaping)
	Click "WheelDown", n
	global last_down := A_TickCount
	; ToolTip "down`nd = " . diff . "`nn = " . n
}

WheelUp:: {
	diff := A_TickCount - last_up
	n := lines(diff, thr, speed_min, speed_max, shaping)
	Click "WheelUp", n
	global last_up := A_TickCount
	; ToolTip "up`nd = " . diff . "`nn = " . n
}