local composer =  require("composer") 

local faseUm = composer.newScene()

local slide = require("slide_menu")

local widget = require("widget")

local ragdogLib = require "ragdogLib";

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "meduca.db", system.DocumentsDirectory )
local db = sqlite3.open( path ) 


--Inicializa ossos
osso = {
    {"img_jogos/somaOssos/femur.png", "femur"},
    {"img_jogos/somaOssos/tibia.png", "tibia"},
    {"img_jogos/somaOssos/fibula.png", "fibula"},
    {"img_jogos/somaOssos/umero.png", "umero"},
    {"img_jogos/somaOssos/ulna.png", "ulna"},
    {"img_jogos/somaOssos/coccix.png", "coccix"},
    {"img_jogos/somaOssos/sacro.png", "sacro"},
    {"img_jogos/somaOssos/radio.png", "radio"},


    {"img_jogos/somaOssos/tibia.png", "tibia"},
    {"img_jogos/somaOssos/fibula.png", "fibula"},
    {"img_jogos/somaOssos/femur.png", "femur"},
    {"img_jogos/somaOssos/tibia.png", "tibia"},
    {"img_jogos/somaOssos/fibula.png", "fibula"},
}

function insertPointSO(ponto)
    local tablefill = [[INSERT INTO soma_ossos VALUES (NULL, ']]..ponto..[['); ]]
    db:exec( tablefill )
end

local function misturaAlternativas( t )
    local rand = math.random
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i][1], t[j][1] = t[j][1], t[i][1]
        t[i][2], t[j][2] = t[j][2], t[i][2]
    end

    return t
end

