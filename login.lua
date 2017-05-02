local composer =  require("composer") 

local login = composer.newScene()

local function removeObjectsOfScena ()
    fieldPass:removeSelf()
    fieldLogin:removeSelf()
end

local function viewFieldsEvent(event)

    if ( "ended" == event.phase ) then
        if (fieldLogin.text=="admin" and fieldPass.text=="admin") then
            removeObjectsOfScena()
            composer.gotoScene( "menuPrincipal" )        
        end
        
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

    local background = display.newImageRect( "tela_login/fundo.png", 360, 570 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    SceneGroup:insert(background)

    helicoptero = display.newImage( "tela_login/helicoptero.png", 350, 130 )
    SceneGroup:insert(helicoptero)

    ambulancia = display.newImage( "tela_login/ambulancia.png", -50, 255 )
    SceneGroup:insert(ambulancia)

    
    moveScene()

    

    local widget = require( "widget" )

    local btnLogin = widget.newButton({
        left = 120,
        top = 310,   
        label = "Entrar",
        shape = "roundedRect",
        width = 90,
        height = 25,
        cornerRadius = 0,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={0,0.4,1,1}, over={0,0.2,0.9,1} },
        strokeColor = { default={1,0,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 0,
            onEvent = viewFieldsEvent
        
    })
    btnLogin.x = display.contentCenterX
    btnLogin.y = display.contentCenterY*1.6
    SceneGroup:insert(btnLogin)
    

    fieldLogin = native.newTextField( display.actualContentWidth/2, 
                                300 , 
                                180,
                                20 )

    SceneGroup:insert(fieldLogin)


    fieldPass =  native.newTextField( display.actualContentWidth/2, 
                                    330, 
                                    180, 
                                    20 )

    fieldPass.isSecure = true
    SceneGroup:insert(fieldPass)

    textLoginWith = display.newText("Entrar com", display.contentCenterX, display.contentCenterY * 1.8 )
    textLoginWith:setFillColor(0,0,0)
    SceneGroup:insert(textLoginWith)

    loginFacebook = display.newImageRect("tela_login/facebook.png", 40, 40)
    loginFacebook.x = display.contentCenterX - display.contentCenterX / 2 
    loginFacebook.y = display.contentCenterY * 2
    SceneGroup:insert(loginFacebook)


    loginGoogle = display.newImageRect("tela_login/google.png", 40, 40)
    loginGoogle.x = display.contentCenterX
    loginGoogle.y = display.contentCenterY * 2
    SceneGroup:insert(loginGoogle)

    loginTwitter = display.newImageRect("tela_login/twitter.png", 45, 40)
    loginTwitter.x = display.contentCenterX + display.contentCenterX / 2 
    loginTwitter.y = display.contentCenterY * 2
    SceneGroup:insert(loginTwitter)


end

login:addEventListener("create", login)
return login