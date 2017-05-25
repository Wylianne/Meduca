local composer =  require("composer") 

local cruzadas = require( "cruzadas" )


local cruzadasF2 = composer.newScene()


   
function cruzadasF2:create(event)
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


function cruzadasF2:hide(event)
   if event.phase == "did" then
      self.view = nil
   end

end


cruzadasF2:addEventListener("hide", cruzadasF2)

cruzadasF2:addEventListener("create", cruzadasF2)

return cruzadasF2