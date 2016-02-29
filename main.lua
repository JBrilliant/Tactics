-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
_W = display.contentWidth;
_H = display.contentHeight;

local storyboard = require("storyboard");
local sfx = require("sfx");
local loadsave = require("loadsave");
local gamestate = require("gamestate");


-- set default game settings
-- loadsave.saveTable(gamestate.gameSettings, "myTable.json", system.DocumentsDirectory)
gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)

function onSystemEvent( event )
	if event.type == "applicationStart" then
		if gameSettings == nil then 
			loadsave.saveTable(gamestate.gameSettings, "myTable.json", system.DocumentsDirectory)
			gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
		end
	elseif event.type == "applicationOpen" then
		if gameSettings == nil then 
			loadsave.saveTable(gamestate.gameSettings, "myTable.json", system.DocumentsDirectory)
			gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
		else
			gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
		end
	elseif event.type == "applicationExit" then
		loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
	elseif event.type == "applicationSuspend" then
		loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
	elseif event.type == "applicationResume" then
		if gameSettings ~= nil then 
			loadsave.loadTable("myTable.json", system.DocumentsDirectory)
		end
	end
end
Runtime:addEventListener( "system", onSystemEvent )


storyboard.gotoScene("menu")