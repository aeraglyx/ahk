#NoEnv
#SingleInstance Force
#NoTrayIcon

min := 15 ; fastest scroll
max := 8 ; max scroll
exp := 16 ; how much

last := 0

WheelDown::
diff := A_TickCount - last
n := ceil((max)*exp((- max(diff, min) + min)/exp))
Send, {WheelDown %n%}
last := A_TickCount
;ToolTip, down`nd = %diff%`nn = %n%
return

WheelUp::
diff := A_TickCount - last
n := ceil((max)*exp((- max(diff, min) + min)/exp))
Send, {WheelUp %n%}
last := A_TickCount
;ToolTip, up`nd = %diff%`nn = %n%
return