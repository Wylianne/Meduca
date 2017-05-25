local composer =  require("composer") 

local widget = require("widget")
local String = require("string")


local ragdogLib = require "ragdogLib";

local color = require("libs.convertcolor")

local cruzadas = composer.newScene()

local slide = require("slide_menu")


local GRID_WIDTH = 8
local GRID_HEIGHT = 8
local CELL_WIDTH = 40
local CELL_HEIGHT = 40

local xCenter = display.contentCenterX
local yCenter = display.contentCenterY

local widthScreen = display.actualContentWidth
local heightScreen = display.actualContentHeight*2
--
-- Create a 2D array to hold our objects.
local grid = {
              {"E","S","T","R","I","B","O"," "},
              {" "," ","M"," "," "," "," "," "},
              {" "," ","I"," "," "," "," "," "},
              {" "," ","G"," "," "," "," "," "},
              {" "," ","O","L","H","O"," "," "},
              {" "," "," "," ","O"," "," "," "},
              {" "," "," "," ","J"," "," "," "},
              {" "," "," "," ","E"," "," "," "},
  }
  
local dicasDown = {
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
  }

local dicasRight = {
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
  }

local setas = {
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
  }

dicasDown[1][1] = "Menor osso do corpo humano"
dicasRight[1][3] = "Mais que colega"
dicasDown[5][3] = "Ver(substantivo)"
dicasRight[5][5] = "O dia atual"

-- aceita down; right; righdown
setas[1][1] = "down"
setas[1][3] = "right"
setas[5][3] = "down"
setas[5][5] = "right"
  
local pieceSelected, checkerBoard, gbOffsetX, gbOffsetY, dica


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

local gridQuadros = {}

