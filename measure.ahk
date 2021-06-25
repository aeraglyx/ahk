#NoEnv
#SingleInstance Force
#Persistent

CoordMode, Mouse, Screen
MouseGetPos, x0, y0

SetTimer, Timer, 32
; Return

Timer:
	MouseGetPos, x1, y1
	x := Abs(x1 - x0)
	y := Abs(y1 - y0)
	l := Round(Sqrt((x) ** 2 + (y) ** 2), 2)
	ToolTip, % "x = " . x . "; y = " . y . "`nlength = " . l, x1 + 24, y1
	Return

LButton::
	Clipboard := l
	ClipWait
	ExitApp

$Esc::
RButton::
	ExitApp