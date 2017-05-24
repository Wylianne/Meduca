local composer =  require("composer") 

local widget = require("widget")

local ragdogLib = require "ragdogLib";

local String = require("string")

local laboratorio = composer.newScene()

local slide = require("slide_menu")

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

function chamaTags()
    bacterias = {{"", ""},{"", ""},{"", ""},{"", ""},{"", ""},{"", ""},{"", ""},{"", ""},{"", ""}}
    bacterias[1][1] = "Clostridium Tetani"
    bacterias[1][2] = 140
    bacterias[2][1] = "Bordetella Pertussis"
    bacterias[2][2] = 160
    bacterias[3][1] = "Mycobacterium Leprae"
    bacterias[3][2] = 180
    bacterias[4][1] = "Yersinia Pestis"
    bacterias[4][2] = 115
    bacterias[5][1] = "Rickettsia Rickettsii" 
    bacterias[5][2] = 150 
    bacterias[6][1] =  "Lepstospira"
    bacterias[6][2] = 110 
    bacterias[7][1] = "Treponema Pallidum"
    bacterias[7][2] = 160
    bacterias[8][1] = "Vibrio Cholerae" 
    bacterias[8][2] = 125
    bacterias[9][1] = "Pneumococcus Pneumoniae" 
    bacterias[9][2] = 220 

    topButton = 6
    for i=1, 9, 1 do
        if ( i%2 == 0) then
            leftButton = bacterias[i-1][2] + 15
        else
            leftButton = 10
        end
        bacteria = bacterias[i][1]
        print(bacteria)
        button = widget.newButton({
            left = leftButton,
            top = topButton,   
            label = bacterias[i][1],
            shape = "roundedRect",
            width = bacterias[i][2],
            height = 25,
            cornerRadius = 5,
            labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fillColor = { default={ragdogLib.convertHexToRGB("#d4d4d4")}, over={0,0.2,0.9,1} },
            strokeColor = { default={1,0,0,1}, over={0.8,0.8,1,1} },
            strokeWidth = 0,
            onEvent = clickTag 
            
        })

        SceneGroup:insert(button)
        if (i%2 == 0) then
            topButton = topButton + 30
        end
    end

end

function clickTag(event)
    if (event.phase == "ended") then
        event.width = 100
        event.target:setFillColor(ragdogLib.convertHexToRGB("#336699"))
    end
end

function laboratorio:create(event)
    SceneGroup = self.view
    
    local background = display.newImageRect( "menu_principal/fundo_lab.png", display.contentCenterX*2, display.contentCenterY*2.37 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    SceneGroup:insert(background)

    local barTop = display.newRect(0,-30,320,30)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = display.contentCenterX
    SceneGroup:insert(barTop)

    nameApp = display.newText("Meduca - Laboratório", 0, -30)
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


    local petri = display.newImageRect( "img_jogos/petri.png", display.contentCenterX*1.7, display.contentCenterX*1.7 )
    petri.x = display.contentCenterX
    petri.y = display.contentCenterY * 1.2
    SceneGroup:insert(petri)
    
    chamaTags()

end



laboratorio:addEventListener("create", laboratorio)
return laboratorio