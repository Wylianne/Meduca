local composer =  require("composer") 

local menuPrincipal = composer.newScene()

local slide = require("slide_menu")

local widget = require( "widget" )

local function onMenuTouch(event)
    if ( event.phase == "ended" ) then
        slide:onMenuTouch()
    end
end

function secondMenu(event)
    if (event.phase == "ended") then
        composer.gotoScene("menuPrincipal_2")
    end
end

function goToQuebraOssos(event)
    if (event.phase == "ended") then
        composer.gotoScene("quebra_ossos")
    end
end

function goToSomaOssos(event)
    if (event.phase == "ended") then
        composer.gotoScene("soma_ossos")
    end
end

function goToPalavrasCruzadas(event)
    if (event.phase == "ended") then
        composer.gotoScene("palavras_cruzadas")
    end
end

function goToQuiz(event)
    if (event.phase == "ended") then
        composer.gotoScene("quiz")
    end
end

function goToTiroAlvo(event)
    if (event.phase == "ended") then
        composer.gotoScene("tiro_alvo")
    end
end
 
function menuPrincipal:create(event)
    local SceneGroup = self.view
    
    local background = display.newImageRect( "menu_principal/fundo_menu1.png", 360, 570 )
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

    local right = display.newImageRect( "menu_principal/right.png", 18, 30 )
    right.x = display.contentCenterX + 130
    right.y = 45
    SceneGroup:insert(right)
    right:addEventListener("touch", secondMenu)

    local star = display.newImageRect( "menu_principal/star.png", 80, 80 )
    star.x = display.contentCenterX
    star.y = 40
    SceneGroup:insert(star)

    local media = display.newText("7", 80, 45)
    media.x = display.contentCenterX
    SceneGroup:insert(media)


    local soma_ossos = display.newImageRect( "menu_principal/soma_ossos.png", 70, 70 )
    soma_ossos.x = display.contentCenterX - 100
    soma_ossos.y = 150
    SceneGroup:insert(soma_ossos)
    soma_ossos:addEventListener("touch", goToSomaOssos)

    local palavras_cruzadas = display.newImageRect( "menu_principal/palavras_cruzadas.png", 70, 70 )
    palavras_cruzadas.x = display.contentCenterX
    palavras_cruzadas.y = 150
    SceneGroup:insert(palavras_cruzadas)  
    palavras_cruzadas:addEventListener("touch", goToPalavrasCruzadas)  

    local quebra_ossos = display.newImageRect( "menu_principal/quebra_ossos.png", 70, 70 )
    quebra_ossos.x = display.contentCenterX + 100
    quebra_ossos.y = 150
    SceneGroup:insert(quebra_ossos)
    quebra_ossos:addEventListener("touch", goToQuebraOssos)

    local quiz = display.newImageRect( "menu_principal/quiz.png", 70, 70 )
    quiz.x = display.contentCenterX - 100
    quiz.y = 250
    SceneGroup:insert(quiz)
    quiz:addEventListener("touch", goToQuiz)

    local tiroAlvo = display.newImageRect( "menu_principal/alvo.png", 70, 70 )
    tiroAlvo.x = display.contentCenterX
    tiroAlvo.y = 250
    SceneGroup:insert(tiroAlvo)
    tiroAlvo:addEventListener("touch", goToTiroAlvo)


end

menuPrincipal:addEventListener("create", menuPrincipal)
return menuPrincipal