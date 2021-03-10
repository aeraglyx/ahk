#NoEnv
#SingleInstance Force

i_min := 15 ; fastest scroll
;i_max := 250
o_max := 8 ; max scroll
exp := 0.04

WheelDown::
diff := A_TickCount - last
n := ceil((o_max)*exp(exp*(- max(diff, i_min) + i_min)))
Send, {WheelDown %n%}
last := A_TickCount
;debug
;ToolTip, down`nd = %diff%`nn = %n%
return

WheelUp::
diff := A_TickCount - last
n := ceil((o_max)*exp(exp*(- max(diff, i_min) + i_min)))
Send, {WheelUp %n%}
last := A_TickCount
;debug
;ToolTip, up`nd = %diff%`nn = %n%
return