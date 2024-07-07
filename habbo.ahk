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
myGui.Show("w257 h185")
myGui.Opt("+AlwaysOnTop")

Constructor() {
    myGui := Gui()
    myGui.SetFont("s16", "Tahoma")
    myGui.AddText("x8 y8 w161 h23 +0x200", "Habbo Furni tool")
    myGui.SetFont("s8", "Tahoma")
    myGui.AddText("x8 y32 w55 h23 +0x200", "Select item:")
    myGui.AddText("x8 y56 w72 h23 +0x200", "Enter quantity:")
    dropdownItem := myGui.AddDropDownList("vDDLItems x64 y32 w106 +Sort Choose1", ["Club Sofa", "Cola Machine", "Dicemaster", "Imperial Teleport", "Majestic Chair", "Mochamaster", "Oil Lamp", "Petal Patch", "Purple Pillow", "Study Desk", "Throne Sofa", "Tubmaster"])
    quantity := myGui.AddEdit("x80 y56 w90 h21 +number", "1")
    myGui.AddUpDown("x152 y56 w18 h21", "1")
    myGui.SetFont("s16", "Tahoma")
    myGui.AddText("x8 y80 w120 h23 +0x200", "Actions")
    myGui.SetFont("s8", "Tahoma")
    ButtonPlaceInRoom := myGui.AddButton("x8 y104 w162 h23", "Place in room")
    ButtonPickupFromRoom := myGui.AddButton("x8 y128 w162 h23", "Pickup from room")
    ButtonAddToTrade := myGui.AddButton("x8 y152 w162 h23", "Add to trade")
    myGui.AddPicture("x176 y64 w72 h89", A_ScriptDir . "\images\charru.png")
    myGui.AddPicture("x182 y152 w24 h24", A_ScriptDir . "\images\discord.png")
    myGui.SetFont("s8 Underline c0x000000", "Tahoma")
    myGui.AddText("x210 y158 w30 h17", "jjoona")
    ButtonPlaceInRoom.OnEvent("Click", (*) => PlaceInRoom(dropdownItem, quantity))
    ButtonPickupFromRoom.OnEvent("Click", (*) => PickupFromRoom(dropdownItem, quantity))
    ButtonAddToTrade.OnEvent("Click", (*) => AddToTrade(dropdownItem, quantity))
    myGui.OnEvent('Close', (*) => ExitApp())
    myGui.Title := "Furni Tool"
    return myGui
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
        if !WinExist("Habbo Hotel: Origins") {
            ToolTip("Please make sure you have the Habbo client running.")
            SetTimer(() => ToolTip(), -2000)
            break
        }

        WinActivate

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
        if !WinExist("Habbo Hotel: Origins") {
            ToolTip("Please make sure you have the Habbo client running.")
            SetTimer(() => ToolTip(), -2000)
            break
        }

        WinActivate

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
        if !WinExist("Habbo Hotel: Origins") {
            ToolTip("Please make sure you have the Habbo client running.")
            SetTimer(() => ToolTip(), -2000)
            break
        }

        WinActivate

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
