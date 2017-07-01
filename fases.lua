local fases = {
    itens
  }

local mainLayout = require("mainLayout")

local fasesGrupo  


function fases:create(titulo, itens)
    
    if itens == nil then
       error("itens can't be nil.")
    elseif #itens == 0 then   
       error("itens can't be  empty.")
    elseif #itens ~= 0 then
       for i=1, #itens, 1 do
         if itens[i].status == nil or (itens[i].status~=0 and itens[i].status~=1) then
           error("some status item is nil or has a invalid value (1 or 0 permited)")
         end
       end  
    end
    
    
    
    fases.itens = itens
    fasesGrupo = display.newGroup()
    
    fasesGrupo:insert(mainLayout:create(titulo))
    
    gerarFases()
    
    return fasesGrupo
    
end

function goToFase(event)
    local composer =  require("composer")
    if (event.phase == "ended") then
        local id = event.target.id
        composer.gotoScene(itens[id].scene)
        
    end
end

function gerarFases()

    iniFase = display.contentCenterX - 100
    yFaseB = 70
    yFaseF = 60
    cont = 0

    for i=1, #itens, 1 do
        --+110
        if (i == 4) then
            yFaseB = 180
            yFaseF = 170
            iniFase = display.contentCenterX - 100
            cont = 0
        elseif (i == 7) then
            yFaseB = 290
            yFaseF = 280
            iniFase = display.contentCenterX - 100
            cont = 0
        elseif (i == 10) then
            yFaseB = 400
            yFaseF = 390
            iniFase = display.contentCenterX - 100
            cont = 0
        end

        if (itens[i].status == 1) then  -- desbloqueado
            local faseBack = display.newRoundedRect(display.contentCenterX * 1.05, 30, 70,90,12)
            faseBack:setFillColor(0.5,0.6,1, 0.5)
            faseBack.y = yFaseB
            faseBack.x = iniFase
            fasesGrupo:insert(faseBack)

            local faseFront = display.newRoundedRect(display.contentCenterX * 1.05, 30, 70,70,12)
            faseFront:setFillColor(0.5,0.6,1, 0.5)
            faseFront.y = yFaseF
            faseFront.x = iniFase
            faseFront.strokeWidth = 3
            faseFront.id = i
            faseFront:setStrokeColor( 1, 1, 0 )
            faseFront:addEventListener("touch", goToFase)
            fasesGrupo:insert(faseFront)


            local numFase = display.newText(i, 150, yFaseF, native.systemFont, 40 )
            numFase.x = display.contentCenterX

            if cont == 0 then
                numFase.x = display.contentCenterX -100
            elseif cont == 1 then
                numFase.x = display.contentCenterX
            elseif cont == 2 then
                numFase.x = display.contentCenterX + 100
            end
            fasesGrupo:insert(numFase)
        elseif (itens[i].status == 0) then

            local faseFront = display.newRoundedRect(display.contentCenterX * 1.05, 30, 70,70,12)
            faseFront:setFillColor(0.66,0.66,0.66)
            faseFront.y = yFaseF
            faseFront.x = iniFase
            faseFront.strokeWidth = 3
            faseFront:setStrokeColor(0.66,0.66,0.66)
            fasesGrupo:insert(faseFront)


            local cadeado = display.newImageRect("img_jogos/cadeado.png", 40, 40)
            cadeado.x = display.contentCenterX


            if cont == 0 then
                cadeado.x = display.contentCenterX -100
                cadeado.y = yFaseF
            elseif cont == 1 then
                cadeado.x = display.contentCenterX
                cadeado.y = yFaseF
            elseif cont == 2 then
                cadeado.x = display.contentCenterX + 100
                cadeado.y = yFaseF
            end
            fasesGrupo:insert(cadeado)
        end



        iniFase = iniFase + 100
        cont = cont + 1
    end

end



return fases