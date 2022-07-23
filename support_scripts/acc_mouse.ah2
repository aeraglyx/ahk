#SingleInstance Force
Persistent
#NoTrayIcon

^!+x::ExitApp

interval := 64 ; higher = less responsive
pivot := 8 ; low pivot gets easier to max speed, beyond is clamped
lim := 512 ; glitch cutoff in px, keep high. Low interval helps too.

mult := 2.0 ; top speed multiplier, 1.0 = no effect
gamma := 2.5 ; shape, 1 = linear

meh() {
	return GetKeyState("Alt", "P") && GetKeyState("Shift", "P") && GetKeyState("Control", "P")
}

CoordMode "Mouse", "Screen"
MouseGetPos &x_last, &y_last
x_diff_last := 0
y_diff_last := 0

loop {

	MouseGetPos &x_now, &y_now

	x_diff := x_now - x_last
	y_diff := y_now - y_last

	x_jerk := x_diff - x_diff_last
	y_jerk := y_diff - y_diff_last

	dist := sqrt(x_diff**2 + y_diff**2) ; length
	px := pivot * interval ; pixel change per iteration
	
	if dist = 0 {
		multiplier := 1.0
	} else {
		multiplier := min((dist / px)**gamma, 1) * px * (mult - 1) / dist
		if meh() {
			multiplier := 0.25 - 1.0
		}
	}

	if (x_jerk > lim) {
		x_acc := 0
	} else {
		x_acc := x_diff * multiplier
	}

	if (y_jerk > lim) {
		y_acc := 0
	} else {
		y_acc := y_diff * multiplier
	}

	;x_debug := min((dist / px)**gamma, 1) * px * mult / dist
	; ToolTip, %x_acc%, 256, 512

	MouseMove x_acc, y_acc, 0, "R"

	x_last := x_now + x_acc
	y_last := y_now + y_acc
	x_diff_last := x_diff
	y_diff_last := y_diff

	Sleep interval
}

return