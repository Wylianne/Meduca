local composer =  require("composer") 

local widget = require( "widget" )

local ragdogLib = require "ragdogLib";

local slide_menu = {}

menuActive = false


function slideMenuClose(event)
    if (event.phase == "ended") then
    
        transition.to(menu, {time=300, x = menu.x - display.actualContentWidth*0.55})
        transition.to(menu_close, {time=300, x = menu_close.x - display.actualContentWidth/2}) 
        transition.to(logo, {time=300, x = logo.x - display.actualContentWidth/2}) 
        transition.to(opcMenuEstatisticas, {time=300, x = opcMenuEstatisticas.x - display.actualContentWidth/2}) 
        transition.to(opcMenuComoJogar, {time=300, x = opcMenuComoJogar.x - display.actualContentWidth/2}) 
        transition.to(opcMenuSugestoes, {time=300, x = opcMenuSugestoes.x - display.actualContentWidth/2}) 
        transition.to(opcMenuSair, {time=300, x = opcMenuSair.x - display.actualContentWidth/2}) 


        transition.to(slider, {time=220, x = slider.x - display.actualContentWidth*0.545})

        transition.to(lineBeginTop, {time=220, x = lineBeginTop.x - display.actualContentWidth*0.545})
        transition.to(lineBegin, {time=220, x = lineBegin.x - display.actualContentWidth*0.55})
        transition.to(line1, {time=220, x = line1.x - display.actualContentWidth*0.545})
        transition.to(line2, {time=220, x = line2.x - display.actualContentWidth*0.545})
        transition.to(line3, {time=220, x = line3.x - display.actualContentWidth*0.545})
        transition.to(lineEnd, {time=220, x = lineEnd.x - display.actualContentWidth*0.545})

        menuActive = false

        if (boxSlide)then
            transition.to(boxSugestao, {time=400, x = boxSugestao.x - display.actualContentWidth*0.545})
            transition.to(textSugestao, {time=400, x = textSugestao.x - display.actualContentWidth*0.545})
            transition.to(btnEnviar, {time=400, x = btnEnviar.x - display.actualContentWidth*0.545})
            boxSlide = false
        end
    end
end

function goToEstatisticas( event )
    if (event.phase == "ended") then
        slideMenuClose(event)
    end
end

function goToComoJogar( event )
    if (event.phase == "ended") then
        slideMenuClose(event)
    end
end

function goToSugestoes( event )
    if (event.phase == "ended") then
        
        composer.gotoScene("sugestao")
        slideMenuClose(event)
    end
end

function goToSair( event )
    if (event.phase == "ended") then
        
        composer.gotoScene("login")
        slideMenuClose(event)
    end
end

