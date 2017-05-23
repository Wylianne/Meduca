local composer =  require("composer") 

local fasesCruzadas = composer.newScene()


function fasesCruzadas:create(event)
    SceneGroup = self.view
    
    local fases = require("fases")
    
    itens = {
            {status=1, scene = "cruzadas_f1"}, {status=1, scene = "cruzadas_f2"},
            {status=0, scene = ""},
            {status=0, scene = ""}, {status=0, scene = ""},{status=0, scene = ""},
            {status=0, scene = ""}, {status=0, scene = ""},{status=0, scene = ""},
            {status=0, scene = ""}, {status=0, scene = ""},{status=0, scene = ""},
    }
    
    --itens = {}
    SceneGroup:insert(fases:create("Palavras Cruzadas",itens))
    
end



fasesCruzadas:addEventListener("create", fasesCruzadas)
return fasesCruzadas