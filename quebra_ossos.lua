local composer =  require("composer") 

local quebraOssos = composer.newScene()

local slide = require("slide_menu")

local widget = require("widget")
local String = require("string")

palavraReal = "ÍSQUIO" --ate 10 letras
palavra = "ISQUIO" --12letras
dicas = {"É um osso", "Localizado em uma das extremidades", "Localizado na extremidade inferior"}


local function geraEsqueleto ()
    local tornadoData = { width=70, height=183, numFrames=33, sheetContentWidth=2310, sheetContentHeight=183 }
    local tornado = graphics.newImageSheet( "img_jogos/fumaca2.png", tornadoData )

    if (scorePoint.text == "100") then
        sequenceData = {name="seq1", sheet=tornado, start=1, count=1, time=0, loopCount=1 }
    elseif (erroLetra == 1) then
        myAnimation:removeSelf()
        sequenceData = {name="seq1", sheet=tornado, start=1, count=7, time=400, loopCount=1 }
    elseif (erroLetra == 2) then
        myAnimation:removeSelf()
        sequenceData = {name="seq1", sheet=tornado, start=7, count=7, time=400, loopCount=1 }
        viewDica(0)
    elseif (erroLetra == 3) then
        myAnimation:removeSelf()
        sequenceData = {name="seq1", sheet=tornado, start=13, count=6, time=400, loopCount=1 }
    elseif (erroLetra == 4) then
        myAnimation:removeSelf()
        sequenceData = {name="seq1", sheet=tornado, start=18, count=5, time=400, loopCount=1 }
        viewDica(1)
    elseif (erroLetra == 5) then
        myAnimation:removeSelf()
        sequenceData = {name="seq1", sheet=tornado, start=23, count=7, time=500, loopCount=1 }
        viewDica(2)
    elseif (erroLetra == 6) then
        myAnimation:removeSelf()
        sequenceData = {name="seq1", sheet=tornado, start=29, count=5, time=400, loopCount=1 }


        timer.performWithDelay( 2000,telaDerrota)
    end

                 
    myAnimation = display.newSprite( tornado, sequenceData )
    myAnimation.x = display.contentCenterX
    myAnimation.y = 111
    SceneGroup:insert(myAnimation)
    myAnimation:play()

end

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

function dica(event)
    if (event.phase == "ended") then
        viewDica(event.target.id)        
    end
end

function viewDica(dica)
    if (valueDica <= dica) then
        valueDica = valueDica + 1
        local dica = display.newText( dicas[valueDica], 45, 215 + ((valueDica) * 25 ), native.systemFont, 16 )
        dica:setFillColor(0.2,0.4,0.6)
        dica.anchorX, dica.anchorY = 0, 0
        SceneGroup:insert(dica)

        if (valueDica == 1) then
            dica1.isVisible = false
            dica1 = display.newImage("img_jogos/broken-heart.png")
            dica1:translate( 30, 250 )
            SceneGroup:insert(dica1)
        elseif (valueDica == 2) then
            dica2.isVisible = false
            dica2 = display.newImage("img_jogos/broken-heart.png")
            dica2:translate( 30, 275 )
            SceneGroup:insert(dica2)
            changeScore("dica")
        elseif (valueDica == 3) then
            dica3.isVisible = false
            dica3 = display.newImage("img_jogos/broken-heart.png")
            dica3:translate( 30, 300 )
            SceneGroup:insert(dica3)
            changeScore("dica")
        end
    end
end

function valida(letra)

    localizacao = ( string.find( palavra, letra, 1, true ) )
    print(localizacao)

    if (localizacao ~= nil) then
        palavra = string.gsub(palavra, letra, "-", 1)

        viewLetra = display.newText(letra, posicao[localizacao]+11 , 360)

        viewLetra:setFillColor(0.2,0.4,0.6)        
        SceneGroup:insert(viewLetra)
        change = 1
        valida(letra)
    end

    if (change == 0) then
        erroLetra = erroLetra + 1
        changeScore("letra")
    end
end

function changeScore (tipo)
    if (tonumber(scorePoint.text) == 16) then
        scorePoint.text = "0"
    elseif (tonumber(scorePoint.text) > 0) then
        scorePoint.text = tonumber(scorePoint.text) - 12
       
    end

    if (tipo == "letra") then
        geraEsqueleto()
    end
end

function viewLabelEvent (event)
    if (event.phase == "ended") then
        --local alert = native.showAlert( "Corona", event.target.id, { "OK", "Learn More" }, onComplete )
        print(scorePoint.text)
        if (scorePoint.text ~= "0") then
            change = 0
            valida(event.target.id)
            event.target:removeSelf()
        end
        
    end
end

