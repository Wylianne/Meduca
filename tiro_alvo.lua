local composer =  require("composer") 

local tiro_alvo = composer.newScene()


local slide = require("slide_menu")

local objetos= {
            {"img_jogos/hemacia.png", "hemacia"},
            {"img_jogos/leucocito.png", "leucocito"},
            {"img_jogos/plaqueta.png", "plaqueta"}
         }

local function onMenuTouch(event)
    if ( event.phase == "ended" ) then
        slide:onMenuTouch()
    end
    return true
end

function backMenu(event)
    if (event.phase == "ended") then
        composer.gotoScene("menuPrincipal")
        scorePoint.text = "0"
    end
end

function touchMe( event)
    if (event.phase == "began") then
        print(event.target.id)
        if (event.target.id == alvo) then
            scorePoint.text = tonumber(scorePoint.text) + 10
        elseif (event.target.id ~= alvo) then
            scorePoint.text = tonumber(scorePoint.text) - 5
           
        end
    end
end

local function moveScene()
    if (tonumber(scorePoint.text) > 0) then

        id = math.random(3)

        posicaoX = math.random(1,320)
        posicaoY = -10
        sizeObj = math.random(25,40)
        objeto = display.newImage( objetos[id][1], posicaoX, posicaoY, 20,20)
        objeto.width = sizeObj
        objeto.height = sizeObj
        objeto.id = objetos[id][2]
        objeto:addEventListener("touch", touchMe)
        SceneGroup:insert(objeto)
        velocidade = math.random(3,5)
        velocidade = velocidade*1000
        transition.to(objeto, {time=velocidade, y = objeto.y + 550})

        
        --teste(objeto)

        timer.performWithDelay( 800, moveScene )
        tm = timer.performWithDelay( velocidade, teste)
        tm.params = { param = objeto}
    end
end

function teste(event)
    local params = event.source.params
    if (params.param.id == alvo) then
        scorePoint.text = tonumber(scorePoint.text) - 10
    end
    params.param:removeSelf()
end

function tiro_alvo:create(event)

end

function tiro_alvo:show(event)
    SceneGroup = self.view
    alvo = "hemacia"

    local fundo = display.newImageRect( "img_jogos/fundo_sangue.png", 320, 570 )
    fundo.x =  display.contentCenterX 
    fundo.y = display.contentCenterY
    SceneGroup:insert(fundo)

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

    score = display.newText("Score:", display.contentCenterX * 1.6, 0)
    score:setFillColor(1,1,1)
    --score.x = display.contentCenterX
    SceneGroup:insert(score)

    scorePoint = display.newText("100", display.contentCenterX * 1.9, 0)
    scorePoint:setFillColor(1,1,1)
    --score.x = display.contentCenterX
    SceneGroup:insert(scorePoint)

    moveScene()


end


function tiro_alvo:destroy(event)
    tiro_alvo:show()
end

tiro_alvo:addEventListener("create", tiro_alvo)
tiro_alvo:addEventListener("show", tiro_alvo)
tiro_alvo:addEventListener( "destroy", tiro_alvo )

return tiro_alvo