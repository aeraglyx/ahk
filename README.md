# AutoHotkey Scripts

My janky scripts for improved eFFiCieNcY. Made for [AHK v2](https://www.autohotkey.com).

The rest of this *readme* is a bit out of date since the v2 refactor...


## Notes

To disable `#g` ([source](https://www.reddit.com/r/WindowsHelp/comments/108ngxr/properly_uninstalling_xbox_gamebar_and_resolve/)):
```
Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR /f /t REG_DWORD /v "AppCaptureEnabled" /d 0
reg add HKEY_CURRENT_USER\System\GameConfigStore /f /t REG_DWORD /v "GameDVR_Enabled" /d 0
```


## Main Script `main.ahk`

This is the script that calls other sub-scripts and contains the most important hotkeys.

Some of the functionality:
- App launcher to mimic parts of my [Linux dotfiles](https://github.com/aeraglyx/dotfiles)
- Search on Google, Wolfram Alpha, YouTube, Spotify
- Switches for Night light & Focus assist
- Hotkeys for AE, LaTeX, Python
- Hotstrings for `≤`, `≥`, `≈`, `≠`, `±`
- Reloading Blender and copying folders for addon development
- Multiplicative volume control
- GUI for what song is playing and volume


## Scroll Wheel Acceleration

Makes scrolling way faster and easier. There's no going back.


## Mouse Acceleration

Similar to the above but for mouse movement. Slow mouse movements remain the same, fast movements get faster. Can be unreliable in some circumstances (if other software controls mouse position).


## Measure Tool

For measuring distances on screen in pixels. The value gets automatically saved to clipboard. Default hotkey - `XButton1`+`M`.


## Colour Picker

Colour picker/checker that can "see" through Filmic in Blender. While running, `Ctrl`+`C` copies the data so you can paste it in any Blender colour input. Works only with Filmic + Medium Contrast (aka None). Default hotkey - `XButton1`+`C`.


---
Live long and prosper 🖖