alfabeto = {"A", "B", "C", "D", "E", "F", "G", "H", "I", 
         "J", "K", "L", "M", "N", "O", "P", "Q",  
         "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
posicaoI = nil

function geraPalavra()
    posicaoI = nil
    posicao = {}


    dica1 = display.newImage( "img_jogos/heart.png" )
    dica1:translate( 30, 250 )
    dica1.id = 1
    SceneGroup:insert(dica1)
    dica1:addEventListener( "touch", dica )
    dica2 = display.newImage( "img_jogos/heart.png" )
    dica2:translate( 30, 275 )
    dica2.id = 2
    SceneGroup:insert(dica2)
    dica2:addEventListener( "touch", dica )
    dica3 = display.newImage( "img_jogos/heart.png" )
    dica3:translate( 30, 300 )
    dica3.id = 3
    SceneGroup:insert(dica3)
    dica3:addEventListener( "touch", dica )


    for i=1, String.len(palavra), 1 do
        if (posicaoI == nil) then
            lenWord = String.len(palavra)
            posicaoI = ((display.contentCenterX * 2) - (20 * lenWord + ((lenWord -1 ) * 5))) / 2
        end

        if (string.find(palavra, " ") ~= i) then
            linha = display.newLine( posicaoI, 370, (posicaoI+20), 370 )
            linha.anchorX, linha.anchorY = 0, 0
            --print(posicaoI)
            linha.strokeWidth = 2
            linha:setStrokeColor(0.2,0.4,0.6)
            SceneGroup:insert(linha)

            posicao[i], linha.x = posicaoI, posicaoI
            posicaoI = posicaoI + 25
        else
            posicaoI = posicaoI +15
        end


    end
end

function  montaAlfabeto()
    for i=1, 26, 1 do
        if i==1 then
            posicaoI = display.contentCenterX - (30 * 4.3)
            topButton = 400
        elseif i==10 then
            posicaoI = display.contentCenterX - (30 * 3.8)
            topButton = topButton + 30
        elseif i==18 then
            posicaoI = display.contentCenterX - (30 * 4.3)
            topButton = topButton + 30
        elseif i~=1 then
            posicaoI = posicaoI + 30
        end
        

        local btnLetras = widget.newButton({
            left = posicaoI,
            top = topButton,   
            label = alfabeto[i],  
            id = alfabeto[i],
            shape = "roundedRect",
            width = 20,
            height = 25,
            cornerRadius = 10,
            labelColor = { default={ 0.2,0.4,0.6 }, over={ 0.2,0.4,0.6, 0.5 } },
            fillColor = { default={1,1,1,1}, over={1,1,1,1} },
            strokeColor = { default={1,0,0,1}, over={0.8,0.8,1,1} },
            strokeWidth = 0,
            onEvent = viewLabelEvent
        
        })

        SceneGroup:insert(btnLetras)
    end
end

function telaDerrota()

    myAnimation:removeSelf()

    derrota = display.newImageRect( "img_jogos/derrota.png", 250, 350)
    derrota.x = display.contentCenterX
    derrota.y = display.contentCenterY
    SceneGroup:insert(derrota)

    local jogarNovamente = widget.newButton({
        left = 120,
        top = 310,   
        label = "Jogar Novamente",
        shape = "roundedRect",
        width = 150,
        height = 25,
        cornerRadius = 5,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={0,0.4,1,1}, over={0,0.2,0.9,1} },
        strokeColor = { default={1,0,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 0,
        onEvent = novoJogo
        
    })

    jogarNovamente.x = display.contentCenterX
    jogarNovamente.y = display.contentCenterY*1.6
    SceneGroup:insert(jogarNovamente)

    scoreFinal = display.newText(tostring(scorePoint.text), 300, 200, native.systemFont, 30)
    scoreFinal.x = display.contentCenterX * 1.1
    scoreFinal.y = display.contentCenterY * 1.32
    SceneGroup:insert(scoreFinal)
end

function telaVitoria()

    myAnimation:removeSelf()

    derrota = display.newImageRect( "img_jogos/vitoria.png", 250, 350)
    derrota.x = display.contentCenterX
    derrota.y = display.contentCenterY
    SceneGroup:insert(derrota)

    local jogarNovamente = widget.newButton({
        left = 120,
        top = 310,   
        label = "Jogar Novamente",
        shape = "roundedRect",
        width = 150,
        height = 25,
        cornerRadius = 5,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={0,0.4,1,1}, over={0,0.2,0.9,1} },
        strokeColor = { default={1,0,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 0,
            onEvent = viewFieldsEvent
        
    })

    jogarNovamente.x = display.contentCenterX
    jogarNovamente.y = display.contentCenterY*1.6
    SceneGroup:insert(jogarNovamente)

    scoreFinal = display.newText(tostring(scorePoint.text), 300, 200, native.systemFont, 30)
    scoreFinal.x = display.contentCenterX * 1.1
    scoreFinal.y = display.contentCenterY * 1.32
    SceneGroup:insert(scoreFinal)
end

function novoJogo(event)
    quebraOssos:destroy()
end

function quebraOssos:create(event)
end

function quebraOssos:show(event)
    SceneGroup = self.view
    
    erroLetra = 0
    valueDica = 0

    local background = display.newImageRect( "menu_principal/fundo_menu1.png", 360, 570 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    SceneGroup:insert(background)

    local barTop = display.newRect(0,-30,320,30)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = display.contentCenterX
    SceneGroup:insert(barTop)

    nameApp = display.newText("Meduca - Quebra Ossos", 0, -30)
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

    score = display.newText("Score:", display.contentCenterX * 1.6, 0)
    score:setFillColor(0.2,0.4,0.6)
    --score.x = display.contentCenterX
    SceneGroup:insert(score)

    scorePoint = display.newText("100", display.contentCenterX * 1.9, 0)
    scorePoint:setFillColor(0.2,0.4,0.6)
    --score.x = display.contentCenterX
    SceneGroup:insert(scorePoint)

    montaAlfabeto()    
    geraPalavra()
    geraEsqueleto()
    

end


function quebraOssos:destroy(event)
    quebraOssos:show()
end

quebraOssos:addEventListener( "create", quebraOssos )
quebraOssos:addEventListener( "show", quebraOssos )
quebraOssos:addEventListener( "hide", quebraOssos )
quebraOssos:addEventListener( "destroy", quebraOssos )

return quebraOssos