function slide_menu:onMenuTouch()

    if (menuActive == false) then
        menuActive = true
            
        --menu = display.newImageRect( "menu_principal/menu.png", display.actualContentWidth/2, display.actualContentHeight )
        menu = display.newRect(-90, 0, display.actualContentWidth*0.55,display.actualContentHeight )
        menu.y = display.contentCenterY
        menu:setFillColor(ragdogLib.convertHexToRGB("#336699"))

        menu_close = display.newImageRect( "slide_menu/close.png", 25, 25 )
        menu_close.x = -9
        menu_close.y = -30
        menu_close.id = "menu_close"
        menu_close:addEventListener( "touch", slideMenuClose )

        logo = display.newImageRect("slide_menu/logo.png", 150, 85)
        logo.x = -75
        logo.y = 40



        --Itens do menu


        lineBeginTop = display.newLine( -175, 105, 0, 105 )
        lineBeginTop:setStrokeColor(ragdogLib.convertHexToRGB("#999999"))
        lineBeginTop.strokeWidth = 0.9

        slider = widget.newSlider({
            top = 100,
            left = -165,
            width = 150,
            value = 10,  -- Start slider at 10% (optional)
            listener = sliderListener
        })



        lineBegin = display.newLine( -175, 140, 0, 140 )
        lineBegin:setStrokeColor(ragdogLib.convertHexToRGB("#999999"))
        lineBegin.strokeWidth = 0.9

        opcMenuEstatisticas = display.newText( "¤  Estatísticas", -140, 148, native.systemFont, 15 )
        opcMenuEstatisticas:setFillColor( 1, 1, 1 )
        opcMenuEstatisticas.xAlign, opcMenuEstatisticas.anchorX, opcMenuEstatisticas.anchorY = "left", 0, 0
        opcMenuEstatisticas:addEventListener("touch", goToEstatisticas)

        line1 = display.newLine( -140, 173, 0, 173 )
        line1:setStrokeColor(ragdogLib.convertHexToRGB("#999999"))
        line1.strokeWidth = 0.9

        opcMenuComoJogar = display.newText( "¤  Como Jogar", -140, 181, native.systemFont, 15 )
        opcMenuComoJogar:setFillColor( 1, 1, 1 )
        opcMenuComoJogar.xAlign, opcMenuComoJogar.anchorX, opcMenuComoJogar.anchorY = "left", 0, 0
        opcMenuComoJogar:addEventListener("touch", goToComoJogar)

        line2 = display.newLine( -140, 206, 0, 206 )
        line2:setStrokeColor(ragdogLib.convertHexToRGB("#999999"))
        line2.strokeWidth = 0.9

        opcMenuSugestoes = display.newText( "¤  Sugestões", -140, 214, native.systemFont, 15 )
        opcMenuSugestoes:setFillColor( 1, 1, 1 )
        opcMenuSugestoes.xAlign, opcMenuSugestoes.anchorX, opcMenuSugestoes.anchorY = "left", 0, 0
        opcMenuSugestoes:addEventListener("touch", goToSugestoes)

        line3 = display.newLine( -140, 239, 0, 239 )
        line3:setStrokeColor(ragdogLib.convertHexToRGB("#999999"))
        line3.strokeWidth = 0.9

        opcMenuSair = display.newText( "¤  Desconectar", -140, 246, native.systemFont, 15 )
        opcMenuSair:setFillColor( 1, 1, 1 )
        opcMenuSair.xAlign, opcMenuSair.anchorX, opcMenuSair.anchorY = "left", 0, 0
        opcMenuSair:addEventListener("touch", goToSair)


        lineEnd = display.newLine( -175, 272, 0, 272 )
        lineEnd:setStrokeColor(ragdogLib.convertHexToRGB("#999999"))
        lineEnd.strokeWidth = 0.9
        




        transition.to(menu, {time=400, x = menu.x + display.actualContentWidth*0.55})
        transition.to(menu_close, {time=400, x = menu_close.x + display.actualContentWidth/2})
        transition.to(logo, {time=400, x = logo.x + display.actualContentWidth/2})
        transition.to(opcMenuEstatisticas, {time=400, x = opcMenuEstatisticas.x + display.actualContentWidth/2})
        transition.to(opcMenuComoJogar, {time=400, x = opcMenuComoJogar.x + display.actualContentWidth/2})
        transition.to(opcMenuSugestoes, {time=400, x = opcMenuSugestoes.x + display.actualContentWidth/2})
        transition.to(opcMenuSair, {time=400, x = opcMenuSair.x + display.actualContentWidth/2})


        transition.to(slider, {time=400, x = slider.x + display.actualContentWidth*0.545})


        transition.to(lineBeginTop, {time=400, x = lineBeginTop.x + display.actualContentWidth*0.545})
        transition.to(lineBegin, {time=400, x = lineBegin.x + display.actualContentWidth *0.545})
        transition.to(line1, {time=400, x = line1.x + display.actualContentWidth*0.545})
        transition.to(line2, {time=400, x = line2.x + display.actualContentWidth*0.545})
        transition.to(line3, {time=400, x = line3.x + display.actualContentWidth*0.545})
        transition.to(lineEnd, {time=400, x = lineEnd.x + display.actualContentWidth*0.545})



        
    end
end

return slide_menu