function changeFaseDes(ponto)

    if (qnt_fases_d == nivel) then
        fasesDes = qnt_fases_d + 1
        local tablefill = [[UPDATE fases SET qnt_fases_d = ]]..fasesDes..
                          [[ WHERE nome_jogo = ']]..nomeJogo..
                          [[' and qnt_fases_d = ]]..nivel..
                          [[; ]]

        db:exec( tablefill )
    end
end

local function onMenuTouch(event)
    if ( event.phase == "ended" ) then
        slide:onMenuTouch()
    end
    return true
end

function backMenu(event)
    if (event.phase == "ended") then

        local options =
        {
            effect = "slideRight",
            time = 300,
            params = {
                jogo = nomeJogo
            }
        }

        composer.gotoScene("geraFases", options)
    end
end

function localResposta()
    yFaseF = 200

    if (totalRespostas == 3) then
        iniFase = display.contentCenterX - 100
    elseif (totalRespostas == 2) then
        iniFase = display.contentCenterX - 50
    elseif (totalRespostas == 1) then
        iniFase = display.contentCenterX
    end

    local localReservado = display.newRoundedRect(display.contentCenterX * 1.05, 30, 265,130,12)
    localReservado:setFillColor(0.2,0.4,0.6)
    localReservado.y = yFaseF - 130
    localReservado.x = display.contentCenterX
    localReservado.strokeWidth = 3
    localReservado:setStrokeColor(0.2,0.4,0.6)
    SceneGroup:insert(localReservado)

    textAjuda = display.newText(dica, display.contentCenterX, localReservado.y,  native.systemFont, 30)
    textAjuda.isVisible = false

    local imgAjuda = display.newImageRect( "img_jogos/info.png", 20, 20 )
    imgAjuda.x = display.contentCenterX * 1.72
    imgAjuda.y = localReservado.y * 1.72
    imgAjuda:addEventListener("touch", viewHelp)
    SceneGroup:insert(imgAjuda)

    local imgSoma = display.newImage(img_pergunta, display.contentCenterX, localReservado.y)
    SceneGroup:insert(imgSoma)

    for i = 1, totalRespostas, 1 do

        local soma_ossos = display.newImageRect( "img_jogos/somaOssosP.png", 65, 65 )
        soma_ossos.x = iniFase
        soma_ossos.y = yFaseF
        SceneGroup:insert(soma_ossos)

        if (i < totalRespostas) then
            local textSoma = display.newText("+", iniFase + 51, yFaseF, native.systemFont, 40)
            textSoma:setFillColor(ragdogLib.convertHexToRGB("#001937"))
            SceneGroup:insert(textSoma)
        end

        posicaoResposta[i] = iniFase
        iniFase = iniFase + 100

    end
end

function geraButtons()

    btnNext = widget.newButton({
        left = 130,
        top = 310,   
        label = "Verificar",
        shape = "roundedRect",
        width = 90,
        height = 25,
        cornerRadius = 0,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={ragdogLib.convertHexToRGB("#2b5782")}, over={ragdogLib.convertHexToRGB("#022f69")} },
        strokeColor = { default={ragdogLib.convertHexToRGB("#2b5782")}, over={ragdogLib.convertHexToRGB("#022e66")} },
        strokeWidth = 5,
        id = 2,
        onEvent = telaFimJogo
        
    })
    btnNext.x = display.contentCenterX + 85
    btnNext.y = display.contentCenterY*2.05
    SceneGroup:insert(btnNext)        
end

function embaralha(event)
    if (event.phase == "ended") then
        if (numEmbar < 4) then
            groupOpRes:removeSelf()
            geraOpcRespostas()
            numEmbar = numEmbar + 1
        end
    end
end

function geraOpcRespostas()

    groupOpRes = display.newGroup()
    iniFase = display.contentCenterX - 100
    yFaseB = 70
    yFaseF = 290
    cont = 0
    total = 12

    for i = 1, total, 1 do
        if ( i == 5 or i == 9) then
            yFaseF = yFaseF + 67
            iniFase = display.contentCenterX - 100
        end

        osso = misturaAlternativas(osso)
        local soma_ossos = display.newImageRect( osso[i][1], 65, 65 )
        soma_ossos.x = iniFase
        soma_ossos.y = yFaseF
        soma_ossos.id = osso[i][2]
        soma_ossos:addEventListener("touch", selecionado)
        groupOpRes:insert(soma_ossos)
        iniFase = iniFase + 67

    end
end

function viewHelp( event )
    if (event.phase == "began") then
        textAjuda.isVisible = true
    elseif (event.phase == "ended") then
        textAjuda.isVisible = false
    end
end

function selecionado( event )
    if (event.phase == "ended") then
        if (iResposta <= totalRespostas) then

            groupSelecionado:insert(event.target)
            transition.to(event.target, {time=500, x = posicaoResposta[iResposta], y = 200})

            for i = 1, #respostaCorreta, 1 do
                if (respostaCorreta[i] == event.target.id) then
                    acertos = acertos + 1
                    respostaCorreta[i] = ""
                end
            end


            iResposta = iResposta + 1
            countBones = countBones + 1

            if (countBones == totalRespostas ) then
                geraButtons()
            end
        end
    end
end

local function changeTime()
    if (fimJogo == 0) then
        if (progress <= 0.05 and progress >= 0.0) then
            progress = 0.0
            if (goOut == 0) then
                gameOver()
            end
        else
            progress = progress - 0.06109
        end

        
        if (progress > 0) then

            timeProgress:setProgress(progress)

            timer.performWithDelay( 400, changeTime )
        end
    end
end

function telaFimJogo(event)
    if (event.phase == "ended") then
        changeFaseDes()

        fimJogo = 1

            SceneGroup:insert(groupOpRes)

            SceneGroup:insert(groupSelecionado)
        --end
        calculo = 0

            imgFundo = "img_jogos/fimJogo-3.png"
            img = "img_jogos/star-0.png"

        if (timeProgress:getProgress() >= 0.50 and acertos == totalRespostas ) then
            calculo = 85 + (100 / (130 * timeProgress:getProgress()))
            imgFundo = "img_jogos/fimJogo-1.png"
            img = "img_jogos/star-3.png"
        elseif  (timeProgress:getProgress() >= 0.25 and acertos ==  totalRespostas ) then
            calculo = 70 + (100 / (130.61 * timeProgress:getProgress()))
            imgFundo = "img_jogos/fimJogo-2.png"
            img = "img_jogos/star-2.png"
        elseif  (timeProgress:getProgress() > 0.00 and acertos ==  totalRespostas ) then
            calculo = 55 + (100 / (162.5 * timeProgress:getProgress()))
            imgFundo = "img_jogos/fimJogo-3.png"
            img = "img_jogos/star-1.png"
        end 
        
        acertos = tonumber(string.format("%." .. (1 or 0) .. "f", calculo))

        insertPointSO(acertos)

        vitoria = display.newImageRect( imgFundo, 250, 350)
        vitoria.x = display.contentCenterX
        vitoria.y = display.contentCenterY
        SceneGroup:insert(vitoria)

        star = display.newImageRect( img, 209.33, 83.66)
        star.x = display.contentCenterX
        star.y = display.contentCenterY * 0.7
        SceneGroup:insert(star)

        skull = display.newImageRect( "img_jogos/teste.png", 100, 81.5)
        skull.x = display.contentCenterX
        skull.y = display.contentCenterY * 1.08
        SceneGroup:insert(skull)


        if (acertos > 0) then

            local repetir = widget.newButton({
                left = 120,
                top = 310,   
                label = "Repetir",
                shape = "roundedRect",
                width = 80,
                height = 30,
                cornerRadius = 6,
                labelColor = { default={ragdogLib.convertHexToRGB("#2e435e")}, over={ ragdogLib.convertHexToRGB("#2e435e") } },
                fillColor = { default={ragdogLib.convertHexToRGB("#fbcc02")}, over={ragdogLib.convertHexToRGB("#f7d804")} },
                strokeColor = { default={1,0,0,1}, over={0.8,0.8,1,1} },
                strokeWidth = 0,
                onEvent = repetirJogo        
            })

            repetir.x = display.contentCenterX * 0.7
            repetir.y = display.contentCenterY*1.55
            SceneGroup:insert(repetir)

            local proximo = widget.newButton({
                left = 120,
                top = 310,   
                label = "Próximo",
                shape = "roundedRect",
                width = 80,
                height = 30,
                cornerRadius = 6,
                labelColor = { default={ragdogLib.convertHexToRGB("#2e435e")}, over={ ragdogLib.convertHexToRGB("#2e435e") } },
                fillColor = { default={ragdogLib.convertHexToRGB("#fbcc02")}, over={ragdogLib.convertHexToRGB("#f7d804")} },
                strokeColor = { default={1,0,0,1}, over={0.8,0.8,1,1} },
                strokeWidth = 0,
                onEvent = novoJogo        
            })


            proximo.x = display.contentCenterX * 1.3
            proximo.y = display.contentCenterY*1.55
            SceneGroup:insert(proximo)
        else        
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
                onEvent = repetirJogo        
            })

            jogarNovamente.x = display.contentCenterX
            jogarNovamente.y = display.contentCenterY*1.55
            SceneGroup:insert(jogarNovamente)
        end

        scoreFinal = display.newText(acertos, 300, 200, native.systemFont, 26)
        scoreFinal.x = display.contentCenterX *1.25
        scoreFinal.y = display.contentCenterY * 1.36
        SceneGroup:insert(scoreFinal)
    end
end

function gameOver()
        fimJogo = 1

        SceneGroup:insert(groupOpRes)

        SceneGroup:insert(groupSelecionado)
        
        calculo = 0

        imgFundo = "img_jogos/fimJogo-3.png"
        img = "img_jogos/star-0.png"
        
        acertos = tonumber(string.format("%." .. (1 or 0) .. "f", calculo))

        insertPointSO(acertos)

        vitoria = display.newImageRect( imgFundo, 250, 350)
        vitoria.x = display.contentCenterX
        vitoria.y = display.contentCenterY
        SceneGroup:insert(vitoria)

        star = display.newImageRect( img, 209.33, 83.66)
        star.x = display.contentCenterX
        star.y = display.contentCenterY * 0.7
        SceneGroup:insert(star)

        skull = display.newImageRect( "img_jogos/teste.png", 100, 81.5)
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
            onEvent = repetirJogo        
        })

        jogarNovamente.x = display.contentCenterX
        jogarNovamente.y = display.contentCenterY*1.55
        SceneGroup:insert(jogarNovamente)
        

        scoreFinal = display.newText(acertos, 300, 200, native.systemFont, 26)
        scoreFinal.x = display.contentCenterX *1.25
        scoreFinal.y = display.contentCenterY * 1.36
        SceneGroup:insert(scoreFinal)
