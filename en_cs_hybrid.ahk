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
Return

2:: ;ě
if (!GetKeyState("CapsLock", "T")){
	Send, {U+011B}
} else {
	Send, {U+011A}
}
Return

3:: ;š
if (!GetKeyState("CapsLock", "T")){
	Send, {U+0161}
} else {
	Send, {U+0160}
}
Return

4:: ;č
if (!GetKeyState("CapsLock", "T")){
	Send, {U+010D}
} else {
	Send, {U+010C}
}
Return

5:: ;ř
if (!GetKeyState("CapsLock", "T")){
	Send, {U+0159}
} else {
	Send, {U+0158}
}
Return

6:: ;ž
if (!GetKeyState("CapsLock", "T")){
	Send, {U+017E}
} else {
	Send, {U+017D}
}
Return

:*?c:Y-::{U+00DD}
7::
:*?:y-:: ;ý
if (!GetKeyState("CapsLock", "T")){
	Send, {U+00FD}
} else {
	Send, {U+00DD}
}
Return

:*?c:A-::{U+00C1}
8::
:*?:a-:: ;á
if (!GetKeyState("CapsLock", "T")){
	Send, {U+00E1}
} else {
	Send, {U+00C1}
}
Return

:*?c:I-::{U+00CD}
9::
:*?:i-:: ;í
if (!GetKeyState("CapsLock", "T")){
	Send, {U+00ED}
} else {
	Send, {U+00CD}
}
Return

:*?c:I-::{U+00C9}
0::
:*?:i-:: ;é
if (!GetKeyState("CapsLock", "T")){
	Send, {U+00E9}
} else {
	Send, {U+00C9}
}
Return





:*?c:O-::{U+00D3}
:*?:o-:: ;ó
if (!GetKeyState("CapsLock", "T")){
	Send, {U+00F3}
} else {
	Send, {U+00D3}
}
Return

:*?c:D-::{U+010E}
:*?:d-:: ;ď
if (!GetKeyState("CapsLock", "T")){
	Send, {U+010F}
} else {
	Send, {U+010E}
}
Return

:*?c:N-::{U+0147}
:*?:n-:: ;ň
if (!GetKeyState("CapsLock", "T")){
	Send, {U+0148}
} else {
	Send, {U+0147}
}
Return

:*?c:T-::{U+0164}
:*?:t-:: ;ť
if (!GetKeyState("CapsLock", "T")){
	Send, {U+0165}
} else {
	Send, {U+0164}
}
Return

:*?c:U-::{U+00DA}
:*?:u-:: ;ú
if (!GetKeyState("CapsLock", "T")){
	Send, {U+00FA}
} else {
	Send, {U+00DA}
}
Return