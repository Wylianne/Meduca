local composer =  require("composer") 

local tiroAlvo = composer.newScene()

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


function tiroAlvo:create(event)
    SceneGroup = self.view
    
    local background = display.newImageRect( "img_jogos/fundo_tiro.png", 360, 570 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    SceneGroup:insert(background)

    local barTop = display.newRect(0, 0,30,570)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = 305
    barTop.y = display.contentCenterY
    SceneGroup:insert(barTop)

    nameApp = display.newText("Meduca - Tiro Alvo", 0, -30)
    nameApp:setFillColor(1,1,1)
    nameApp.y = display.contentCenterY
    nameApp.x = 305
    nameApp:rotate(90)
    SceneGroup:insert(nameApp)

    local menu_disabled = display.newImageRect( "menu_principal/menu_disabled.png", 25, 25 )
    menu_disabled.x =  display.contentCenterX * 1.9--display.contentCenterX * 0.1
    menu_disabled.y = -30
    menu_disabled:rotate(90)
    SceneGroup:insert(menu_disabled)
    menu_disabled:addEventListener( "touch", onMenuTouch )

    local back_menu = display.newImageRect( "menu_principal/arrows-left.png", 25, 25 )
    back_menu.x = display.contentCenterX * 1.9
    back_menu.y = display.contentCenterY * 2.12
    back_menu:rotate(90)
    SceneGroup:insert(back_menu)
    back_menu:addEventListener( "touch", backMenu )



end

tiroAlvo:addEventListener("create", tiroAlvo)
return tiroAlvo