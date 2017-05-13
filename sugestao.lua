local composer =  require("composer") 

local sugestao = composer.newScene()

local widget = require("widget")

local native = require("native")

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


function sugestao:create(event)

end

function sugestao:show(event)
    SceneGroup = self.view

    print(menu_close.x)
    if (menu_close.x == 151) then
        menuActive = false
    end

    boxSugestao = native.newTextBox( display.contentCenterX, display.contentCenterY * 0.8, display.contentCenterX*1.8, display.contentCenterY * 0.8 )
    boxSugestao.isFontSizeScaled = true  -- Make the text box use the same font units as the text object
    boxSugestao.size = 13
    boxSugestao.placeholder = "Digite aqui sua sugestão para o jogo!"
    boxSugestao.isEditable = true
    SceneGroup:insert(boxSugestao)
    
    local background = display.newImageRect( "menu_principal/fundo_menu1.png", 360, 570 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    SceneGroup:insert(background)

    local barTop = display.newRect(0,-30,320,30)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = display.contentCenterX
    SceneGroup:insert(barTop)

    nameApp = display.newText("Meduca - Sugestão", 0, -30)
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

end


function sugestao:destroy(event)
    sugestao:show()
end

function sugestao:hide(event)
  if event.phase == "did" then
    boxSugestao:removeSelf()
  end  
end

sugestao:addEventListener( "create", sugestao )
sugestao:addEventListener( "show", sugestao )
sugestao:addEventListener( "hide", sugestao )
sugestao:addEventListener( "destroy", sugestao )


return sugestao