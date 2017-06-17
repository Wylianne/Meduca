native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer =  require("composer") 

local widget = require( "widget" )

local tiro_alvo = composer.newScene()


local slide = require("slide_menu")

local objetos= {
            {"img_jogos/hemacia.png", "hemacia", ""},
            {"img_jogos/leucocito.png", "leucocito", ""},
            {"img_jogos/plaqueta.png", "plaqueta", ""}
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
        if (event.target.id == alvo) then
            scorePoint.text = tonumber(scorePoint.text) + 10
            if (tonumber(scorePoint.text) > tonumber(bsPoint.text)) then
                bsPoint.text = tonumber(scorePoint.text)
            end
        elseif (event.target.id ~= alvo) then
            scorePoint.text = tonumber(scorePoint.text) - 5
        end

        event.target.isVisible = false
        
    end
end

local function moveScene()
    if (tonumber(scorePoint.text) > 0) then
        score.isVisible = true
        rectPoint.isVisible = true
        scorePoint.isVisible = true
        bs.isVisible = true
        rectBS.isVisible = true
        bsPoint.isVisible = true


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
        tm = timer.performWithDelay( velocidade, endScene)
        tm.params = { param = objeto}
    else
        timer.performWithDelay( 4000, createButons)
    end
end

function endScene(event)
    local params = event.source.params
    if ((tonumber(scorePoint.text) > 0) and (params.param.isVisible == true)) then
        if ((params.param.id == alvo)) then
            scorePoint.text = tonumber(scorePoint.text) - 5
        end
    end
    params.param:removeSelf()
end

function start( event )
    if (event.phase == "began") then
        btnPlay:removeSelf()
        btnBS:removeSelf()

        moveScene()
    end
end

function createButons()   

    score.isVisible = false
    rectPoint.isVisible = false
    scorePoint.isVisible = false
    bs.isVisible = false
    rectBS.isVisible = false
    bsPoint.isVisible = false

    scorePoint.text = "15"
    bsPoint.text = "15"

    btnPlay = widget.newButton({
        left = 120,
        top = 100,   
        label = "Play",
        shape = "roundedRect",
        width = 120,
        height = 25,
        cornerRadius = 6,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={0,0.4,1,0}, over={0,0.2,0.9,0} },
        strokeColor = { default={1,1,1}, over={1,1,1} },
        strokeWidth = 1.5,
        onEvent = start
        
    })
    btnPlay.x = display.contentCenterX
    btnPlay.y = display.contentCenterY*0.9
    SceneGroup:insert(btnPlay)

    btnBS = widget.newButton({
        left = 120,
        top = 100,   
        label = "Best Score",
        shape = "roundedRect",
        width = 120,
        height = 25,
        cornerRadius = 6,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={0,0.4,1,0}, over={0,0.2,0.9,0} },
        strokeColor = { default={1,1,1}, over={1,1,1} },
        strokeWidth = 1.5
        
    })
    btnBS.x = display.contentCenterX
    btnBS.y = display.contentCenterY * 1.1
    SceneGroup:insert(btnBS)
end

function tiro_alvo:create(event)

end

function tiro_alvo:show(event)
    SceneGroup = self.view
    alvo = "hemacia"

    local fundo = display.newImageRect( "img_jogos/fundo_sangue.png", display.contentCenterX*2, display.contentCenterY*2.37 )
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

    score = display.newText("Score:", display.contentCenterX * 1.25, display.contentCenterY * 0.035)
    score:setFillColor(1,1,1)
    --score.x = display.contentCenterX
    SceneGroup:insert(score)

    rectPoint = display.newRoundedRect( display.contentCenterX * 1.5, display.contentCenterY * 0.03, display.contentCenterX * 0.9, 30, 8 )
    rectPoint.strokeWidth = 2
    rectPoint:setFillColor( 1, 0, 0, 0 )
    rectPoint:setStrokeColor( 1, 1, 1 )
    SceneGroup:insert(rectPoint)

    scorePoint = display.newText("15", display.contentCenterX * 1.46, display.contentCenterY * 0.035)
    scorePoint:setFillColor(1,1,1)
    --score.x = display.contentCenterX
    SceneGroup:insert(scorePoint)


    bs = display.newText("BS:", display.contentCenterX * 0.2, display.contentCenterY * 0.035)
    bs:setFillColor(1,1,1)
    --score.x = display.contentCenterX
    SceneGroup:insert(bs)

    rectBS = display.newRoundedRect( display.contentCenterX * 0.5, display.contentCenterY * 0.03, display.contentCenterX * 0.9, 30, 8 )
    rectBS.strokeWidth = 2
    rectBS:setFillColor( 1, 0, 0, 0 )
    rectBS:setStrokeColor( 1, 1, 1 )
    SceneGroup:insert(rectBS)

    bsPoint = display.newText("15", display.contentCenterX * 0.35, display.contentCenterY * 0.035)
    bsPoint:setFillColor(1,1,1)
    --score.x = display.contentCenterX
    SceneGroup:insert(bsPoint)

    score.isVisible = false
    rectPoint.isVisible = false
    scorePoint.isVisible = false
    bs.isVisible = false
    rectBS.isVisible = false
    bsPoint.isVisible = false



    createButons()

end


function tiro_alvo:destroy(event)
    tiro_alvo:show()
end

tiro_alvo:addEventListener("create", tiro_alvo)
tiro_alvo:addEventListener("show", tiro_alvo)
tiro_alvo:addEventListener( "destroy", tiro_alvo )

return tiro_alvo