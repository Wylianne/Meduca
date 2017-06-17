native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer =  require("composer") 

local comoJogar = composer.newScene()

local widget = require("widget")

local slide = require("slide_menu")

local ragdogLib = require "ragdogLib";

lotsOfText = ""

jogos = {"Soma Ossos","Palavras Cruzadas","Quebra Ossos","Quiz","Blood Invaded","Análises Biológicas","Clínica"}

descricao  = {"Neste jogo será solicitado os ossos que compõem uma determinada parte do corpo, por exemplo, o jogo solicita os ossos que compõem a perna, ela possui dois ossos, a tíbia e a fíbula, na tela do jogo aparecerá vários ossos e o jogador terá que selecionar esses dois, quando o osso é selecionado ele se move da parte onde aparecem as possibilidades e aparece na sentença. \nOs ossos que aparecem nas possibilidades são aleatórios, dessa forma o jogador pode solicitar no máximo três vezes que as possibilidades sejam refeitas.",
              "Jogo comum de palavras cruzadas, onde o jogador deve adivinhar quais palavras preenchem os espaços em branco. Este jogo foi dividido em fases. \nPara visualizar as dicas é necessário clicar nos espaços que contém alguma seta e arrastar o dedo no sentido da dica (seta) que deseja visualizar, pois alguns espaços possuem mais de uma dica. As dicas são exibidas no topo da tela. \nClicando no botão de validar o jogador poderá verificar se as letras inseridas estão corretas, só será possível verificar as letras no máximo 3 vezes por jogo. O jogador poderá também reiniciar o jogo clicando no botão ao lado esquerdo de validar, se clicar nesse botão tudo que foi preenchido será apagado inclusive a pontuação atual do jogo.",
              "Quebra Ossos",
              "O jogador deve selecionar uma resposta para que os botões de próxima pergunta e finalizar o jogo aparecam, somente é possível selecionar uma única resposta correta. \nQuando a responta for selecionada o seu fundo fica verde.",
              "Blood Invaded",
              "Análises Biológicas",
              "Clínica"}

local function onMenuTouch(event)
    if ( event.phase == "ended" ) then
        slide:onMenuTouch()

        scrollView:setIsLocked( true )
    end
    return true
end

function backMenu(event)
    if (event.phase == "ended") then
        composer.gotoScene("menuPrincipal")
    end
end


function comoJogar:create(event)

    SceneGroup = self.view

    local background = display.newImageRect( "menu_principal/fundo_menu1.png", display.contentCenterX*2, display.contentCenterY*2.37 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    SceneGroup:insert(background)

    local barTop = display.newRect(0,-30,320,30)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = display.contentCenterX
    SceneGroup:insert(barTop)

    nameApp = display.newText("Meduca - Como Jogar", 0, -30)
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



    textcomoJogar = display.newText("Como Jogar", display.contentCenterX * 0.09, display.contentCenterY * 0.1, native.systemFont, 20 )
    textcomoJogar:setFillColor(ragdogLib.convertHexToRGB("#336699"))
    textcomoJogar.y = display.contentCenterY * 0.1
    textcomoJogar.x = display.contentCenterX
    SceneGroup:insert(textcomoJogar)


    scrollView = widget.newScrollView({
        top = 70,
        left = 5,
        width = display.contentCenterX * 1.9,
        height = display.contentCenterY *1.68,
        topPadding = 0,
        bottomPadding = 5,
        horizontalScrollDisabled = true,
        verticalScrollDisable = false,
        hideBackground = true
    })

    SceneGroup:insert(scrollView)

    for i=1, 7, 1 do
        lotsOfText = lotsOfText..jogos[i].."\n\n"..descricao[i].."\n\n\n"
    end


    lotsOfTextObject = display.newText(lotsOfText, 0, 0, 260, 0, "Helvetica", 14)
    lotsOfTextObject:setTextColor(ragdogLib.convertHexToRGB("#336699"))
    lotsOfTextObject.x = display.contentCenterX
    lotsOfTextObject.y = 595
    scrollView:insert(lotsOfTextObject)

end


comoJogar:addEventListener( "create", comoJogar )

return comoJogar