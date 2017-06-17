-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local sqlite3 = require( "sqlite3" )
local banco = require( "import" )

local path = system.pathForFile( "meduca.db", system.DocumentsDirectory )
local db = sqlite3.open( path )  

local function onSystemEvent( event )
    if ( event.type == "applicationExit" ) then    
    	if db and db:isopen() then         
        	db:close()
        end
    end
end	

verificaBD()

-- Setup the event listener to catch "applicationExit"
Runtime:addEventListener( "system", onSystemEvent )

native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer = require( "composer" )
--composer.gotoScene( "login" )
composer.gotoScene( "menuPrincipal" )
--composer.gotoScene( "quiz" )