alfabeto = {"A", "B", "C", "D", "E", "F", "G", "H", "I", 
         "J", "K", "L", "M", "N", "O", "P", "Q",  
         "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
       
posicaoI = nil


function cruzadas:create(event)
    SceneGroup = self.view

    local background = display.newImageRect( "menu_principal/fundo_menu1.png", display.contentCenterX*2, display.contentCenterY*2.37 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    SceneGroup:insert(background)

    local barTop = display.newRect(0,-30,320,30)
    barTop:setFillColor(0.2,0.4,0.6)
    barTop.x = display.contentCenterX
    SceneGroup:insert(barTop)

    nameApp = display.newText("Meduca - Palavras Cruzadas", 0, -30)
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
  
    
    local dicaQuadro = display.newRect(0,10,display.actualContentWidth*2, 40)
    dicaQuadro:setFillColor(1,1,1)
    
    SceneGroup:insert(dicaQuadro)
    
    for i = 1, GRID_HEIGHT do
      gridQuadros[i] = {}
    end
    
    
    
    local x = display.contentCenterX
    local y = display.contentCenterY

    checkerBoard = display.newRect(x,y-50, 320, 320)
    SceneGroup:insert(checkerBoard)
    --
    -- Calculate some values

    gbOffsetX = checkerBoard.x - ( checkerBoard.width * checkerBoard.anchorX ) 
    gbOffsetY = checkerBoard.y - ( checkerBoard.height * checkerBoard.anchorY )
    
    
    
    local xPos = 1
    local yPos = 1
    local setaY  = 47
    local setaX  = 6
    for i=1, 8, 1 do
        for j=1, 8, 1 do
            gridQuadros[i][j] = spawnPiece(xPos*i, yPos*j,grid[i][j]) 
            gridQuadros[i][j].i = i
            gridQuadros[i][j].j = j

            if (setas[i][j] ~= " ") then
                if (setas[i][j] == "rightdown") then
                  size = 12
                  setaY = setaY + 2
                  setaX = setaX + 2
                else
                  size = 8
                end

                direction = display.newImageRect( "img_jogos/"..setas[i][j]..".png", size, size )
                direction.x = setaX
                direction.y = setaY
                SceneGroup:insert(direction)

                if (setas[i][j] == "rightdown") then
                  setaY = setaY - 2
                  setaX = setaX - 2
                end
            end          
            setaY = setaY + 40   

            if (j == 8) then
              setaX = setaX + 40
              setaY = 47
            end
        end
    end
  
    montaAlfabeto()
    
    local btVerifica = createVerificaButton()
    
    SceneGroup:insert(btVerifica)


    local refresh = display.newImageRect( "img_jogos/refresh.png", 35, 35 )
    refresh.x = display.contentCenterX
    refresh.y = display.contentCenterY * 2.07
    SceneGroup:insert(refresh)
end
 
function createVerificaButton()
    return widget.newButton({
          left = display.contentCenterX * 1.3,
          top = display.contentCenterY*2, 
          label = "Validar",
          shape = "roundedRect",
          width = 90,
          height = 25,
          cornerRadius = 0,
          labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
          fillColor = { default={1,0,0,1}, over={1,0,0,0.8} },
          strokeColor = { default={1,0,0,1}, over={1,0,0,0.8} },
          strokeWidth = 5,
          onEvent=verificaJogo
    })
end 

function createDica(texto)
  
  local dicaQuadro = display.newRect(0,15,display.actualContentWidth*2, 50)
  dicaQuadro:setFillColor(1,1,1)
  SceneGroup:insert(dicaQuadro)
  
  
  local options = {
      text = texto,     
      x = xCenter,
      y = dicaQuadro.y,
      width = 300,
      font = native.systemFont,   
      fontSize = 16,
      --align = "center"  -- Alignment parameter
  }

   dica = display.newText( options )
   dica:setFillColor(color.hex("555555"))
   SceneGroup:insert(dica)


  return dica
end

function verificaJogo(event)
    local piece
    local pontuacao=0
    if event.phase=="ended" then  
      for i=1, 8, 1 do
          for j=1, 8, 1 do 
              piece = gridQuadros[i][j]

              if  grid[i][j]~=" " then                 
                if piece:getLabel()==grid[i][j] then 
                     pontuacao = pontuacao+1
                elseif piece:getLabel()~=grid[i][j] and piece:getLabel() ~= "" then
                  piece:setLabel(grid[i][j])
                  piece:setFillColor(1,0,0,0.2)
                end
                
              end  
          end
        end
        event.target:setEnabled(false)
    end   
end

--
-- Using positions 1, 8 for X and Y, draw the object at the right place in the grid
--

function spawnPiece( xPos, yPos,letra )
  
	if xPos < 1 or xPos > GRID_WIDTH or yPos < 1 or yPos > GRID_HEIGHT then
		print( "Position out of range:", xPos, yPos )
		return nil
	end
	--
	-- Position the piece
	--
	local Px = (xPos - 1) * CELL_WIDTH + (CELL_WIDTH * 0.5) + gbOffsetX
	local Py = (yPos - 1) * CELL_HEIGHT + (CELL_HEIGHT * 0.8) + gbOffsetY
  
  local piece

  
  if(letra ==" ")then  
      piece = widget.newButton({
              x = Px,
              y = Py,
              shape="rect",
              --label = letra,  
              id = letra,
              width = CELL_WIDTH,
              height = CELL_HEIGHT,
              labelColor = { default={ 0.2,0.4,0.6 }, over={ 0.2,0.4,0.6, 0.5 } },
              fillColor = { default={ ragdogLib.convertHexToRGB("#336699") }, over={ ragdogLib.convertHexToRGB("#336699") } },
              strokeColor = { default={ragdogLib.convertHexToRGB("#2d435e")}, over={ragdogLib.convertHexToRGB("#2d435e")} },
              strokeWidth = 2

          
        })
      
      SceneGroup:insert(piece)
  else
      piece = widget.newButton({
              x = Px,
              y = Py,
              shape="rect",
              id = letra,
              width = CELL_WIDTH,
              height = CELL_HEIGHT,
              labelColor = { default={ 0.2,0.4,0.6 }, over={ 0.2,0.4,0.6, 0.5 } },
              strokeColor = { default={ragdogLib.convertHexToRGB("#2d435e")}, over={ragdogLib.convertHexToRGB("#2d435e")} },
              strokeWidth = 2,
              onEvent = clickPiece
          
        })
      SceneGroup:insert(piece)

  end
	return piece
end

function viewLabelEvent (event)
    if (event.phase == "ended") then
      local letra = event.target:getLabel()
      if pieceSelected ~=nil then
        pieceSelected:setLabel(letra)
      end
      
    end
end

function clickPiece (event)
    local dica
    if (event.phase == "began") then
        beganX = event.x
        beganY = event.y
        if pieceSelected ~=nil then
          pieceSelected:setStrokeColor(color.hex("222222"),1)
          pieceSelected.strokeWidth = 2
        end  
    end

    if (event.phase == "cancelled") then
        perX = beganX - event.x
        perY = beganY - event.y

        pieceSelected = event.target
        pieceSelected:setStrokeColor(color.hex("FF4500"))
        pieceSelected.strokeWidth = 4
        
        if (perX > perY) then

          dica = dicasDown[pieceSelected.i][pieceSelected.j]
        else
          dica = dicasRight[pieceSelected.i][pieceSelected.j]
        end

        createDica(dica)
    end
end



function  montaAlfabeto()
    for i=1, 26, 1 do
        if i==1 then
            posicaoI = display.contentCenterX - (30 * 4.3)
            topButton = 380
        elseif i==10 then
            posicaoI = display.contentCenterX - (30 * 3.8)
            topButton = topButton + 30
        elseif i==18 then
            posicaoI = display.contentCenterX - (30 * 4.3)
            topButton = topButton + 30
        elseif i~=1 then
            posicaoI = posicaoI + 30
        end
        

        local btnLetras = widget.newButton({
            left = posicaoI,
            top = topButton,   
            label = alfabeto[i],  
            id = alfabeto[i],
            shape = "roundedRect",
            width = 20,
            height = 25,
            cornerRadius = 10,
            labelColor = { default={ 0.2,0.4,0.6 }, over={ 0.2,0.4,0.6, 0.5 } },
            fillColor = { default={1,1,1,1}, over={1,1,1,1} },
            strokeColor = { default={1,0,0,1}, over={0.8,0.8,1,1} },
            strokeWidth = 0,
            onEvent = viewLabelEvent
        
        })

        SceneGroup:insert(btnLetras)
    end
end
        





cruzadas:addEventListener("create", cruzadas)
return cruzadas


