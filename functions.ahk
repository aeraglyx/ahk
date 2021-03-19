; CONSTANTS
e :=  2.71828182846
pi := 3.14159265359
tau := 6.28318530718

; MATHS
sign(x) {
	return (x > 0) ? 1 : (x < 0) ? -1 : 0
}

; COLOUR
sRGB_2_lin(x) {
    return (x <= 0.04045) ? x/12.92 : ((x + 0.055)/1.055)**2.4
}
lin_2_sRGB(x) {
    return (x <= 0.0031308) ? x*12.92 : 1.055*x**(1/2.4) - 0.055
}