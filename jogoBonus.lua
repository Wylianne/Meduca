native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"

local sheetInfo = require("sprites2")
local sheet = graphics.newImageSheet( "img_jogos/sprites/sprites2.png", sheetInfo:getSheet() )

local colisao = require("colisao")

local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
local esfera
local metros = 0
local texto
local comecou = false
local caindo = false
local velocidade = 4
local fundo2 = {}
local fundo1 = {}
local osso = {}
local vitamina = {}
local fx = {120,200}
local fx2 = {120,300}
local sequenciaOsso = {
		    { 
		    	name="queimar", 
		    	frames={ 
		    		sheetInfo:getFrameIndex("virus"),
            sheetInfo:getFrameIndex("virus"),
		    	}, 
		    	time=300
		    },
		}
  local sequenciaVitamina = {
		    { 
		    	name="subindo", 
		    	frames={ 
		    		sheetInfo:getFrameIndex("vitamina"),
		    	}, 
		    	time=300
		    },
		}

local sequenciaEsfera = {
		    { 
		    	name="parado", 
		    	frames={ 
		    		sheetInfo:getFrameIndex("esfera"),
		    	}, 
		    	time=100
		    },
		    { 
		    	name="andando", 
		    	frames={ 
		    		sheetInfo:getFrameIndex("esfera"),
		    		
		    	}, 
		    	time=500
		    },
         { 
		    	name="descendo", 
		    	frames={ 
		    		sheetInfo:getFrameIndex("esfera"),
		    	}, 
		    	time=1000
		    },
		  
		   
		}
  
     
function toque( event )
 if(comecou==false and caindo==false and event.phase == "began") then
 	comecou = true
 	esfera:setSequence("andando")
 	esfera:play()
 
 			transition.to(esfera,{time=300,x=halfW-(esfera.xScale + 20),y=100, onComplete=function() 
 				esfera:setSequence("descendo")
 				esfera:play()
 				caindo = true 
 				transition.to(esfera,{time=300,x=halfW-(esfera.xScale + 20),y=100,})
 			
 	end})
  
 end
 if caindo == true and event.phase == "began" then
 	esfera:setSequence("descendo")
 	if esfera.xScale > 0 then esfera.xScale = -0.5 esfera.x = halfW +20 else esfera.xScale = 0.5 esfera.x = halfW -20  end
 end
end

function loop( event )
 if caindo==true then
 
 	metros = metros + 0.1
  texto.text = math.floor( metros )
  texto.text = string.sub(texto.text,1,5)

 	for i=0, 2 do 
		local rand = math.random( 2 )
		local antes = 0;
		if i==0 then antes = 2 end
		if i==1 then antes = 0 end
		if i==2 then antes = 1 end
		osso[i].y = osso[i].y - velocidade
    vitamina[i].y = vitamina[i].y - (velocidade - 0.7)
    
    
		if osso[i].y < -10 then
			osso[i].x = fx[rand]
			osso[i].y = osso[antes].y + 200
      
		end
    
    if vitamina[i].y < -10 then
			vitamina[i].x = fx[rand]
			vitamina[i].y = vitamina[antes].y + 300
		end
   

		if colisao:hasCollidedCircle(esfera,osso[i]) then
			
      tela_perdeu = display.newGroup()
 
          local background_perdeu = display.newRect( tela_perdeu, 0, 0, display.contentWidth, display.contentHeight*2 )
          background_perdeu.anchorX = 0
          background_perdeu.anchorY = 0
        
          virus = display.newImage( tela_perdeu, "img_jogos/sprites/esfera-perde.png")
          virus.x=170
          virus.y= 150
           
          local resetBtn = display.newImageRect( tela_perdeu,"img_jogos/sprites/reload.png", 82, 62)
          resetBtn.x = 220
          resetBtn.y = 340
          resetBtn:addEventListener( "touch", reinicia )
          
          local back_menu = display.newImageRect(tela_perdeu, "img_jogos/sprites/voltar.png", 82, 62)          
          back_menu.x = 100
          back_menu.y = 340
          back_menu:addEventListener(  "touch", backMenu )
        
    
          background_perdeu:setFillColor( 0, 0, 0 ,0.89)
          background_perdeu = display.newText( tela_perdeu, "Você Perdeu" , 170, 220, native.systemFont, 26 )
          background_perdeu = display.newText( tela_perdeu, "Sua pontuação foi: ".. texto.text , 170, 245, native.systemFont, 26 )
          
         
          
    caindo = false
  end
  
  if colisao:hasCollidedCircle(esfera,vitamina[i]) then
 
    metros = metros + 2
    if vitamina[i].y < 90 then
			vitamina[i].x = fx[rand]
			vitamina[i].y = vitamina[antes].y + 300
		end
  end

	end 
 	
    velocidade = velocidade + 0.005
 end
 
