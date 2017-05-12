local composer =  require("composer") 

local quiz = composer.newScene()

local widget = require("widget")

local slide = require("slide_menu")


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
pergunta = "Quantos ossos constituem o esqueleto humano da maioria dos adultos?"
alter = {"306 ossos","206 ossos","236 ossos","286 ossos","216 ossos"}
correcao = {0,1,0,0,0}



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
    local switch = event.target
    geraButtons()
    if (correcao[switch.id] == 1) then
        print("correto")
    end
end

function geraButtons()
    if (buttons) then
        local btnCorrigir = widget.newButton({
            left = 130,
            top = 310,   
            label = "Χ Finalizar",
            shape = "roundedRect",
            width = 90,
            height = 25,
            cornerRadius = 0,
            labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fillColor = { default={1,0,0,1}, over={1,0,0,0.8} },
            strokeColor = { default={1,0,0,0.9}, over={0.8,0.8,1,1} },
            strokeWidth = 5,
            onEvent = telaFim
            
        })
        btnCorrigir.x = display.contentCenterX - 92
        btnCorrigir.y = display.contentCenterY*2
        SceneGroup:insert(btnCorrigir)

        local btnNext = widget.newButton({
            left = 130,
            top = 310,   
            label = "Próxima »",
            shape = "roundedRect",
            width = 90,
            height = 25,
            cornerRadius = 0,
            labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fillColor = { default={0.1,0.5,0, 0.9}, over={0.2,0.4,0.7,0.5} },
            strokeColor = { default={0.1,0.5,0,0.9}, over={0.1,0.5,0,1} },
            strokeWidth = 5,
            onEvent = proximaPergunta
            
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
    for i=1, 5, 1 do
        -- Create two associated radio buttons (inserted into the same display group)
        local radioButton1 = widget.newSwitch(
            {
                left = 20,
                top = 140 + i*50,
                style = "radio",
                id = i,
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

        local alterViewOpc = display.newText(alterViewOpc[i], 45, 163+(i*50), native.systemFont, 22 )
        local alterView = display.newText(alter[i], 80, 153+(i*50), native.systemFont, 18 )
        alterView.anchorX, alterView.anchorY = 0, 0
        SceneGroup:insert(alterViewOpc)
        SceneGroup:insert(alterView)

    end
end

function telaFim( ... )
    -- body
end

function proximaPergunta( ... )
    quiz:destroy()
end


function quiz:create(event)

end

function quiz:show(event)
    SceneGroup = self.view
    
    buttons = true

    local background = display.newImageRect( "menu_principal/fundo_menu1.png", 360, 570 )
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

    radioButtons()


end


function quiz:destroy(event)
    quiz:show()
end

quiz:addEventListener( "create", quiz )
quiz:addEventListener( "show", quiz )
quiz:addEventListener( "hide", quiz )
quiz:addEventListener( "destroy", quiz )


return quiz