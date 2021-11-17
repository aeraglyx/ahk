#NoEnv
#SingleInstance Force
#Persistent
;#NoTrayIcon

interval := 64 ; higher = less responsive
pivot := 8 ; low pivot gets easier to max speed, beyond is clamped
lim := 512 ; glitch cutoff in px, keep high. Low interval helps too.

mult := 1.8 ; top speed multiplier, 1.0 = no effect
gamma := 2.5 ; shape, 1 = linear

loop {
	CoordMode, Mouse, Screen
	MouseGetPos, x_now, y_now

	x_diff := x_now - x_last
	y_diff := y_now - y_last

	x_jerk := x_diff - x_diff_last
	y_jerk := y_diff - y_diff_last

	dist := sqrt(x_diff**2 + y_diff**2) ; length
	px := pivot * interval ; pixel change per iteration

	multiplier := min((dist / px)**gamma, 1) * px * (mult - 1) / dist

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

	MouseMove, x_acc, y_acc, 0, Relative
	MouseGetPos, x_last, y_last
	;x_last := x_now + x_acc
	;y_last := y_now + y_acc
	; Why the f doesn't this work instead of MouseGetPos?

	x_diff_last := x_diff
	y_diff_last := y_diff

	Sleep, interval
}

Return