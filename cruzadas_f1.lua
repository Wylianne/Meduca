local composer =  require("composer") 

local cruzadas = require( "cruzadas" )


local cruzadasF1 = composer.newScene()


   
function cruzadasF1:create(event)
    SceneGroup = self.view
    
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
  
   local tips = {
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
              {" "," "," "," "," "," "," "," "},
  }

      tips[1][1] = "Serve para abrir"
      tips[2][3] = "Mais que colega"
      tips[5][3] = "Ver(substantivo)"
      tips[6][5] = "O dia atual"
      
      
      local jogo = {palavras = grid, dicas = tips}
      
      SceneGroup:insert(cruzadas:create(jogo))
    
    
end

cruzadasF1:addEventListener("create", cruzadasF1)

return cruzadasF1