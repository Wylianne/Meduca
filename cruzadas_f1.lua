native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer =  require("composer") 

local cruzadas = require( "cruzadas" )


local cruzadasF1 = composer.newScene()


   
function cruzadasF1:create(event)
    SceneGroup = self.view
    
  local grid = {
              {" "," ","M"," "," "," ","B"," "},
              {" "," ","A"," "," "," ","I"," "},
              {" "," ","R"," "," "," ","G"," "},
              {"E","S","T","R","I","B","O"," "},
              {" "," ","E"," "," "," ","R"," "},
              {" "," ","L"," "," "," ","N"," "},
              {" "," ","O"," "," "," ","A"," "},
              {" "," "," "," "," "," "," "," "},
  }
  
local dicasDownP = {
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
  }

local dicasRightP = {
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
  }

local setasP = {
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
  }

      dicasRightP[4][1] = "Menor osso do corpo humano"
      dicasDownP[1][3] = "Ouvido (analogia: ferramenta)"
      dicasDownP[1][7] = "Ouvido (existe somente nos mamíferos)"

      -- aceita down; right; righdown
      setasP[4][1] = "right"
      setasP[1][3] = "down"
      setasP[1][7] = "down"
     
      
      
      local jogo = {palavras = grid, setas = setasP, dicasDown = dicasDownP ,dicasRight = dicasRightP}
      
      SceneGroup:insert(cruzadas:create(jogo))
    
    
end

function cruzadasF1:hide(event)
   if event.phase == "did" then
      self.view = nil
   end

end
cruzadasF1:addEventListener("create", cruzadasF1)
cruzadasF1:addEventListener("hide", cruzadasF1)

return cruzadasF1