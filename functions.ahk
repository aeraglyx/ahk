sign(x) {
	return (x > 0) ? 1 : (x < 0) ? -1 : 0
}

/*
base64to10(b64) {
	static char := "-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	local k, ck, n, b10
	n := strlen(b64)
	b10 := 0
	for k, ck in strsplit(b64)	{
		ck := instr(char, ck, true) - 1
		b10 += 64**(n-k)*ck
	}
	return b10
}
base10to64(b10) {
	static char := "-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	local b64
	loop {
		b64 := SubStr(char, (b10 & 63) + 1, 1) . b64
		b10 >>= 6
	} until !b10
	return b64
}

XButton1 & v::
t = %A_NowUTC% 
t -= 19700101000000, Seconds
t := base10to64(t)
;MsgBox, %t%
Send, %t%
return
*/



; 2021.03.11
; 2021-03-11
; 2021_03_11
; 20210311