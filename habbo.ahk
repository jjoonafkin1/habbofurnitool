#Requires AutoHotkey v2

#Include fileInstaller.ahk

sourceDir := A_ScriptDir
destDir := A_AppData . "\Habbo_Multi-tool"

handFurniPath := destDir . "\images\handfurnis\"
handFurniPaths := Map(
    "Club Sofa", handFurniPath "clubSofa.png",
    "Cola Machine", handFurniPath "colaMachine.png",
    "Dicemaster", handFurniPath "dicemaster.png",
    "Dragon Egg", handFurniPath "dragonEgg.png",
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
    "Dragon Egg", [15, 15],
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

floorFurniPath := destDir . "\images\floorfurnis\"
floorFurniPaths := Map(
    "Club Sofa", floorFurniPath "clubSofa.png",
    "Cola Machine", floorFurniPath "colaMachine.png",
    "Dicemaster", floorFurniPath "dicemaster.png",
    "Dragon Egg", floorFurniPath "dragonEgg.png",
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
    "Dragon Egg", [16, 16],
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

dicePath := destDir . "\images\dices\"
dicePaths := [
    {index: 1, path: dicePath "hd1.png", value : 1},
    {index: 2, path: dicePath "hd2.png", value : 2},
    {index: 3, path: dicePath "hd3.png", value : 3},
    {index: 4, path: dicePath "hd4.png", value : 4},
    {index: 5, path: dicePath "hd5.png", value : 5},
    {index: 6, path: dicePath "hd6.png", value : 6},
    {index: 7, path: dicePath "dm1.png", value : 1},
    {index: 8, path: dicePath "dm2.png", value : 2},
    {index: 9, path: dicePath "dm3.png", value : 3},
    {index: 10, path: dicePath "dm4.png", value : 4},
    {index: 11, path: dicePath "dm5.png", value : 5},
    {index: 12, path: dicePath "dm6.png", value : 6}
]

tilePath := destDir . "\images\tile.png"
firstHandPath := destDir . "\images\firstHand.png"
nextHandPath := destDir . "\images\nextHand.png"

myGui := Constructor()
myGui.Show("w220 h193")
myGui.Opt("+AlwaysOnTop")

Constructor() {
    guiPics := destDir . "\images\"
    myGui := Gui()
    Tab := myGui.Add("Tab3", "x0 y0 w230 h198", ["Furni tool", "Dice roller", "Credits"])
    Tab.UseTab(1)
    myGui.SetFont("s16", "Tahoma")
    myGui.AddText("x8 y18 w161 h23 +0x200", "Habbo Furni Tool")
    myGui.SetFont("s8", "Tahoma")
    myGui.AddText("x8 y42 w55 h23 +0x200", "Select item:")
    myGui.AddText("x8 y66 w72 h23 +0x200", "Enter quantity:")
    dropdownItem := myGui.AddDropDownList("vDDLItems x64 y42 w146 +Sort Choose1", ["Club Sofa", "Cola Machine", "Dicemaster", "Dragon Egg", "Imperial Teleport", "Majestic Chair", "Mochamaster", "Oil Lamp", "Petal Patch", "Purple Pillow", "Study Desk", "Throne Sofa", "Tubmaster"])
    quantity := myGui.AddEdit("x80 y66 w130 h21 +number", "1")
    myGui.AddUpDown("x152 y66 w18 h21", "1")
    myGui.SetFont("s16", "Tahoma")
    myGui.AddText("x8 y90 w120 h23 +0x200", "Actions")
    myGui.SetFont("s8", "Tahoma")
    ButtonPlaceInRoom := myGui.AddButton("x8 y114 w205 h23", "Place in room")
    ButtonPlaceInRoom.OnEvent("Click", (*) => PlaceInRoom(dropdownItem, quantity))
    ButtonPickupFromRoom := myGui.AddButton("x8 y138 w205 h23", "Pickup from room")
    ButtonPickupFromRoom.OnEvent("Click", (*) => PickupFromRoom(dropdownItem, quantity))
    ButtonAddToTrade := myGui.AddButton("x8 y162 w205 h23", "Add to trade")
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
    myGui.Add("Text", "x48 y72 w106 h32", "jjoonafkin1")
    myGui.Add("Text", "x48 y112 w90 h32", "visvakulli")
    myGui.Add("Text", "x48 y152 w80 h32", "jjoona")
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
    diceTotal := 0

    Loop 2 {
        MouseMove(positions[roll13Counter].x, positions[roll13Counter].y)
        Click("Left")
        sleep(125)
        Click("left")
        Sleep(400)
        roll13Counter++
    }

    roll13Counter := 1
    Loop 2 {
        diceTotal += GetDiceValue(roll13Counter)
        roll13Counter++
    }

    if diceTotal > 7 {
        Send(diceTotal "{enter}")
    }

    loop 3 {
        if diceTotal <= 7 {
            MouseMove(positions[roll13Counter].x, positions[roll13Counter].y)
            Click("Left")
            sleep(125)
            Click("left")
            Sleep(400)

            diceTotal += GetDiceValue(roll13Counter)
            roll13Counter++
        } else if diceTotal > 7 {
            Send(diceTotal "{enter}")
            break
        }
    }
}

Roll21() {
    GetHabboClient()
    global positions, dicePaths
    roll21Counter := 1
    diceTotal := 0

    CoordMode("Pixel", "Client")

    Loop 3 {
        MouseMove(positions[roll21Counter].x, positions[roll21Counter].y)
        Click("Left")
        Sleep(125)
        Click("Left")
        Sleep(400)
        roll21Counter++
    }

    roll21Counter := 1
    Loop 3 {
        diceTotal += GetDiceValue(roll21Counter)
        roll21Counter++
    }

    if diceTotal <= 15 {
        MouseMove(positions[roll21Counter].x, positions[roll21Counter].y)
        Click("Left")
        Sleep(125)
        Click("Left")
        Sleep(400)
        
        diceTotal += GetDiceValue(roll21Counter)
        roll21Counter++
    }

    if diceTotal <= 15 {
        MouseMove(positions[roll21Counter].x, positions[roll21Counter].y)
        Click("Left")
        Sleep(125)
        Click("Left")
        Sleep(400)
        diceTotal += GetDiceValue(roll21Counter)
        Send(diceTotal "{enter}")

    }

    if diceTotal <= 15 && roll21Counter == 5 {
        roll21Counter := 1
        MouseMove(positions[roll21Counter].x, positions[roll21Counter].y)
        Click("Left")
        Sleep(125)
        Click("Left")
        Sleep(400)
        
        diceTotal += GetDiceValue(roll21Counter)
    }

    Send(diceTotal "{enter}")
}

GetDiceValue(index) {
    global positions, dicePaths

    coord := positions[index]
    found := false
    while !found {
        diceX1 := coord.x - 15
        diceY1 := coord.y - 15
        diceX2 := coord.x + 15
        diceY2 := coord.y + 15

        for dice in dicePaths {
            currentImage := dice.path
            currentIndex := dice.value
            if ImageSearch(&foundX, &foundY, diceX1, diceY1, diceX2, diceY2, "*TransBlack *100 " currentImage) {
                found := true
                return currentIndex
            }
        }
    }
}



RollTri() {
    GetHabboClient()
    global positions, dicePaths
    rollTriCounter := 1

    Loop 3 {
        MouseMove(positions[rollTriCounter].x, positions[rollTriCounter].y)
        Click("Left")
        Sleep(125)
        Click("Left")
        Sleep(400)
        rollTriCounter += 2
    }

    CoordMode("Pixel", "Client")
    diceTotal := 0
    diceCount := 0

    rollTriCounter := 1
    Loop 3 {
        diceValue := GetDiceValue(rollTriCounter)
        if diceValue {
            diceTotal += diceValue
            diceCount++
        }
        rollTriCounter += 2
    }

    if diceCount < 3 {
        MsgBox "Not enough dice detected. Please try again."
        return
    }
    
    Send(diceTotal "{enter}")
}



RollPoker() {
    GetHabboClient()
    global positions, dicePaths
    rollpokerCounter := 1

    Loop 5 {
        MouseMove(positions[A_Index].x, positions[A_Index].y)
        Click("Left")
        Sleep(125)
        Click("Left")
        Sleep(400)
        rollpokerCounter++
    }

    CoordMode("Pixel", "Client")
    dices := []

    rollpokerCounter := 1
    Loop 5 {
        diceValue := GetDiceValue(rollpokerCounter)
        if diceValue {
            dices.Push(diceValue)
        }
        rollpokerCounter++

    }

    if dices.Length < 5 {
        MsgBox "Not enough dice detected. Please try again."
        return
    }

    hand := CalculatePokerHand(dices)
    Send(hand "{enter}")
}

CalculatePokerHand(dices) {
    counts := [0, 0, 0, 0, 0, 0, 0]
    
    for _, dice in dices {
        counts[dice] += 1
    }
    
    maxCount := 0
    secondMaxCount := 0
    maxNumber := 0
    secondMaxNumber := 0
    
    Loop 6 {
        if (counts[A_Index] > maxCount) {
            secondMaxCount := maxCount
            secondMaxNumber := maxNumber
            maxCount := counts[A_Index]
            maxNumber := A_Index
        } else if (counts[A_Index] > secondMaxCount) {
            secondMaxCount := counts[A_Index]
            secondMaxNumber := A_Index
        }
    }
    
    if (maxCount == 5) {
        return "Five of a Kind: " maxNumber
    } else if (maxCount == 4) {
        return "Four of a Kind: " maxNumber
    } else if (maxCount == 3 && secondMaxCount == 2) {
        return "Full House: " maxNumber " over " secondMaxNumber
    } else if (maxCount == 3) {
        return "Three of a Kind: " maxNumber
    } else if (maxCount == 2 && secondMaxCount == 2) {
        return "Two Pair: " maxNumber " and " secondMaxNumber
    } else if (maxCount == 2) {
        return "One Pair: " maxNumber
    } else {
        if (counts[1] == 1 && counts[2] == 1 && counts[3] == 1 && counts[4] == 1 && counts[5] == 1) {
            return "Low Straight: 1-5"
        }
        
        if (counts[2] == 1 && counts[3] == 1 && counts[4] == 1 && counts[5] == 1 && counts[6] == 1) {
            return "High Straight: 2-6"
        }
        
        return "No Hand"
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
                        ToolTip("")
                        Sleep(200)
                    } else {
                        ToolTip("Tile not found")
                        SetTimer(() => ToolTip(), -2000)
                        return
                    }
                    break
                } else {
                    if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, nextHandPath) {
                        FoundNextHandX := FoundX + 5
                        FoundNextHandY := FoundY - 20
                        MouseMove(FoundNextHandX, FoundNextHandY)
                        MouseClick("left")
                        ToolTip("Searching for item: " selectedItem)
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
                    } else {
                        return
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
    selectedItemPath2 := StrReplace(selectedItemPath, ".png", "2.png")
    offsetX := floorFurniOffsets[selectedItem][1]
    offsetY := floorFurniOffsets[selectedItem][2]

    if !selectedItemPath {
        ToolTip("Invalid selection!")
        SetTimer(() => ToolTip(), -2000)
        return
    }

    Loop quantity.Value {
        GetHabboClient()

        CoordMode("Pixel", "Client")

        try {
            while true {
                if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "*TransBlack *75 " selectedItemPath) {
                    FoundFurniX := FoundX + offsetX
                    FoundFurniY := FoundY - offsetY
                    MouseMove(FoundFurniX, FoundFurniY)
                    Send("{Ctrl down}")
                    Sleep(150)
                    MouseClick("left")
                    Sleep(25)
                    Send("{Ctrl up}")
                    Sleep(150)
                    break
                } else if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "*TransBlack *75 " selectedItemPath2) {
                    FoundFurniX := FoundX + 6
                    FoundFurniY := FoundY + 6
                    MouseMove(FoundFurniX, FoundFurniY)
                    Send("{Ctrl down}")
                    Sleep(150)
                    MouseClick("left")
                    Sleep(25)
                    Send("{Ctrl up}")
                    Sleep(150)
                    break
                } else {
                    ToolTip("No selected furni found.")
                    SetTimer(() => ToolTip(), -2000)
                    return
                }
            }
        } catch {
            ToolTip("An error occurred during the search process.")
            SetTimer(() => ToolTip(), -2000)
            return
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
                    if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, destDir . "\images\tradeWindow.png") {
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
