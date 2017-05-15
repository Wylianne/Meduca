local composer =  require("composer") 

local sugestao = composer.newScene()

local widget = require("widget")

local native = require("native")

local slide = require("slide_menu")

local ragdogLib = require "ragdogLib";


boxSlide = false

local function onMenuTouch(event)
    if ( event.phase == "ended" ) then
        slide:onMenuTouch()
        if (boxSugestao.x == display.contentCenterX) then 
            transition.to(boxSugestao, {time=400, x = boxSugestao.x + display.actualContentWidth*0.545})
            transition.to(textSugestao, {time=400, x = textSugestao.x + display.actualContentWidth*0.545})
            transition.to(btnEnviar, {time=400, x = btnEnviar.x + display.actualContentWidth*0.545})
            boxSlide = true
        end
    end
    return true
end

function backMenu(event)
    if (event.phase == "ended") then
        composer.gotoScene("menuPrincipal")
    end
end


function sugestao:create(event)

    SceneGroup = self.view

    

    boxSugestao = native.newTextBox( display.contentCenterX, display.contentCenterY * 0.7, display.contentCenterX*1.8, display.contentCenterY * 0.8 )

    boxSugestao.isFontSizeScaled = true  -- Make the text box use the same font units as the text object
    boxSugestao.size = 13
    boxSugestao.placeholder = "Digite aqui sua sugestão para o jogo!"
    boxSugestao.isEditable = true    
    boxSugestao.isVisible = true


    local background = display.newImageRect( "menu_principal/fundo_menu1.png", display.contentCenterX*2, display.contentCenterY*2.37 )
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



    textSugestao = display.newText("Enviar Sugestão", display.contentCenterX * 0.09, display.contentCenterY * 0.1, native.systemFont, 20 )
    textSugestao:setFillColor(ragdogLib.convertHexToRGB("#336699"))
    textSugestao.anchorX, textSugestao.anchorY = 0, 0
    SceneGroup:insert(textSugestao)

    btnEnviar = widget.newButton({
        left = 320,
        top = 350,   
        label = "Enviar",
        shape = "roundedRect",
        width = 90,
        height = 30,
        cornerRadius = 1,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={0,0.4,1,1}, over={0,0.2,0.9,1} },
        strokeColor = { default={1,0,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 0,
            onEvent = viewFieldsEvent
        
    })
    btnEnviar.x = display.contentCenterX
    btnEnviar.y = display.contentCenterY*1.3
    SceneGroup:insert(btnEnviar)
end

function sugestao:show(event)
  if (event.phase == "did") then
        boxSugestao.isVisible = true
  end 
end


function sugestao:hide(event)
  if (event.phase == "did") then
        boxSugestao.isVisible = false
  end 
end


function sugestao:destroy(event)

    if event.phase == "will" then
        --boxSugestao.isVisible = false
        --sugestao:show()
    end
end

sugestao:addEventListener( "create", sugestao )
sugestao:addEventListener( "show", sugestao )
sugestao:addEventListener( "hide", sugestao )
sugestao:addEventListener( "destroy", sugestao )


return sugestao