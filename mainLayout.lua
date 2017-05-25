local mainLayout = {}

local slide = require("slide_menu")

local composer =  require("composer")


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


function mainLayout:create(titulo)
 
 local layoutGroup = display.newGroup()
 
 local background = display.newImageRect( "menu_principal/fundo_menu1.png", display.contentCenterX*2, display.contentCenterY*2.37 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    layoutGroup:insert(background)

    local barTop = display.newRect(0,-30,320,30)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = display.contentCenterX
    layoutGroup:insert(barTop)

    nameApp = display.newText("Meduca - "..titulo, 0, -30)
    nameApp:setFillColor(1,1,1)
    nameApp.x = display.contentCenterX
    layoutGroup:insert(nameApp)

    local menu_disabled = display.newImageRect( "menu_principal/menu_disabled.png", 25, 25 )
    menu_disabled.x =  display.contentCenterX * 0.1
    menu_disabled.y = -30
    layoutGroup:insert(menu_disabled)
    menu_disabled:addEventListener( "touch", onMenuTouch )

    local back_menu = display.newImageRect( "menu_principal/arrows-left.png", 25, 25 )
    back_menu.x = display.contentCenterX * 1.9
    back_menu.y = -30
    layoutGroup:insert(back_menu)
    back_menu:addEventListener( "touch", backMenu )
    
    
    return layoutGroup


end


return mainLayout 