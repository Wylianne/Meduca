-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--Iniciando DB
local sqlite3 = require( "sqlite3" )

local path = system.pathForFile( "meduca.db", system.DocumentsDirectory )
local db = sqlite3.open( path )  

local function onSystemEvent( event )
    if ( event.type == "applicationExit" ) then    
    	if db and db:isopen() then         
        	db:close()
        end
    end
end
  

local tablesetup = [[CREATE TABLE IF NOT EXISTS quebra_ossos (id INTEGER PRIMARY KEY, num_pontos);]]
db:exec( tablesetup )

local tablesetup = [[CREATE TABLE IF NOT EXISTS quebra_ossos_perguntas (id INTEGER PRIMARY KEY, palavra, dica1, dica2, dica3);]]
db:exec( tablesetup )



-- Setup the event listener to catch "applicationExit"
Runtime:addEventListener( "system", onSystemEvent )



local composer = require( "composer" )
--composer.gotoScene("login")
--composer.gotoScene("menuPrincipal")
composer.gotoScene("quebra_ossos")
--composer.gotoScene("clinica")

