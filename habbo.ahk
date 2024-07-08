#Requires AutoHotkey v2

handFurniPath := A_ScriptDir . "\images\handfurnis\"
handFurniPaths := Map(
    "Club Sofa", handFurniPath "clubSofa.png",
    "Cola Machine", handFurniPath "colaMachine.png",
    "Dicemaster", handFurniPath "dicemaster.png",
    "Imperial Teleport", handFurniPath "imperialTeleport.png",
    "Majestic Chair", handFurniPath "majesticChair.png",
    "Mochamaster", handFurniPath "mochamaster.png",
    "Oil Lamp", handFurniPath "oilLamp.png",
    "Petal Patch", handFurniPath "petalPatch.png",
    "Purple Pillow", handFurniPath "purplePillow.png",
    "Study Desk", handFurniPath "studyDesk.png",
    "Throne Sofa", handFurniPath "throneSofa.png",
    "Tubmaster", handFurniPath "tubmaster.png"
)

handFurniOffsets := Map(
    "Club Sofa", [15, 13],
    "Cola Machine", [8, 15],
    "Dicemaster", [11, 15],
    "Imperial Teleport", [7, 15],
    "Majestic Chair", [10, 15],
    "Mochamaster", [8, 15],
    "Oil Lamp", [6, 15],
    "Petal Patch", [15, 9],
    "Purple Pillow", [5, 15],
    "Study Desk", [14, 15],
    "Throne Sofa", [15, 12],
    "Tubmaster", [15, 13]
)

floorFurniPath := A_ScriptDir . "\images\floorfurnis\"
floorFurniPaths := Map(
    "Club Sofa", floorFurniPath "clubSofa.png",
    "Cola Machine", floorFurniPath "colaMachine.png",
    "Dicemaster", floorFurniPath "dicemaster.png",
    "Imperial Teleport", floorFurniPath "imperialTeleport.png",
    "Majestic Chair", floorFurniPath "majesticChair.png",
    "Mochamaster", floorFurniPath "mochamaster.png",
    "Oil Lamp", floorFurniPath "oilLamp.png",
    "Petal Patch", floorFurniPath "petalPatch.png",
    "Purple Pillow", floorFurniPath "purplePillow.png",
    "Study Desk", floorFurniPath "studyDesk.png",
    "Throne Sofa", floorFurniPath "throneSofa.png",
    "Tubmaster", floorFurniPath "tubmaster.png"
)

floorFurniOffsets := Map(
    "Club Sofa", [10, 9],
    "Cola Machine", [9, 11],
    "Dicemaster", [12, 9],
    "Imperial Teleport", [12, 12],
    "Majestic Chair", [9, 9],
    "Mochamaster", [12, 12],
    "Oil Lamp", [12, 12],
    "Petal Patch", [12, 12],
    "Purple Pillow", [10, 8],
    "Study Desk", [7, 7],
    "Throne Sofa", [8, 8],
    "Tubmaster", [11, 10]
)

tilePath := A_ScriptDir . "\images\tile.png"
firstHandPath := A_ScriptDir . "\images\firstHand.png"
nextHandPath := A_ScriptDir . "\images\nextHand.png"

myGui := Constructor()
myGui.Show("w220 h193")
myGui.Opt("+AlwaysOnTop")

