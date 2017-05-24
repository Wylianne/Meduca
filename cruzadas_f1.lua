local composer =  require("composer") 

local cruzadas = require( "cruzadas" )


local cruzadasF1 = composer.newScene()


   
function cruzadasF1:create(event)
    SceneGroup = self.view
    
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

      dicasDownP[1][1] = "Menor osso do corpo humano"
      dicasRightP[1][3] = "Mais que colega"
      dicasDownP[5][3] = "Ver(substantivo)"
      dicasRightP[5][5] = "O dia atual"

      -- aceita down; right; righdown
      setasP[1][1] = "down"
      setasP[1][3] = "right"
      setasP[5][3] = "down"
      setasP[5][5] = "right"
     
      
      
      local jogo = {palavras = grid, setas = setasP, dicasDown = dicasDownP ,dicasRight = dicasRightP}
      
      SceneGroup:insert(cruzadas:create(jogo))
    
    
end

cruzadasF1:addEventListener("create", cruzadasF1)

return cruzadasF1