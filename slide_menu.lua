local widget = require( "widget" )

local slide_menu = {}

local menuActive = false

function slideMenuClose(event)
    if (event.phase == "ended") then
        transition.to(menu, {time=400, x = menu.x - display.actualContentWidth/2})
        transition.to(menu_close, {time=400, x = menu_close.x - display.actualContentWidth/2}) 
        --transition.to(logo, {time=400, x = logo.x - display.actualContentWidth/2}) 
        --transition.to(opcMenuSugestoes, {time=400, x = opcMenuSugestoes.x - display.actualContentWidth/2}) 
        --transition.to(opcMenuSair, {time=400, x = opcMenuSair.x - display.actualContentWidth/2}) 


        menuActive = false
    end
end

function goToSugestoes( event )
    if (event.phase == "ended") then
        print("entrou")
    end
end

function slide_menu:onMenuTouch()
    if (menuActive == false) then
            
        menu = display.newImageRect( "menu_principal/menu.png", display.actualContentWidth/2, display.actualContentHeight )
        menu.y = display.contentCenterY
        menu.x = -80
        --menu:setFillColor(0.2,0.4,0.6)

        menu_close = display.newImageRect( "slide_menu/close.png", 25, 25 )
        menu_close.x = -20
        menu_close.y = -30
        menu_close:addEventListener( "touch", slideMenuClose )

        logo = display.newImageRect("slide_menu/logo.png", 130, 75)
        logo.x = -80
        logo.y = 40

        --Itens do menu

        opcMenuSugestoes = display.newText( "> Sugestões", -110, 120, native.systemFont, 14 )
        opcMenuSugestoes:setFillColor( 1, 1, 1 )
        opcMenuSugestoes:addEventListener("touch", goToSugestoes)
        opcMenuSair = display.newText( "> Desconectar", -100, 140, native.systemFont, 14 )
        opcMenuSair:setFillColor( 1, 1, 1 )
        


        transition.to(menu, {time=400, x = menu.x + display.actualContentWidth/2})
        transition.to(menu_close, {time=400, x = menu_close.x + display.actualContentWidth/2})
        --transition.to(logo, {time=400, x = logo.x + display.actualContentWidth/2})
        --transition.to(opcMenuSugestoes, {time=400, x = opcMenuSugestoes.x + display.actualContentWidth/2})
        --transition.to(opcMenuSair, {time=400, x = opcMenuSair.x + display.actualContentWidth/2})


        menuActive = true
    end
end

return slide_menu