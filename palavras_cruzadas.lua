local composer =  require("composer") 

local palavrasCruzadas = composer.newScene()

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

function geraFases()
    iniFase = display.contentCenterX - 100
    yFaseB = 70
    yFaseF = 60
    cont = 0

    for i=1, 12, 1 do
        --+110
        if (i == 4) then
            yFaseB = 180
            yFaseF = 170
            iniFase = display.contentCenterX - 100
            cont = 0
        elseif (i == 7) then
            yFaseB = 290
            yFaseF = 280
            iniFase = display.contentCenterX - 100
            cont = 0
        elseif (i == 10) then
            yFaseB = 400
            yFaseF = 390
            iniFase = display.contentCenterX - 100
            cont = 0
        end

        local faseBack = display.newRoundedRect(display.contentCenterX * 1.05, 30, 70,90,12)
        faseBack:setFillColor(0.5,0.6,1, 0.5)
        faseBack.y = yFaseB
        faseBack.x = iniFase
        SceneGroup:insert(faseBack)

        local faseFront = display.newRoundedRect(display.contentCenterX * 1.05, 30, 70,70,12)
        faseFront:setFillColor(0.5,0.6,1, 0.5)
        faseFront.y = yFaseF
        faseFront.x = iniFase
        faseFront.strokeWidth = 3
        faseFront:setStrokeColor( 1, 1, 0 )
        SceneGroup:insert(faseFront)

        local numFase = display.newText(i, 150, yFaseF, native.systemFont, 40 )
        numFase.x = display.contentCenterX

        if cont == 0 then
            numFase.x = display.contentCenterX -100
        elseif cont == 1 then
            numFase.x = display.contentCenterX
        elseif cont == 2 then
            numFase.x = display.contentCenterX + 100
        end
        SceneGroup:insert(numFase)

        iniFase = iniFase + 100
        cont = cont + 1
    end
end


function palavrasCruzadas:create(event)
    SceneGroup = self.view
    
    local background = display.newImageRect( "menu_principal/fundo_menu1.png", 360, 570 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    SceneGroup:insert(background)

    local barTop = display.newRect(0,-30,320,30)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = display.contentCenterX
    SceneGroup:insert(barTop)

    nameApp = display.newText("Meduca - Palavras Cruzadas", 0, -30)
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

    geraFases()
    

end



palavrasCruzadas:addEventListener("create", palavrasCruzadas)
return palavrasCruzadas