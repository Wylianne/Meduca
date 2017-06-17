native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer =  require("composer") 

local quiz = composer.newScene()

local widget = require("widget")

local ragdogLib = require "ragdogLib";

local slide = require("slide_menu")

local String = require("string")
local sqlite3 = require( "sqlite3" )

local path = system.pathForFile( "meduca.db", system.DocumentsDirectory )
local db = sqlite3.open( path ) 

local slide = audio.loadSound( "audios/slide.wav" )
 
local function misturaAlternativas( t )
    local rand = math.random
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end

-- Image sheet options and declaration
local options = {
    width = 280,
    height = 50,
    numFrames = 2,
    sheetContentWidth = 280,
    sheetContentHeight = 100
}
local radioButtonSheet = graphics.newImageSheet( "img_jogos/checkbox.png", options )

alterViewOpc = {"A","B","C","D","E"}
acertos = 0
erros = 0


function insertPointBD(ponto)
    local tablefill = [[INSERT INTO quiz VALUES (NULL, ']]..ponto..[['); ]]
    db:exec( tablefill )
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

local function onSwitchPress( event )
    
    geraButtons()
    if (alter[event.target.id] == respostaCorreta) then
        corecao = "correto"
    else
        corecao = "errado"
    end
end

function geraButtons()
    if (buttons) then
        btnFinish = widget.newButton({
            left = 30,
            top = 310,   
            label = "Finalizar",
            shape = "roundedRect",
            width = 90,
            height = 25,
            cornerRadius = 0,
            labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fillColor = { default={ragdogLib.convertHexToRGB("#b40000")}, over={ragdogLib.convertHexToRGB("#b40000")} },
            strokeColor = { default={ragdogLib.convertHexToRGB("#a60000")}, over={ragdogLib.convertHexToRGB("#a60000")} },
            strokeWidth = 5,
            id = 1,
            onEvent = mostraRespostaCorreta
            
        })
        btnFinish.x = display.contentCenterX - 92
        btnFinish.y = display.contentCenterY*2
        SceneGroup:insert(btnFinish)

        btnNext = widget.newButton({
            left = 130,
            top = 310,   
            label = "Próxima",
            shape = "roundedRect",
            width = 90,
            height = 25,
            cornerRadius = 0,
            labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fillColor = { default={ragdogLib.convertHexToRGB("#007800")}, over={ragdogLib.convertHexToRGB("#007800")} },
            strokeColor = { default={ragdogLib.convertHexToRGB("#006400")}, over={ragdogLib.convertHexToRGB("#006400")} },
            strokeWidth = 5,
            id = 2,
            onEvent = mostraRespostaCorreta
            
        })
        btnNext.x = display.contentCenterX + 92
        btnNext.y = display.contentCenterY*2
        SceneGroup:insert(btnNext)        

        buttons = false
    end
end

local function radioButtons()
    -- Create a group for the radio button set
    
    local radioGroup = display.newGroup()
    local testGroup = display.newGroup()

    qntOpc = qntOpc + 1

    if (qntOpc <= 5) then
        radioButton1 = widget.newSwitch(
            {
                left = 360,
                top = 140 + qntOpc*50,
                style = "radio",
                id = qntOpc,
                width = 280,
                height = 49,
                initialSwitchState = false,
                onPress = onSwitchPress,
                sheet = radioButtonSheet,
                frameOff = 1,
                frameOn = 2
            }
        )

        radioGroup:insert( radioButton1 )
        SceneGroup:insert(radioButton1)

        texto=alter[qntOpc]
        local teste = display.newText(texto, 80, 163+(qntOpc*50), native.systemFont, 22 )
        teste.x = display.contentCenterX
        sizeText = teste.width
        --print(sizeText)
        teste:removeSelf()

        --fazer função que retorna a altura e largura do texto
        --fazer calculos na função para que o texto fique no centro da imagem de alternativas
        if (sizeText > 500) then
            opcY = 24
            fontS = 14
        elseif (sizeText <= 500 and sizeText > 280) then
            opcY = 18
            fontS = 15
        elseif (sizeText <= 280) then
            opcY = 8
            fontS = 15
        end

        local options = {
           text = alter[qntOpc],
           x = display.contentCenterX,
           y = radioButton1.y - opcY,
           font = native.systemFont,
           fontSize = fontS,
           width = 190,
           align = "left"
        }

        --420, 153+(qntOpc*50)

        local alterViewOpc = display.newText(alterViewOpc[qntOpc], 385, 163+(qntOpc*50), native.systemFont, 22 )
        local alterView = display.newText(options )
        alterView.anchorX, alterView.anchorY = 0, 0
        SceneGroup:insert(alterViewOpc)
        SceneGroup:insert(alterView)

        audio.play( slide )

        transition.moveTo( alterView, { x=85, time=230 } )
        transition.moveTo( alterViewOpc, { x=45, time=230 } )
        transition.moveTo( radioButton1, { x=160, time=240 } )

        timer.performWithDelay( 230, radioButtons )    
    end
end

function telaFimJogo()
    -- body
end

function mostraRespostaCorreta(event)
    if (event.phase == "ended") then
        for i=1, 5, 1 do
            if ( alter[i] == respostaCorreta ) then


                local resCData = { width=280, height=50, numFrames=3, sheetContentWidth=280, sheetContentHeight=150 }
                local resC = graphics.newImageSheet( "img_jogos/checkbox-resposta.png", resCData )
                
                sequenceData = {name="seq1", sheet=resC, start=1, count=2, time=250, loopCount=8 }
                
                myAnimation = display.newSprite( resC, sequenceData )
                myAnimation.x = display.contentCenterX
                myAnimation.y = 164 + i*50
                myAnimation:play()
                SceneGroup:insert(myAnimation)
                print(event.target.id)

                if (corecao == "correto") then
                    acertos = acertos + 1
                else
                    erros = erros + 1
                end

                if (event.target.id == 2) then
                    timer.performWithDelay(2000, proximaPergunta)
                else
                    timer.performWithDelay(2000, finalizarJogo)
                end
                
            end
        end
    end
