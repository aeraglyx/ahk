#NoEnv
#SingleInstance Force
#Persistent
SendMode Input

Menu, Tray, icon, %A_ScriptDir%\icons\icon_cs_18px_v2.ico

1:: ;ů
if (!GetKeyState("CapsLock", "T")){
    Send, {U+016F}
} else {
    Send, {U+016E}
}
return

2:: ;ě
if (!GetKeyState("CapsLock", "T")){
    Send, {U+011B}
} else {
    Send, {U+011A}
}
return

3:: ;š
if (!GetKeyState("CapsLock", "T")){
    Send, {U+0161}
} else {
    Send, {U+0160}
}
return

4:: ;č
if (!GetKeyState("CapsLock", "T")){
    Send, {U+010D}
} else {
    Send, {U+010C}
}
return

5:: ;ř
if (!GetKeyState("CapsLock", "T")){
    Send, {U+0159}
} else {
    Send, {U+0158}
}
return

6:: ;ž
if (!GetKeyState("CapsLock", "T")){
    Send, {U+017E}
} else {
    Send, {U+017D}
}
return

:*?c:Y-::{U+00DD}
7::
:*?:y-:: ;ý
if (!GetKeyState("CapsLock", "T")){
    Send, {U+00FD}
} else {
    Send, {U+00DD}
}
return

:*?c:A-::{U+00C1}
8::
:*?:a-:: ;á
if (!GetKeyState("CapsLock", "T")){
    Send, {U+00E1}
} else {
    Send, {U+00C1}
}
return

:*?c:I-::{U+00CD}
9::
:*?:i-:: ;í
if (!GetKeyState("CapsLock", "T")){
    Send, {U+00ED}
} else {
    Send, {U+00CD}
}
return

:*?c:I-::{U+00C9}
0::
:*?:i-:: ;é
if (!GetKeyState("CapsLock", "T")){
    Send, {U+00E9}
} else {
    Send, {U+00C9}
}
return





:*?c:O-::{U+00D3}
:*?:o-:: ;ó
if (!GetKeyState("CapsLock", "T")){
    Send, {U+00F3}
} else {
    Send, {U+00D3}
}
return

:*?c:D-::{U+010E}
:*?:d-:: ;ď
if (!GetKeyState("CapsLock", "T")){
    Send, {U+010F}
} else {
    Send, {U+010E}
}
return

:*?c:N-::{U+0147}
:*?:n-:: ;ň
if (!GetKeyState("CapsLock", "T")){
    Send, {U+0148}
} else {
    Send, {U+0147}
}
return

:*?c:T-::{U+0164}
:*?:t-:: ;ť
if (!GetKeyState("CapsLock", "T")){
    Send, {U+0165}
} else {
    Send, {U+0164}
}
return

:*?c:U-::{U+00DA}
:*?:u-:: ;ú
if (!GetKeyState("CapsLock", "T")){
    Send, {U+00FA}
} else {
    Send, {U+00DA}
}
return