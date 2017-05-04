local composer =  require("composer") 

local menuPrincipal = composer.newScene()

local slide = require("slide_menu")

local function onMenuTouch(event)
    if ( event.phase == "ended" ) then
        slide:onMenuTouch()
    end
    return true
end

function secondMenu(event)
    if (event.phase == "ended") then
        composer.gotoScene("menuPrincipal_2")
    end
end

 
function menuPrincipal:create(event)
    local SceneGroup = self.view
    
    local background = display.newImageRect( "menu_principal/menu3.png", 360, 570 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    SceneGroup:insert(background)

    local barTop = display.newRect(0,-30,320,30)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = display.contentCenterX
    SceneGroup:insert(barTop)

    nameApp = display.newText("Meduca", 0, -30)
    nameApp:setFillColor(1,1,1)
    nameApp.x = display.contentCenterX
    SceneGroup:insert(nameApp)

    local menu_disabled = display.newImageRect( "menu_principal/menu_disabled.png", 25, 25 )
    menu_disabled.x = display.contentCenterX * 0.1
    menu_disabled.y = -30
    SceneGroup:insert(menu_disabled)

    menu_disabled:addEventListener( "touch", onMenuTouch )

    local left = display.newImageRect( "menu_principal/left.png", 18, 30 )
    left.x = display.contentCenterX - 130
    left.y = 45
    SceneGroup:insert(left)
    left:addEventListener("touch", secondMenu)

    local star = display.newImageRect( "menu_principal/star.png", 80, 80 )
    star.x = display.contentCenterX
    star.y = 40
    SceneGroup:insert(star)

    local media = display.newText("7", 80, 45)
    media.x = display.contentCenterX


    local palavras_cruzadas = display.newImageRect( "menu_principal/cli.png", 70, 70 )
    palavras_cruzadas.x = display.contentCenterX
    palavras_cruzadas.y = 150
    SceneGroup:insert(palavras_cruzadas) 
    
    

end

menuPrincipal:addEventListener("create", menuPrincipal)
return menuPrincipal