end

function repetirJogo(event)
    if (event.phase == "ended") then
        local options =
            {
                effect = "slideLeft",
                time = 300,
                params = {
                    jogo = "somaOssos",
                    nivel = nivel,
                    qnt_fases_d = qnt_fases_d
                }
            }

            faseJogo = nomeJogo..".fase1"
            composer.gotoScene(faseJogo, options)
    end
end

function novoJogo(event)
    if (event.phase == "ended") then
        if (qnt_fases_d == nivel) then
            qnt_fases_d = qnt_fases_d + 1
        end
        local options =
            {
                effect = "slideLeft",
                time = 300,
                params = {
                    jogo = "somaOssos",
                    nivel = nivel + 1,
                    qnt_fases_d = qnt_fases_d
                }
            }

            faseJogo = nomeJogo..".fase1"
            composer.gotoScene(faseJogo, options)
    end
end

function faseUm:show(event)
    if (event.phase == "will") then
        SceneGroup = self.view

        print("tese")
        groupSelecionado = display.newGroup()


        nomeJogo = event.params.jogo
        nivel = event.params.nivel
        qnt_fases_d = event.params.qnt_fases_d
        acertos = 0

        respostaCorreta = {}

        for row in db:nrows("SELECT qnt_respostas, dica, resposta1, resposta2, resposta3, img_pergunta FROM fases_soma_ossos where num_fase = '"..nivel.."'") do
            totalRespostas = row.qnt_respostas
            dica = row.dica
            respostaCorreta[1] = row.resposta1
            respostaCorreta[2] = row.resposta2
            if (row.resposta3 ~= nil) then
                respostaCorreta[3] = row.resposta3
            end
            img_pergunta = row.img_pergunta
        end

        posicaoResposta = {}

        fimJogo = 0
        goOut = 0

        countBones = 0
        --minha resposta
        iResposta=1
        numEmbar = 1


        timeProgress = widget.newProgressView
        {
            left = -13,
            top = -8,
            width = display.contentCenterX * 2.083,
            isAnimated = true
        }

        progress = 1
        timeProgress:setProgress(progress)

        


        local background = display.newImageRect( "menu_principal/fundo_menu1.png", display.contentCenterX*2, display.contentCenterY*2.37 )
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        SceneGroup:insert(background)

        local barTop = display.newRect(0,-30,320,30)
        barTop:setFillColor(0.2,0.4,0.6)
        barTop.x = display.contentCenterX
        SceneGroup:insert(barTop)

        nameApp = display.newText("Meduca - Soma Ossos", 0, -30)
        nameApp:setFillColor(1,1,1)
        nameApp.x = display.contentCenterX
        SceneGroup:insert(nameApp)

        local menu_disabled = display.newImageRect( "menu_principal/menu_disabled.png", 25, 25 )
        menu_disabled.x =  display.contentCenterX * 0.1
        menu_disabled.y = -30
        SceneGroup:insert(menu_disabled)
        menu_disabled:addEventListener( "touch", onMenuTouch )

        back_menu = display.newImageRect( "menu_principal/arrows-left.png", 25, 25 )
        back_menu.x = display.contentCenterX * 1.9
        back_menu.y = -30
        SceneGroup:insert(back_menu)
        back_menu:addEventListener( "touch", backMenu )

        
        localResposta()

        geraOpcRespostas()

        refresh = display.newImageRect( "img_jogos/refresh.png", 35, 35 )
        refresh.x = display.contentCenterX
        refresh.y = display.contentCenterY * 2.05
        refresh:addEventListener("touch", embaralha)
        SceneGroup:insert(refresh)



        timer.performWithDelay( 1000, changeTime )
    end
end

function faseUm:hide( event )
    local phase = event.phase
 
    if ( phase == "will" ) then

        groupOpRes:removeSelf()
        groupSelecionado:removeSelf()
        refresh:removeSelf()
        progress = 0
        goOut = 1
        SceneGroup:insert(timeProgress)
    elseif ( phase == "did" ) then
        
    end
end

function faseUm:destroy( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

        timeProgress:removeSelf()
    end
end

faseUm:addEventListener("show", faseUm)
faseUm:addEventListener("hide", faseUm)
faseUm:addEventListener("destroy", faseUm)

return faseUm