Constructor() {
    guiPics := A_ScriptDir . "\images\"
    myGui := Gui()
    Tab := myGui.Add("Tab3", "x0 y0 w230 h198", ["Furni tool", "Dice roller", "Credits"])
    Tab.UseTab(1)
    myGui.SetFont("s16", "Tahoma")
    myGui.AddText("x8 y18 w161 h23 +0x200", "Habbo Furni Tool")
    myGui.SetFont("s8", "Tahoma")
    myGui.AddText("x8 y42 w55 h23 +0x200", "Select item:")
    myGui.AddText("x8 y66 w72 h23 +0x200", "Enter quantity:")
    dropdownItem := myGui.AddDropDownList("vDDLItems x64 y42 w146 +Sort Choose1", ["Club Sofa", "Cola Machine", "Dicemaster", "Imperial Teleport", "Majestic Chair", "Mochamaster", "Oil Lamp", "Petal Patch", "Purple Pillow", "Study Desk", "Throne Sofa", "Tubmaster"])
    quantity := myGui.AddEdit("x80 y66 w130 h21 +number", "1")
    myGui.AddUpDown("x152 y66 w18 h21", "1")
    myGui.SetFont("s16", "Tahoma")
    myGui.AddText("x8 y90 w120 h23 +0x200", "Actions")
    myGui.SetFont("s8", "Tahoma")
    ButtonPlaceInRoom := myGui.AddButton("x8 y114 w205 h23", "Place in room")
    ButtonPickupFromRoom := myGui.AddButton("x8 y138 w205 h23", "Pickup from room")
    ButtonAddToTrade := myGui.AddButton("x8 y162 w205 h23", "Add to trade")
    ButtonPlaceInRoom.OnEvent("Click", (*) => PlaceInRoom(dropdownItem, quantity))
    ButtonPickupFromRoom.OnEvent("Click", (*) => PickupFromRoom(dropdownItem, quantity))
    ButtonAddToTrade.OnEvent("Click", (*) => AddToTrade(dropdownItem, quantity))
    Tab.UseTab(2)
    myGui.SetFont("s16", "Tahoma")
    myGui.Add("Text", "x8 y18 w120 h23 +0x200", "Dice Roller")
    myGui.SetFont("s8", "Tahoma")
    myGui.SetFont("s16", "Tahoma")
    myGui.Add("Text", "x8 y88 w120 h23 +0x200", "Games")
    myGui.SetFont("s8", "Tahoma")
    ButtonSetdicepositions := myGui.Add("Button", "x8 y42 w204 h23", "Set dice positions")
    ButtonResetdices := myGui.Add("Button", "x8 y64 w204 h23", "Reset dices")
    Button13 := myGui.Add("Button", "x8 y112 w102 h23", "13")
    Button21 := myGui.Add("Button", "x110 y112 w102 h23", "21")
    ButtonTri := myGui.Add("Button", "x8 y136 w204 h23", "Tri")
    ButtonPoker := myGui.Add("Button", "x8 y160 w204 h23", "Poker")
    ButtonSetdicepositions.OnEvent("Click", (*) => Setdicepositions())
    ButtonResetdices.OnEvent("Click", (*) => Resetdices())
    Button13.OnEvent("Click", (*) => Roll13())
    Button13.ToolTip := "Roll first two dices"
    Button21.OnEvent("Click", (*) => Roll21())
    Button21.ToolTip := "Roll first three dices"
    ButtonTri.OnEvent("Click", (*) => RollTri())
    ButtonTri.ToolTip := "Roll 1st, 3rd and 5th dice"
    ButtonPoker.OnEvent("Click", (*) => RollPoker())
    ButtonPoker.ToolTip := "Roll all 5 dices"
    Tab.UseTab(3)
    myGui.SetFont("s8", "Tahoma")
    myGui.Add("Text", "x8 y24 w201 h48", "This is an open-source project available at github.com/jjoonafkin1/habbofurnitool`nand its licensed under the MIT License.")
    myGui.SetFont("s16", "Tahoma")
    myGui.Add("Picture", "x8 y72 w32 h32", guiPics "github.png")
    myGui.Add("Picture", "x8 y152 w32 h32", guiPics "discord.png")
    myGui.Add("Picture", "x8 y112 w32 h32", guiPics "origins.png")
    myGui.Add("Picture", "x136 y96 w72 h89", guiPics "charru.png")
    myGui.Add("Text", "x48 y72 w106 h32 +0x200", "jjoonafkin1")
    myGui.Add("Text", "x48 y112 w90 h32 +0x200", "visvakulli")
    myGui.Add("Text", "x48 y152 w80 h32 +0x200", "jjoona")
    myGui.OnEvent('Close', (*) => ExitApp())
    myGui.Title := "Multi-Tool"
    return myGui
}

