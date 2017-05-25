local composer =  require("composer") 

local clinica = composer.newScene()

local widget = require("widget")

local slide = require("slide_menu")

local ragdogLib = require "ragdogLib";


perguntas = {
                "Pessoal",
                "Idade",
                "Vida sexual",
                "Drogas - Lícitas",
                "Atividades físicas",
                "Esporte",
                "Academia",
                "Antercedentes familiares"
            }   



-- Declare/upvalue a "fillColor" table for later reference
local fillColor = { 0, 0, 0 }
 
-- Handle row rendering
local function onRowRender( event )
 
    -- Get reference to the row group
    local row = event.row
 
    -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth
 
    local rowTitle = display.newText( row, perguntas[row.index], 0, 0, nil, 14 )
    -- Set the row title fill color based on the "fillColor" table values
    rowTitle:setFillColor( fillColor[1], fillColor[2], fillColor[3] )
 
    -- Align the label left and vertically centered
    rowTitle.anchorX = 0
    if (row.isCategory) then
        rowTitle.x = 5
    else        
        rowTitle.x = 15
    end
    rowTitle.y = rowHeight * 0.5
end

local function onMenuTouch(event)
    if ( event.phase == "ended" ) then
        slide:onMenuTouch()
    end
    return true
end

function backMenu(event)
    if (event.phase == "ended") then
        composer.gotoScene("menuPrincipal")
    end
end



function geraButtom()
        local btnNext = widget.newButton({
            left = 130,
            top = 350,   
            label = "Laudo »",
            shape = "roundedRect",
            width = 90,
            height = 25,
            cornerRadius = 0,
            labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fillColor = { default={0.1,0.5,0, 0.9}, over={0.2,0.4,0.7,0.5} },
            strokeColor = { default={0.1,0.5,0,0.9}, over={0.1,0.5,0,1} },
            strokeWidth = 5,
            onEvent = proximaPergunta
            
        })
        btnNext.x = display.contentCenterX + 92
        btnNext.y = display.contentCenterY*2.08
        SceneGroup:insert(btnNext)

end

function clinica:create(event)

    SceneGroup = self.view

    local background = display.newImageRect( "img_jogos/clinica.png", display.contentCenterX*2, display.contentCenterY*2.37 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    SceneGroup:insert(background)

    local barTop = display.newRect(0,-30,320,30)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = display.contentCenterX
    SceneGroup:insert(barTop)

    nameApp = display.newText("Meduca - Clínica", 0, -30)
    nameApp:setFillColor(1,1,1)
    nameApp.x = display.contentCenterX
    SceneGroup:insert(nameApp)

    local menu_disabled = display.newImageRect( "menu_principal/menu_disabled.png", 25, 25 )
    menu_disabled.x =  display.contentCenterX * 0.1
    menu_disabled.y = -30
    SceneGroup:insert(menu_disabled)
    menu_disabled:addEventListener( "touch", onMenuTouch )

    local back_menu = display.newImageRect( "menu_principal/arrows-left.png", 25, 25 )
    back_menu.x = display.contentCenterX * 1.9
    back_menu.y = -30
    SceneGroup:insert(back_menu)
    back_menu:addEventListener( "touch", backMenu )

    local tableView = widget.newTableView({
        left = 10,
        top = 320,
        height = 150,
        width = 300,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        listener = scrollListener
    })

    SceneGroup:insert(tableView)

    for i = 1, 8 do
 
        local isCategory = false
        local rowHeight = 36
        local rowColor = { default={1,1,1}, over={1,0.5,0,0.2} }
        local lineColor = { 0.5, 0.5, 0.5 }
     
        -- Make some rows categories
        if ( i == 1 or i == 5 or i == 8 ) then
            isCategory = true
            rowHeight = 40
            rowColor = { default={ragdogLib.convertHexToRGB("#336699")} }
            lineColor = { 1, 0, 0 }
        else
            rowColor = { default={ragdogLib.convertHexToRGB("#ffffff")} }
        end
     
        -- Insert a row into the tableView
        tableView:insertRow({
                isCategory = isCategory,
                rowHeight = rowHeight,
                rowColor = rowColor,
                lineColor = lineColor
        })
    end

    geraButtom()
end


clinica:addEventListener( "create", clinica )

return clinica