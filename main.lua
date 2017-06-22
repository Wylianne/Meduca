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



local tablesetup = [[CREATE TABLE IF NOT EXISTS fases (id INTEGER PRIMARY KEY, nome_jogo, qnt_fases INTEGER, qnt_fases_d INTEGER);]]
db:exec( tablesetup )

local tablesetup = [[CREATE TABLE IF NOT EXISTS fases_quebra_ossos (id INTEGER PRIMARY KEY, num_fase INTEGER NOT NULL, qnt_respostas INTEGER NOT NULL, resposta1 TEXT, resposta2 TEXT, resposta3 TEXT, img_pergunta TEXT);]]
db:exec( tablesetup )

local tablesetup = [[CREATE TABLE IF NOT EXISTS quebra_ossos (id INTEGER PRIMARY KEY, num_pontos);]]
db:exec( tablesetup )

local tablesetup = [[CREATE TABLE IF NOT EXISTS quebra_ossos_perguntas (id INTEGER PRIMARY KEY, palavra, dica1, dica2, dica3);]]
db:exec( tablesetup )

local tablesetup = [[CREATE TABLE IF NOT EXISTS quiz (id INTEGER PRIMARY KEY, num_pontos REAL);]]
db:exec( tablesetup )

local tablesetup = [[CREATE TABLE IF NOT EXISTS quiz_perguntas (id INTEGER PRIMARY KEY, pergunta, alter_1, alter_2, alter_3, alter_4, alter_5, resposta);]]
db:exec( tablesetup )	

local tablesetup = [[CREATE TABLE IF NOT EXISTS soma_ossos (id INTEGER PRIMARY KEY, num_pontos REAL);]]
db:exec( tablesetup )




verificaBD()

-- Setup the event listener to catch "applicationExit"
Runtime:addEventListener( "system", onSystemEvent )

native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

local composer = require( "composer" )
composer.gotoScene( "login" )
--composer.gotoScene( "menuPrincipal" )
--composer.gotoScene( "quiz" )