OnMessage(0x0200, On_WM_MOUSEMOVE)
On_WM_MOUSEMOVE(wParam, lParam, msg, Hwnd)
{
    static PrevHwnd := 0
    if (Hwnd != PrevHwnd)
    {
        Text := "", ToolTip()
        CurrControl := GuiCtrlFromHwnd(Hwnd)
        if CurrControl
        {
            if !CurrControl.HasProp("ToolTip")
                return
            Text := CurrControl.ToolTip
            SetTimer () => ToolTip(Text), -25
            SetTimer () => ToolTip(), -4000
        }
        PrevHwnd := Hwnd
    }
}

GetHabboClient() {
    if !WinExist("Habbo Hotel: Origins") {
        ToolTip("Please make sure you have the Habbo client running.")
        SetTimer(() => ToolTip(), -2000)
    }
    WinActivate 
}

positions := []

Setdicepositions() {
    GetHabboClient()
    global positions
    positions := []
    MsgBox("Roll all 5 dices please.")
    Loop 10 {
        KeyWait "LButton", "D"
            global positions
            MouseGetPos(&x, &y)
            positions.Push({x: x, y: y})
            ToolTip("Position saved: " x ", " y)
            SetTimer(() => ToolTip(), -1000)
        sleep(500)
        If A_Index = 5 {
            MsgBox("Reset all 5 dices please.")
        }
    }
    MsgBox("Dice positions saved.")
}

Resetdices() {
    GetHabboClient()
    global positions
    resetCounter := 6
    Loop 5 {
        MouseMove(positions[resetCounter].x, positions[resetCounter].y)
        Click("Left")
        sleep(125)
        Click("left")
        Sleep(400)
        resetCounter++
    }
}

Roll13() {
    GetHabboClient()
    global positions
    roll13Counter := 1
    Loop 2 {
        MouseMove(positions[roll13Counter].x, positions[roll13Counter].y)
        Click("Left")
        sleep(125)
        Click("left")
        Sleep(400)
        roll13Counter++
    }
}

Roll21() {
    GetHabboClient()
    global positions
    roll21Counter := 1
    Loop 3 {
        MouseMove(positions[roll21Counter].x, positions[roll21Counter].y)
        Click("Left")
        sleep(125)
        Click("left")
        Sleep(400)
        roll21Counter++
    }
}

RollTri() {
    GetHabboClient()
    global positions
    rollTriCounter := 1
    Loop 3 {
        MouseMove(positions[rollTriCounter].x, positions[rollTriCounter].y)
        Click("Left")
        sleep(125)
        Click("left")
        Sleep(400)
        rollTriCounter += 2
    }
}

RollPoker() {
    GetHabboClient()
    global positions
    rollpokerCounter := 1
    Loop 5 {
        MouseMove(positions[rollpokerCounter].x, positions[rollpokerCounter].y)
        Click("Left")
        sleep(125)
        Click("left")
        Sleep(400)
        rollpokerCounter++
    }
}

PlaceInRoom(dropdownItem, quantity) {
    global handFurniPaths, handFurniOffsets, tilePath, firstHandPath, nextHandPath

    selectedItem := dropdownItem.Text
    selectedItemPath := handFurniPaths[selectedItem]
    offsetX := handFurniOffsets[selectedItem][1]
    offsetY := handFurniOffsets[selectedItem][2]

    if !selectedItemPath {
        ToolTip("Invalid selection!")
        SetTimer(() => ToolTip(), -2000)
        return
    }

    Loop quantity.Value {
        GetHabboClient()

        CoordMode("Pixel", "Window")
        firstHandDetectionCount := 0

        try {
            while true {
                if ImageSearch(&FoundX, &FoundY, 500, 0, 670, 150, "*TransBlack " selectedItemPath) {
                    FoundFurniX := FoundX + offsetX
                    FoundFurniY := FoundY - offsetY
                    MouseMove(FoundFurniX, FoundFurniY)
                    MouseClick("left")
                    Sleep(200)
                    if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, tilePath) {
                        FoundTileX := FoundX + 5
                        FoundTileY := FoundY - 30
                        MouseMove(FoundTileX, FoundTileY)
                        MouseClick("left")
                        Sleep(200)
                    }
                    break
                } else {
                    ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, nextHandPath)
                    FoundNextHandX := FoundX + 5
                    FoundNextHandY := FoundY - 20
                    MouseMove(FoundNextHandX, FoundNextHandY)
                    MouseClick("left")
                    Sleep(200)
                    if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, firstHandPath) {
                        firstHandDetectionCount += 1
                        Sleep(200)
                        if firstHandDetectionCount >= 2 {
                            ToolTip("Not enough selected furni found.")
                            SetTimer(() => ToolTip(), -2000)
                            return
                        }
                    }
                }
            }
        } catch as exc {
            ToolTip("Error finding furni: " exc.Message)
            SetTimer(() => ToolTip(), -2000)
            break
        }
    }
}

