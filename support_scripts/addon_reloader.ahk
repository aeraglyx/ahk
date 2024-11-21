; Copy over addons and restart Blender

^!+a::
XButton1 & F5:: {

	; MsgBox(A_ComputerName)
	
	switch A_ComputerName {
		case "FULCRUM":
			git := "X:\git"
			versions := [3.4, 3.5]
			addons := ["fulcrum"]
			blender_exe := newest_blender()
		case "BBP-P-N04":
			; git := "X:\_soft\git"
			git := "C:\Users\BBP-P-N04\Desktop\git"
			versions := [4.2, 4.3]
			addons := ["bbptools"]
			blender_exe := "C:\Program Files\Blender Foundation\Blender 4.3\blender.exe"
		case "BBP-N3":
			git := "C:\Users\user\Desktop\aeraglyx\git"
			versions := [4.2]
			addons := ["fulcrum", "bbproducer"]
			; TODO blender_exe
		case "BEN":
			git := "C:\Users\Aeraglyx\Desktop\git"
			versions := [3.4, 3.5]
			addons := ["fulcrum"]
			; TODO blender_exe
	}
	
	ProcessClose "blender.exe"  ; XXX kinda dangerous > ask user? And close all instances?
	for version in versions {
		for addon in addons {
			src := git . "\" . addon
			dst := A_AppData . "\Blender Foundation\Blender\" . round(version, 1) . "\scripts\addons\" . addon
			if DirExist(dst) {
				DirDelete dst, 1
			}
			DirCopy src, dst, 1
		}
	}

	run(blender_exe)
	TrayTip("Addon updater", "Done.")
}