end   


function reinicia(event) 
  if (event.phase == "ended") then
      
    display.remove(tela_perdeu)
    tela_perdeu = nil
   
    caindo = true
    
    velocidade = 4
    metros = 0
    
    scene:show()     
    
   
  end
end

function backMenu(event)
    if (event.phase == "ended") then
        
        display.remove(tela_perdeu)
        tela_perdeu = nil
        
        composer.removeScene("jogoBonus")
        composer.gotoScene("menuPrincipal")
 
    end
end

local function backgroud()
        nameApp = display.newText("Meduca - Jogo Bonus", 0, -15)
        nameApp:setFillColor(1,1,1)
        nameApp.x = display.contentCenterX
        group:insert(nameApp)
   
        background = display.newImage( sheet , sheetInfo:getFrameIndex("background"))      
        background.anchorX = 0
        background.anchorY = 0
        background.x = 0
        background.y = 0
        background.alpha = 1
        group:insert( background )
   
        fundo2[0] = display.newImage( sheet , sheetInfo:getFrameIndex("fundo1"))
        fundo2[0].anchorX = 0
        fundo2[0].anchorY = 0
        fundo2[0].x = 250
        fundo2[0].y = 0
        group:insert( fundo2[0] )
        
        
        fundo1[0] = display.newImage( sheet , sheetInfo:getFrameIndex("fundo1"))
        fundo1[0].anchorX = 0
        fundo1[0].anchorY = 0
        fundo1[0].x = -140
        fundo1[0].y = 0
        group:insert( fundo1[0])
end

local function addEsfera()
     
        esfera = display.newSprite( sheet , sequenciaEsfera)
        esfera.anchorX = 1
        esfera.anchorY = 1
        esfera.x = 180
        esfera.y = 100
        esfera:scale(0.5,0.5)
        esfera.nome = "esfera"
        esfera:setSequence("parado")
        esfera:play()
        group:insert( esfera )
end

local function addOsso()
     
        for i=0, 2 do 
          local rand = math.random( 2 )
          osso[i] = display.newSprite(sheet, sequenciaOsso)
          osso[i].anchorX = 0.5
          osso[i].anchorY = 0
          osso[i].x = fx[rand]
          osso[i].y = (screenH+200) + (200*i)
          osso.nome = "osso"
          osso[i]:scale(0.5,0.5)
          osso[i]:setSequence("queimar")
          osso[i]:play()
          group:insert( osso[i] )
        end
end

local function addVitamina()
     
       for i=0, 2 do 
          local rand = math.random( 2 )
          vitamina[i] = display.newSprite(sheet, sequenciaVitamina)
          vitamina[i].anchorX = 0.5
          vitamina[i].anchorY = 0
          vitamina[i].x = fx[rand]
          vitamina[i].y =(screenH+200) + (300*i)
          vitamina.nome = "VT"
          vitamina[i]:scale(0.5,0.5)
          vitamina[i]:setSequence("subindo")
          vitamina[i]:play()
          group:insert( vitamina[i] )
        end
end
  
function scene:create(event)
 
     
end
        
function scene:show( event )
  group = scene.view
      backgroud()
      addEsfera()
      addOsso()
      addVitamina()
        
      texto = display.newText( "0", 50, 20, native.systemFont, 26 )
      texto:setFillColor( 255, 255, 255 )
      group:insert( texto)
end




scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
   
Runtime:addEventListener( "touch", toque )

Runtime:addEventListener( "enterFrame", loop )

  
return scene