PickupFromRoom(dropdownItem, quantity) {
    global floorFurniPaths, floorFurniOffsets

    selectedItem := dropdownItem.Text
    selectedItemPath := floorFurniPaths[selectedItem]
    offsetX := floorFurniOffsets[selectedItem][1]
    offsetY := floorFurniOffsets[selectedItem][2]

    if !selectedItemPath {
        ToolTip("Invalid selection!")
        SetTimer(() => ToolTip(), -2000)
        return
    }

    Loop quantity.Value {
        GetHabboClient()

        CoordMode("Pixel", "Window")

        try {
            while true {
                if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "*TransBlack *75 " selectedItemPath) {
                    FoundFurniX := FoundX + offsetX
                    FoundFurniY := FoundY - offsetY
                    MouseMove(FoundFurniX, FoundFurniY)
                    Send "{Ctrl down}"
                    Sleep(150)
                    MouseClick("left")
                    Sleep(25)
                    Send "{Ctrl up}"
                    Sleep(150)
                    break
                } else {
                    ToolTip("No selected furni found.")
                    SetTimer(() => ToolTip(), -2000)
                    return
                }
            }
        }
    }
}

AddToTrade(dropdownItem, quantity) {
    global handFurniPaths, handFurniOffsets, firstHandPath, nextHandPath

    selectedItem := dropdownItem.Text
    selectedItemPath := handFurniPaths[selectedItem]
    offsetX := handFurniOffsets[selectedItem][1]
    offsetY := handFurniOffsets[selectedItem][2]

    if !selectedItemPath {
        ToolTip("Invalid selection!")
        SetTimer(() => ToolTip(), -2000)
        return
    }

    Loop quantity.Value {
        GetHabboClient()

        CoordMode("Pixel", "Window")
        firstHandDetectionCount := 0

        try {
            while true {
                if ImageSearch(&FoundX, &FoundY, 500, 0, 670, 160, "*TransBlack " selectedItemPath) {
                    FoundFurniX := FoundX + offsetX
                    FoundFurniY := FoundY - offsetY
                    MouseMove(FoundFurniX, FoundFurniY)
                    MouseClick("left")
                    Sleep(100)
                    if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, A_ScriptDir . "\images\tradeWindow.png") {
                        FoundTradeWindowX := FoundX + 10
                        FoundTradeWindowY := FoundY + 0
                        MouseMove(FoundTradeWindowX, FoundTradeWindowY)
                        MouseClick("left")
                        Sleep(400)
                    }
                    break
                } else {
                    ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, nextHandPath)
                    FoundNextHandX := FoundX + 5
                    FoundNextHandY := FoundY - 20
                    MouseMove(FoundNextHandX, FoundNextHandY)
                    MouseClick("left")
                    Sleep(200)
                    if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, firstHandPath) {
                        firstHandDetectionCount += 1
                        Sleep(200)
                        if firstHandDetectionCount >= 2 {
                            ToolTip("No selected furni found.")
                            SetTimer(() => ToolTip(), -2000)
                            return
                        }
                    }
                }
            }
        } catch as exc {
            ToolTip("Error finding furni:`n" exc.Message)
            SetTimer(() => ToolTip(), -2000)
            break
        }
    }
}
