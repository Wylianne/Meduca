native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer =  require("composer") 

local cruzadas = require( "cruzadas" )


local cruzadasF3 = composer.newScene()


   
function cruzadasF3:create(event)
    SceneGroup = self.view
    
    local grid = {
              {"R","A","D","I","O"," "," "," "},
              {" "," "," "," ","M"," "," "," "},
              {"U","M","E","R","O"," "," "," "},
              {" "," "," "," ","P"," "," "," "},
              {" "," "," "," ","L"," "," "," "},
              {" "," "," "," ","A"," "," "," "},
              {" "," "," "," ","T"," "," "," "},
              {" "," "," "," ","A"," "," "," "},
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

      dicasRightP[1][1] = "Osso do braço (música)"
      dicasRightP[3][1] = "Mais longo osso do membro superior"
      dicasDownP[1][5] = "Semelhante a uma pá"

      -- aceita down; right; righdown
      setasP[1][1] = "right"
      setasP[3][1] = "right"
      setasP[1][5] = "down"
     
      
      
      local jogo = {palavras = grid, setas = setasP, dicasDown = dicasDownP ,dicasRight = dicasRightP,proximaFase= nil}
      
      SceneGroup:insert(cruzadas:create(jogo))
    
    
end


function cruzadasF3:hide(event)
   if event.phase == "did" then
      self.view = nil
   end

end


cruzadasF3:addEventListener("hide", cruzadasF3)

cruzadasF3:addEventListener("create", cruzadasF3)

return cruzadasF3