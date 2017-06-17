native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer =  require("composer") 

local somaOssos = composer.newScene()

local slide = require("slide_menu")



local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "meduca.db", system.DocumentsDirectory )
local db = sqlite3.open( path ) 


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
                time = 300
            }
        composer.gotoScene("menuPrincipal", options)
    end
end

function goToFase(event)
    if (event.phase == "ended") then

        local options =
        {
            effect = "slideLeft",
            time = 300,
            params = {
                jogo = "somaOssos"
            }
        }

        faseJogo = nomeJogo..".fase"..event.target.id
        composer.gotoScene(faseJogo, options)
    end
end

function geraFases(qnt_fases, qnt_fases_d)
    iniFase = display.contentCenterX - 100
    yFaseB = 70
    yFaseF = 60
    cont = 0

    for i=1, qnt_fases, 1 do
        --+110
        if (i == 4) then
            yFaseB = 180
            yFaseF = 170
            iniFase = display.contentCenterX - 100
            cont = 0
        elseif (i == 7) then
            yFaseB = 290
            yFaseF = 280
            iniFase = display.contentCenterX - 100
            cont = 0
        elseif (i == 10) then
            yFaseB = 400
            yFaseF = 390
            iniFase = display.contentCenterX - 100
            cont = 0
        end

        if (i <= qnt_fases_d) then 
            local faseBack = display.newRoundedRect(display.contentCenterX * 1.05, 30, 70,90,12)
            faseBack:setFillColor(0.5,0.6,1, 0.5)
            faseBack.y = yFaseB
            faseBack.x = iniFase
            SceneGroup:insert(faseBack)

            local faseFront = display.newRoundedRect(display.contentCenterX * 1.05, 30, 70,70,12)
            faseFront:setFillColor(0.5,0.6,1, 0.5)
            faseFront.y = yFaseF
            faseFront.x = iniFase
            faseFront.strokeWidth = 3
            faseFront.id = i
            faseFront:setStrokeColor( 1, 1, 0 )
            faseFront:addEventListener("touch", goToFase)
            SceneGroup:insert(faseFront)


            local numFase = display.newText(i, 150, yFaseF, native.systemFont, 40 )
            numFase.x = display.contentCenterX

            if cont == 0 then
                numFase.x = display.contentCenterX -100
            elseif cont == 1 then
                numFase.x = display.contentCenterX
            elseif cont == 2 then
                numFase.x = display.contentCenterX + 100
            end
            SceneGroup:insert(numFase)
        elseif (i > 1) then

            local faseFront = display.newRoundedRect(display.contentCenterX * 1.05, 30, 70,70,12)
            faseFront:setFillColor(0.66,0.66,0.66)
            faseFront.y = yFaseF
            faseFront.x = iniFase
            faseFront.strokeWidth = 3
            faseFront:setStrokeColor(0.66,0.66,0.66)
            SceneGroup:insert(faseFront)


            local cadeado = display.newImageRect("img_jogos/cadeado.png", 40, 40)
            cadeado.x = display.contentCenterX


            if cont == 0 then
                cadeado.x = display.contentCenterX -100
                cadeado.y = yFaseF
            elseif cont == 1 then
                cadeado.x = display.contentCenterX
                cadeado.y = yFaseF
            elseif cont == 2 then
                cadeado.x = display.contentCenterX + 100
                cadeado.y = yFaseF
            end
            SceneGroup:insert(cadeado)
        end



        iniFase = iniFase + 100
        cont = cont + 1
    end
end


function somaOssos:create(event)
    SceneGroup = self.view

    nomeJogo = event.params.jogo

    for row in db:nrows("SELECT qnt_fases, qnt_fases_d FROM fases where nome_jogo = '"..nomeJogo.."'") do
       qnt_fases = row.qnt_fases
       qnt_fases_d = row.qnt_fases_d
    end
    
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

    local back_menu = display.newImageRect( "menu_principal/arrows-left.png", 25, 25 )
    back_menu.x = display.contentCenterX * 1.9
    back_menu.y = -30
    SceneGroup:insert(back_menu)
    back_menu:addEventListener( "touch", backMenu )

    geraFases(qnt_fases, qnt_fases_d)
    

end



somaOssos:addEventListener("create", somaOssos)
return somaOssos