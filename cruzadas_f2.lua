native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer =  require("composer") 

local cruzadas = require( "cruzadas" )


local cruzadasF2 = composer.newScene()


   
function cruzadasF2:create(event)
    SceneGroup = self.view
    
    local grid = {
              {" "," "," ","C"," "," "," "," "},
              {"F","E","M","U","R"," "," "," "},
              {" "," "," ","B"," "," "," "," "},
              {" "," "," ","O"," "," "," "," "},
              {"T","I","B","I","A"," "," "," "},
              {" "," "," ","D"," "," "," "," "},
              {" "," "," ","E"," "," "," "," "},
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

      dicasRightP[2][1] = "Maior osso do corpo humano"
      dicasDownP[1][4] = "Osso do pé (figura geométrica)"
      dicasRightP[5][1] = "Osso da perna (jogo online)"

      -- aceita down; right; righdown
      setasP[2][1] = "right"
      setasP[1][4] = "down"
      setasP[5][1] = "right"
     
      
      
      local jogo = {palavras = grid, setas = setasP, dicasDown = dicasDownP ,dicasRight = dicasRightP,proximaFase= "cruzadas_f3"}
      
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