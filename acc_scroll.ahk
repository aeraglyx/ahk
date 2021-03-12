#NoEnv
#SingleInstance Force
#NoTrayIcon

thr := 15 ; fastest scroll
max := 10 ; max scroll
exp := 18 ; how much

last_down := A_TickCount - 1000
last_up := last_down

WheelDown::
diff := A_TickCount - last_down
n := ceil((max)*exp((- max(diff, thr) + thr)/exp))
Send, {WheelDown %n%}
last_down := A_TickCount
;ToolTip, down`nd = %diff%`nn = %n%
return

WheelUp::
diff := A_TickCount - last_up
n := ceil((max)*exp((- max(diff, thr) + thr)/exp))
Send, {WheelUp %n%}
last_up := A_TickCount
;ToolTip, up`nd = %diff%`nn = %n%
return