native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

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
        if (menuActive == false) then
            composer.gotoScene("menuPrincipal_2")
        end
    end
end

function goToQuebraOssos(event)
    if (event.phase == "began") then
        if (menuActive == false) then
            composer.gotoScene("quebra_ossos")
        end
    end

    return true
end

function goToSomaOssos(event)
    if (event.phase == "began") then
        if (menuActive == false) then
            local options =
            {
                effect = "slideLeft",
                time = 300,
                params = {
                    jogo = "somaOssos"
                }
            }
            composer.gotoScene("geraFases", options)
        end
    end
end

function goToPalavrasCruzadas(event)
    if (event.phase == "began") then
        if (menuActive == false) then
             composer.gotoScene("fases_cruzadas")
        end

    end
end

function goToQuiz(event)
    if (event.phase == "began") then
        if (menuActive == false) then
            composer.gotoScene("quiz")
        end
    end
end

function goToTiroAlvo(event)
    if (event.phase == "began") then
        if (menuActive == false) then
            composer.gotoScene("tiro_alvo")
        end
    end
end

function JogoBonus(event)
    if (event.phase == "began") then
        if (menuActive == false) then
            composer.gotoScene("jogoBonus")
        end
    end
end
 
function menuPrincipal:create(event)
    local SceneGroup = self.view
    
    local background = display.newImageRect( "menu_principal/fundo_menu1.png", display.contentCenterX*2, display.contentCenterY*2.37 )
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


    local soma_ossos = display.newImageRect( "menu_principal/soma_ossos.png", display.contentCenterX*0.44, display.contentCenterX*0.45 )
    soma_ossos.x = display.contentCenterX * 0.37
    soma_ossos.y = display.contentCenterY * 0.625
    SceneGroup:insert(soma_ossos)
    soma_ossos:addEventListener("touch", goToSomaOssos)

    local palavras_cruzadas = display.newImageRect( "menu_principal/palavras_cruzadas.png", display.contentCenterX*0.44, display.contentCenterX*0.45 )
    palavras_cruzadas.x = display.contentCenterX
    palavras_cruzadas.y = display.contentCenterY * 0.625
    SceneGroup:insert(palavras_cruzadas)  
    palavras_cruzadas:addEventListener("touch", goToPalavrasCruzadas)  

    local quebra_ossos = display.newImageRect( "menu_principal/quebra_ossos.png", display.contentCenterX*0.44, display.contentCenterX*0.45 )
    quebra_ossos.x = display.contentCenterX * 1.63
    quebra_ossos.y = display.contentCenterY * 0.625
    SceneGroup:insert(quebra_ossos)
    quebra_ossos:addEventListener("touch", goToQuebraOssos)

    local quiz = display.newImageRect( "menu_principal/quiz.png", display.contentCenterX*0.44, display.contentCenterX*0.45 )
    quiz.x = display.contentCenterX * 0.37
    quiz.y = display.contentCenterY * 1.045
    SceneGroup:insert(quiz)
    quiz:addEventListener("touch", goToQuiz)

    local tiroAlvo = display.newImageRect( "menu_principal/alvo.png", display.contentCenterX*0.44, display.contentCenterX*0.45 )
    tiroAlvo.x = display.contentCenterX
    tiroAlvo.y = display.contentCenterY * 1.045
    SceneGroup:insert(tiroAlvo)
    tiroAlvo:addEventListener("touch", goToTiroAlvo)
    
    local jogoBonus = display.newImageRect( "menu_principal/bonus.png", display.contentCenterX*0.44, display.contentCenterX*0.45 )
    jogoBonus.x = display.contentCenterX * 1.63
    jogoBonus.y = display.contentCenterY * 1.045
    SceneGroup:insert(jogoBonus)
    jogoBonus:addEventListener("touch", JogoBonus)

end

menuPrincipal:addEventListener("create", menuPrincipal)
return menuPrincipal