#Requires AutoHotkey v2.0

filePath := "\debug\MouseCoordinates.txt"

~LButton::
{
    MouseGetPos &x, &y
    text := "X: " x " Y: " y "`n"
    FileAppend text, filePath
    Tooltip "Saved: " text
    Sleep 1000
    Tooltip ""
}
return
