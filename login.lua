native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer =  require("composer") 

local login = composer.newScene()

function gotoMenu(event)
    if ( "ended" == event.phase ) then
        composer.gotoScene( "menuPrincipal" )          
    end
end

local function moveScene()
    --Movimenta helicoptero
    transition.to(helicoptero, {time=5000, x = helicoptero.x - 280})
    transition.to(helicoptero, {time=800, y = helicoptero.y + 35, delay = 5000})
    transition.to(helicoptero, {time=1000, y = helicoptero.y, delay = 8000})
    transition.to(helicoptero, {time=2000, x = helicoptero.x -400, delay = 9000})

    --Movimenta ambulancia   
    transition.to(ambulancia, {time=4000, x = ambulancia.x + 210, delay = 4000})
    transition.to(ambulancia, {time=4000, x = ambulancia.x + 400, delay = 12000})

    timer.performWithDelay( 30000, moveScene )

end

function login:create(event)
    local SceneGroup = self.view

    local background = display.newImageRect( "tela_login/fundo.png", display.contentCenterX*2, display.contentCenterY*2.37 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    SceneGroup:insert(background)

    helicoptero = display.newImage( "tela_login/helicoptero.png", 350, 130 )
    SceneGroup:insert(helicoptero)

    ambulancia = display.newImage( "tela_login/ambulancia.png", -50, 255 )
    SceneGroup:insert(ambulancia)

    
    moveScene()
    local buttonData = { width=114, height=45, numFrames=4, sheetContentWidth=114, sheetContentHeight=180 }
    local button = graphics.newImageSheet( "tela_login/jogarSprite.png", buttonData )
    local sequenceData = {name="seq1", sheet=button, start=1, count=4, time=600, loopCount=100000 }


    buttonAnimation = display.newSprite( button, sequenceData )
    buttonAnimation.width = 100
    buttonAnimation.x = display.contentCenterX
    buttonAnimation.y = display.contentCenterY * 1.45
    buttonAnimation:addEventListener("touch", gotoMenu)
    SceneGroup:insert(buttonAnimation)
    buttonAnimation:play()


    local buttonDataFC = { width=108, height=35, numFrames=6, sheetContentWidth=108, sheetContentHeight=210 }
    local buttonFC = graphics.newImageSheet( "tela_login/fcSprite.png", buttonDataFC )
    local sequenceDataFC = {name="seq1", sheet=buttonFC, start=1, count=6, time=900, loopCount=100000 }


    buttonAnimationFC = display.newSprite( buttonFC, sequenceDataFC )
    buttonAnimationFC.width = 100
    buttonAnimationFC.x = display.contentCenterX
    buttonAnimationFC.y = display.contentCenterY * 1.65
    --buttonAnimationFC:addEventListener("touch", gotoMenu)
    SceneGroup:insert(buttonAnimationFC)
    buttonAnimationFC:play()
    


end

function login:show(event)
    if (event.phase == "did" ) then

    end
end 

function login:hide(event)
  if (event.phase == "did") then
  end  
end

function login:destroy(event)
    if (event.phase == "did" ) then
        --login:show()
    end
end



login:addEventListener("create", login)
login:addEventListener("show", login)
login:addEventListener("hide", login)
login:addEventListener( "destroy", login )

return login