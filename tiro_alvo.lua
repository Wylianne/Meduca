local composer =  require("composer") 

local quiz = composer.newScene()


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

function moveScene()
       

    local tornadoData = { width=400, height=480, numFrames=9, sheetContentWidth=3600, sheetContentHeight=480 }
    local tornado = graphics.newImageSheet( "img_jogos/vaso.png", tornadoData )

    sequenceData = {name="seq1", sheet=tornado, start=1, count=9, time=1000, loopCount=1}

                     
    myAnimation = display.newSprite( tornado, sequenceData )
    myAnimation.x = display.contentCenterX
    myAnimation.y = display.contentCenterY
    SceneGroup:insert(myAnimation)
    myAnimation:play()
end

function quiz:create(event)
    SceneGroup = self.view

    moveScene()
    print(display.contentCenterY)
    print(display.contentCenterX)

    local barTop = display.newRect(0,-30,320,30)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = display.contentCenterX
    SceneGroup:insert(barTop)

    nameApp = display.newText("Meduca - Quiz", 0, -30)
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

quiz:addEventListener("create", quiz)
return quiz