#NoEnv
#SingleInstance Force
#NoTrayIcon

interval := 64 ; higher = smoother input but less responsive
pivot := 8 ; low pivot gets easier to max speed, beyong is clamped
mult := 3.0 ; high-end speed multiplier
gamma := 3.0 ; shape

loop {
    CoordMode, Mouse, Screen
    MouseGetPos, x_now, y_now

    x_diff := x_now - x_last
    y_diff := y_now - y_last

    diff := sqrt(x_diff**2 + y_diff**2) ; length
    px := pivot * interval ; pixel change per iteration

    multiplier := min((diff / px)**gamma, 1) * px * (mult - 1) / diff

    x_acc := x_diff * multiplier
    y_acc := y_diff * multiplier

    ;x_debug := min((diff / (pivot*interval))**gamma, 1) * x_diff / diff
    ;ToolTip, x_debug = %x_debug%, 300, 800

    MouseMove, x_acc, y_acc, 0, Relative

    MouseGetPos, x_last, y_last
    Sleep, interval
}

return