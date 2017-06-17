native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer =  require("composer") 

local estatisticas = composer.newScene()

local widget = require("widget")

local native = require("native")

local slide = require("slide_menu")

local ragdogLib = require "ragdogLib";


boxSlide = false

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


function estatisticas:create(event)

    SceneGroup = self.view

    local background = display.newImageRect( "menu_principal/fundo_menu1.png", display.contentCenterX*2, display.contentCenterY*2.37 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    SceneGroup:insert(background)

    local barTop = display.newRect(0,-30,320,30)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = display.contentCenterX
    SceneGroup:insert(barTop)

    nameApp = display.newText("Meduca - Estatísticas", 0, -30)
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



    textestatisticas = display.newText("Estatísticas", display.contentCenterX * 0.09, display.contentCenterY * 0.1, native.systemFont, 20 )
    textestatisticas:setFillColor(ragdogLib.convertHexToRGB("#336699"))
    textestatisticas.y = display.contentCenterY * 0.1
    textestatisticas.x = display.contentCenterX
    SceneGroup:insert(textestatisticas)

    local graf = display.newImageRect( "menu_principal/graf.png", display.contentCenterX*2, display.contentCenterY*1.2 )
    graf.x = display.contentCenterX 
    graf.y = display.contentCenterY *0.9
    SceneGroup:insert(graf)

end


function estatisticas:destroy(event)

    if event.phase == "will" then
        --boxestatisticas.isVisible = false
        --estatisticas:show()
    end
end

estatisticas:addEventListener( "create", estatisticas )
estatisticas:addEventListener( "destroy", estatisticas )


return estatisticas