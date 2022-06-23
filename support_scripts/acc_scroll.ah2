#SingleInstance Force
#Persistent
#NoTrayIcon

thr := 16 ; fastest scroll [ms]
min :=  2 ; min scroll
max := 12 ; max scroll
exp := 32 ; spread, higher => bigger effect

last_down := A_TickCount - 1000
last_up := last_down

lines(x, thr, min, max, exp) {
	out := round((max - min) * exp((thr - x) / exp)) + min
	return out
}

WheelDown:: {
	diff := A_TickCount - last_down
	n := lines(diff, thr, min, max, exp)
	Send, {WheelDown %n%}
	last_down := A_TickCount
	; ToolTip, down`nd = %diff%`nn = %n%
}

WheelUp:: {
	diff := A_TickCount - last_up
	n := lines(diff, thr, min, max, exp)
	Send, {WheelUp %n%}
	last_up := A_TickCount
	; ToolTip, up`nd = %diff%`nn = %n%
}