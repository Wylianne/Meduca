local GRID_WIDTH = 8
local GRID_HEIGHT = 8
local CELL_WIDTH = 40
local CELL_HEIGHT = 40

local xCenter = display.contentCenterX
local yCenter = display.contentCenterY

local widthScreen = display.actualContentWidth
local heightScreen = display.actualContentHeight*2

  
local pieceSelected

local checkerBoard

local gbOffsetX
local gbOffsetY

local dica

local composer =  require("composer") 
 

local widget = require("widget")
local String = require("string")

local color = require("libs.convertcolor")

local mainLayout = require("mainLayout")

local cruzadas = {}

local jogo

local cruzadasGroup = display.newGroup()

local gridQuadros = {}

alfabeto = {"A", "B", "C", "D", "E", "F", "G", "H", "I", 
         "J", "K", "L", "M", "N", "O", "P", "Q",  
         "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
       
posicaoI = nil


function cruzadas:create(jogoP)
    
     if jogoP == nil then
       error("jogoP can't be nil.")
    --elseif #jogoP == 0 then   
      -- error("jogoP can't be  empty.")
    elseif #jogoP ~= 0 then
         if jogoP.grid == nil then
           error("grid jogo is nil")
         elseif  #jogoP.grid~=8  then
           error("grid jogo has a invalid size (must be 8x8)")
         else 
           for i=1, #itens, 1 do
             if #itens[i]~=8 then
               error("grid jogo has a invalid size (must be 8x8)")
             end  
           end
           
         end
        
    end
    
    jogo = jogoP
    
    cruzadasGroup:insert(mainLayout:create("Palavras Cruzadas"))
    
    local dicaQuadro = display.newRect(0,10,display.actualContentWidth*2, 50)
    dicaQuadro:setFillColor(1,1,1)
    
    cruzadasGroup:insert(dicaQuadro)
    
    for i = 1, GRID_HEIGHT do
      gridQuadros[i] = {}
    end
    
    
    
    local x = display.contentCenterX
    local y = display.contentCenterY

    checkerBoard = display.newRect(x,y-50, 320, 320)
    cruzadasGroup:insert(checkerBoard)
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
          gridQuadros[i][j] = spawnPiece(xPos*i, yPos*j,jogo.palavras[i][j]) 
          gridQuadros[i][j].i = i
          gridQuadros[i][j].j = j
          
          if (jogo.setas[i][j] ~= " ") then
                 if (jogo.setas[i][j] == "rightdown") then
                   size = 12
                   setaY = setaY + 2
                   setaX = setaX + 2
                 else
                   size = 8
                 end
 
                 direction = display.newImageRect( "img_jogos/"..jogo.setas[i][j]..".png", size, size )
                 direction.x = setaX
                 direction.y = setaY
                 cruzadasGroup:insert(direction)
 
                 if (jogo.setas[i][j] == "rightdown") then
                   setaY = setaY - 2
                   setaX = setaX - 2
                 end
             end          
            setaX = setaX + 40   
            
             if (j == 8) then
               setaY = setaY + 40
               setaX = 6
             end

      end
    
  end
  
  montaAlfabeto()
  
  local btVerifica = createVerificaButton()
  
  cruzadasGroup:insert(btVerifica)
  
  local refresh = display.newImageRect( "img_jogos/refresh.png", 35, 35 )
    refresh.x = display.contentCenterX
    refresh.y = display.contentCenterY * 2.07
    cruzadasGroup:insert(refresh)
  
  return cruzadasGroup
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
  
  local dicaQuadro = display.newRect(0,10,display.actualContentWidth*2, 35)
  cruzadasGroup:insert(dicaQuadro)
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
 cruzadasGroup:insert(dica)

return dica
end

function verificaJogo(event)
  local piece
  local pontuacao=0
if event.phase=="ended" then  
for i=1, 8, 1 do
      for j=1, 8, 1 do 
        piece = gridQuadros[i][j]
        if  jogo.palavras[i][j]~=" " then 
          piece:setEnabled(false)
          
          if piece:getLabel()==jogo.palavras[i][j] then 
               pontuacao = pontuacao+1
          else
            piece:setLabel(jogo.palavras[i][j])
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

 function spawnPiece(yPos, xPos,letra )
  
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
            fillColor = { default={ color.hex("336699") }, over={ color.hex("336699") } },
            strokeColor = { default={color.hex("2d435e")}, over={color.hex("2d435e")} },
            strokeWidth = 2,
        
      })
    
    cruzadasGroup:insert(piece)
  else
    piece = widget.newButton({
            x = Px,
            y = Py,
            shape="rect",
            id = letra,
            width = CELL_WIDTH,
            height = CELL_HEIGHT,
            labelColor = { default={ 0.2,0.4,0.6 }, over={ 0.2,0.4,0.6, 0.5 } },
            strokeColor = { default={color.hex("2d435e")}, over={color.hex("2d435e")} },
            strokeWidth = 2,
            onEvent = clickPiece
        
      })
    
    cruzadasGroup:insert(piece)
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
         
         pieceSelected = event.target
         pieceSelected:setStrokeColor(color.hex("FF4500"))
         pieceSelected.strokeWidth = 4
     end
 
     if (event.phase == "cancelled") then
         perX = beganX - event.x
         perY = beganY - event.y
 
         
         
         if (perX > perY) then
 
           dica = jogo.dicasDown[pieceSelected.i][pieceSelected.j]
         else
           dica = jogo.dicasRight[pieceSelected.i][pieceSelected.j]
         end
 
         createDica(dica)
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

        cruzadasGroup:insert(btnLetras)
    end
end





return cruzadas