end

function proximaPergunta()

    btnFinish:removeSelf()
    btnNext:removeSelf()

    composer.gotoScene("quiz")
end

function finalizarJogo()
    local total = acertos + erros
    acertos = (acertos*100/total)
    erros = (erros*100/total)

    acertos = tonumber(string.format("%." .. (1 or 0) .. "f", acertos))
    erros = tonumber(string.format("%." .. (1 or 0) .. "f", erros))

    insertPointBD(acertos)

    telaFimJogo()

    erros = 0
    acertos = 0
end

function telaFimJogo()

    
    if (acertos >= 85.0) then
        mensagem = "Impressionante!"
        img = "img_jogos/star-3.png"
    elseif (tonumber(acertos) < 85.0 and tonumber(acertos) >= 70.0) then
        mensagem = "Maravilhoso!"
        img = "img_jogos/star-2.png"
    elseif (tonumber(acertos) < 70.0 and tonumber(acertos) >= 0.1) then
        mensagem = "Vamos Treinar?"
        img = "img_jogos/star-1.png"
    else
        mensagem = "Vamos Treinar?"
        img = "img_jogos/star-0.png"
    end  

    myAnimation:removeSelf()

    vitoria = display.newImageRect( "img_jogos/fimJogo.png", 250, 350)
    vitoria.x = display.contentCenterX
    vitoria.y = display.contentCenterY
    SceneGroup:insert(vitoria)


    textVitoria = display.newText( mensagem, 150, 80, "AMAZB__.ttf", 35 )
    textVitoria.x = display.contentCenterX
    textVitoria.y = display.contentCenterY * 0.45
    SceneGroup:insert(textVitoria)

    star = display.newImageRect( img, 209.33, 83.66)
    star.x = display.contentCenterX
    star.y = display.contentCenterY * 0.7
    SceneGroup:insert(star)

    skull = display.newImageRect( "img_jogos/teste.png", 90, 81.5)
    skull.x = display.contentCenterX
    skull.y = display.contentCenterY * 1.08
    SceneGroup:insert(skull)



    local jogarNovamente = widget.newButton({
        left = 120,
        top = 310,   
        label = "Jogar Novamente",
        shape = "roundedRect",
        width = 150,
        height = 30,
        cornerRadius = 6,
        labelColor = { default={ragdogLib.convertHexToRGB("#2e435e")}, over={ ragdogLib.convertHexToRGB("#2e435e") } },
        fillColor = { default={ragdogLib.convertHexToRGB("#fbcc02")}, over={ragdogLib.convertHexToRGB("#f7d804")} },
        strokeColor = { default={1,0,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 0,
        onEvent = novoJogo        
    })

    jogarNovamente.x = display.contentCenterX
    jogarNovamente.y = display.contentCenterY*1.55
    SceneGroup:insert(jogarNovamente)

    scoreFinal = display.newText("Score: "..acertos, 300, 200, "AMAZB__.ttf", 35)
    scoreFinal.x = display.contentCenterX
    scoreFinal.y = display.contentCenterY * 1.35
    SceneGroup:insert(scoreFinal)
end


function novoJogo(event)
    if ( event.phase == "ended" ) then
        composer.gotoScene("quiz")
    end
end

function quiz:create(event)

end

function quiz:show(event)
    if ( event.phase == "did" ) then
        SceneGroup = self.view

        qntOpc=0

        for row in db:nrows("SELECT count(*) as count FROM quiz_perguntas") do
            id_pergunta = tonumber(row.count)
        end

        id_pergunta = math.random(id_pergunta)
        
        for row in db:nrows("SELECT * FROM quiz_perguntas WHERE id = "..id_pergunta) do
            pergunta = row.pergunta
            alter = {row.alter_1, row.alter_2, row.alter_3, row.alter_4, row.alter_5}
            respostaCorreta = row.resposta
        end

        misturaAlternativas(alter)

        buttons = true

        local background = display.newImageRect( "menu_principal/fundo_menu1.png", display.contentCenterX*2, display.contentCenterY*2.37 )
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        SceneGroup:insert(background)

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


        --local barPergunta = display.newRect(0,90,280,150)
        --barPergunta:setFillColor(0.2,0.4,0.7, 0.1) -- diminuir a transparencia fica da mesma cor das opcs
        --barPergunta:setFillColor(0.2,0.4,0.6, 0.9)
        --barPergunta:setFillColor(0.5,0.6,1, 0.4)

        radioButtons(1)

        local barPergunta = display.newImageRect("img_jogos/quiz_pergunta.png",280,170)
        barPergunta.x = display.contentCenterX
        barPergunta.y = display.contentCenterY / 3 + 5
        SceneGroup:insert(barPergunta)

        local options = {
           text = pergunta,
           x = display.contentCenterX,
           y = barPergunta.y,
           font = native.systemFont,
           fontSize = 18,
           width = barPergunta.width - 20,
           align = "center"
        }
        local textPergunta = display.newText(options)
        textPergunta:setFillColor(1,1,1)

        SceneGroup:insert(textPergunta)

    end
end


function quiz:destroy(event)
    quiz:show()
end

quiz:addEventListener( "create", quiz )
quiz:addEventListener( "show", quiz )
quiz:addEventListener( "hide", quiz )
quiz:addEventListener( "destroy", quiz )


return quiz