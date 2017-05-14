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
              {"C","H","A","V","E"," "," "," "},
              {" "," ","M"," "," "," "," "," "},
              {" "," ","I"," "," "," "," "," "},
              {" "," ","G"," "," "," "," "," "},
              {" "," ","O","L","H","O"," "," "},
              {" "," "," "," ","O"," "," "," "},
              {" "," "," "," ","J"," "," "," "},
              {" "," "," "," ","E"," "," "," "},
  }
  
local dicas = {
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
  }

      dicas[1][1] = "Serve para abrir"
      dicas[2][3] = "Mais que colega"
      dicas[5][3] = "Ver(substantivo)"
      dicas[6][5] = "O dia atual"
  
local pieceSelected

local checkerBoard

local gbOffsetX
local gbOffsetY

local dica

local composer =  require("composer") 

local widget = require("widget")
local String = require("string")

local color = require("libs.convertcolor")

local cruzadas = composer.newScene()

local gridQuadros = {}

alfabeto = {"A", "B", "C", "D", "E", "F", "G", "H", "I", 
         "J", "K", "L", "M", "N", "O", "P", "Q",  
         "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
       
posicaoI = nil


function cruzadas:create(event)
    SceneGroup = self.view
    
    
    local background = display.newImageRect( "menu_principal/fundo_menu1.png", 360, 570 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    
    SceneGroup:insert(background)
    
    local dicaQuadro = display.newRect(0,0,display.actualContentWidth*2, 50)
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
    for i=1, 8, 1 do
      for j=1, 8, 1 do
          gridQuadros[i][j] = spawnPiece(xPos*i, yPos*j,grid[i][j]) 
          gridQuadros[i][j].i = i
          gridQuadros[i][j].j = j
      end
    
  end
  
  montaAlfabeto()
  
  local btVerifica = createVerificaButton()
  
  SceneGroup:insert(btVerifica)
end
 
function createVerificaButton()

return widget.newButton(
   {
       left = 190,
       top = 465,
       label = "Solucionar",
       shape = "roundedRect",
       width = 120,
       height = 40,
       cornerRadius = 2,
       labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
       fillColor = { default={1,0,0,}, over={1,0.1,0.7,0.4} },
       strokeWidth = 4,
       onEvent=verificaJogo
    })
end 

function createDica(texto)
  
  local dicaQuadro = display.newRect(0,0,display.actualContentWidth*2, 50)
  dicaQuadro:setFillColor(1,1,1)
  
  
  local options = 
{
    text = texto,     
    x = xCenter,
    y = 1,
    width = 300,
    font = native.systemFont,   
    fontSize = 16,
    --align = "center"  -- Alignment parameter
}

 dica = display.newText( options )
 dica:setFillColor(color.hex("555555"))

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
          piece:setEnabled(false)
          
          if piece:getLabel()==grid[i][j] then 
               pontuacao = pontuacao+1
          else
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
	local Py = (yPos - 1) * CELL_HEIGHT + (CELL_HEIGHT * 0.5) + gbOffsetY
  
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
            fillColor = { default={ 0,0,0 }, over={ 0,0,0, } },
            strokeColor = { default={0.2,0.2,0.2,1}, over={0.2,0.2,0.2,1} },
            strokeWidth = 2,
        
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
            strokeColor = { default={0.2,0.2,0.2,1}, over={0.2,0.2,0.2,1} },
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
    if (event.phase == "ended") then
      
        if pieceSelected ~=nil then
          pieceSelected:setStrokeColor(color.hex("222222"),1)
          pieceSelected.strokeWidth = 2
        end  
        
        pieceSelected = event.target
        pieceSelected:setStrokeColor(color.hex("FF4500"))
        pieceSelected.strokeWidth = 4
        local dica = dicas[pieceSelected.i][pieceSelected.j]
        if dica ~= " "then
          createDica(dica)
        end
    end
end



function  montaAlfabeto()
    for i=1, 26, 1 do
        if i==1 then
            posicaoI = display.contentCenterX - (30 * 4.3)
            topButton = 360
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


