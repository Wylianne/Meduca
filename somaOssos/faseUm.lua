local composer =  require("composer") 

local faseUm = composer.newScene()

local slide = require("slide_menu")

-- total de espaços para preencher
totalRespostas = 2
iResposta=1
posicaoResposta = {}

--Inicializa ossos
osso = {
    {"img_jogos/somaOssos/femur.png", 0},
    {"img_jogos/somaOssos/tibia.png", 0},
    {"img_jogos/somaOssos/fibula.png", 0},
    {"img_jogos/somaOssos/umero.png", 0},
    {"img_jogos/somaOssos/ulna.png", 0},
    {"img_jogos/somaOssos/coccix.png", 0},
    {"img_jogos/somaOssos/sacro.png", 0},


    {"img_jogos/somaOssos/tibia.png", 0},
    {"img_jogos/somaOssos/fibula.png", 0},
    {"img_jogos/somaOssos/femur.png", 0},
    {"img_jogos/somaOssos/tibia.png", 0},
    {"img_jogos/somaOssos/fibula.png", 0}
}

local function onMenuTouch(event)
    if ( event.phase == "ended" ) then
        slide:onMenuTouch()
    end
    return true
end

function backMenu(event)
    if (event.phase == "ended") then
        composer.gotoScene("soma_ossos")
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

    textAjuda = display.newText("Perna", display.contentCenterX, localReservado.y,  native.systemFont, 30)
    textAjuda.isVisible = false

    local imgAjuda = display.newImageRect( "img_jogos/info.png", 20, 20 )
    imgAjuda.x = display.contentCenterX * 1.72
    imgAjuda.y = localReservado.y * 1.72
    imgAjuda:addEventListener("touch", viewHelp)
    SceneGroup:insert(imgAjuda)

    local imgSoma = display.newImage("img_jogos/perna.png", display.contentCenterX, localReservado.y)
    SceneGroup:insert(imgSoma)

    for i = 1, totalRespostas, 1 do

        local soma_ossos = display.newImageRect( "img_jogos/somaOssosP.png", 65, 65 )
        soma_ossos.x = iniFase
        soma_ossos.y = yFaseF
        SceneGroup:insert(soma_ossos)

        if (i < totalRespostas) then
            local textSoma = display.newText("+", iniFase + 51, yFaseF, native.systemFont, 40)
            textSoma:setFillColor(0.2,0.4,0.6)
            SceneGroup:insert(textSoma)
        end

        posicaoResposta[i] = iniFase
        iniFase = iniFase + 100

    end
end

function selecionaOssoResposta ()
    id = math.random(1, 12)

    

    if (osso[id][2] == 1) then
        id = selecionaOssoResposta()
    end

    osso[id][2] = 1

    return id
end

function geraOpcRespostas()
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

        
        id = selecionaOssoResposta()

        local soma_ossos = display.newImageRect( osso[id][1], 65, 65 )
        soma_ossos.x = iniFase
        soma_ossos.y = yFaseF
        soma_ossos:addEventListener("touch", selecionado)
        SceneGroup:insert(soma_ossos)

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
            transition.to(event.target, {time=500, x = posicaoResposta[iResposta], y = 200})
            iResposta = iResposta + 1
        end
    end
end

function faseUm:create(event)
    SceneGroup = self.view
    
    local background = display.newImageRect( "menu_principal/fundo_menu1.png", 360, 570 )
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

    local back_menu = display.newImageRect( "menu_principal/arrows-left.png", 25, 25 )
    back_menu.x = display.contentCenterX * 1.9
    back_menu.y = -30
    SceneGroup:insert(back_menu)
    back_menu:addEventListener( "touch", backMenu )

    
    localResposta()

    geraOpcRespostas()

    local refresh = display.newImageRect( "img_jogos/refresh.png", 35, 35 )
    refresh.x = display.contentCenterX
    refresh.y = display.contentCenterY * 2.05
    SceneGroup:insert(refresh)
     
end



faseUm:addEventListener("create", faseUm)
return faseUm