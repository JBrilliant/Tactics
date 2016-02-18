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
--loadsave.saveTable(gamestate.gameSettings, "myTable.json", system.DocumentsDirectory)
gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)

function onSystemEvent( event )
if event.type == "applicationStart" then
	-- gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
	if gameSettings == nil then 
		loadsave.saveTable(gamestate.gameSettings, "myTable.json", system.DocumentsDirectory)-- set default at start
		gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
		-- if gameSettings ~= nil then		
		-- end
	end
	loadsfx()
elseif event.type == "applicationOpen" then
	-- gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
	loadsfx()
	if gameSettings == nil then 
		loadsave.saveTable(gamestate.gameSettings, "myTable.json", system.DocumentsDirectory)
		gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
		-- loadsfx()
	end
elseif event.type == "applicationExit" then
	loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
elseif event.type == "applicationSuspend" then
	loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
elseif event.type == "applicationResume" then
	if gameSettings ~= nil then 
		loadsave.loadTable("myTable.json", system.DocumentsDirectory)
		-- loadsfx()
	end
end
end
Runtime:addEventListener( "system", onSystemEvent )

-- voiceovers
function loadsfx()
																							-- channels
sfx.bgmusic = audio.loadSound("audio/bgmusic.wav")											-- 1	
sfx.level1s1 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-1.wav")	-- 2
sfx.level1s2 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-2.wav")	-- 3
sfx.level1s3 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-3.wav")	-- 4
sfx.level1s4 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-4.wav")	-- 5
sfx.level1s5 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-5.wav")	-- 6
sfx.level1s6 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-6.wav")	-- 7
sfx.level1s7 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-7.wav")	-- 8

sfx.level2s1 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level2/level2-1.wav")	-- 9
sfx.level2s2 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level2/level2-2.wav")	-- 10
sfx.level2s3 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level2/level2-3.wav")	-- 11
sfx.level2s4 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level2/level2-4.wav")	-- 12
sfx.level2s5 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level2/level2-5.wav")	-- 13

sfx.level3s1 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level3/level3-1.wav")	-- 14
sfx.level3s2 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level3/level3-2.wav")	-- 15
sfx.level3s3 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level3/level3-3.wav")	-- 16
sfx.level3s4 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level3/level3-4.wav")	-- 17
sfx.level3s5 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level3/level3-5.wav")	-- 18

sfx.level4s1 = audio.loadSound("audio/"..gameSettings.lang.."/boy/level4/level4-1.wav")		-- 19
sfx.level4s2 = audio.loadSound("audio/"..gameSettings.lang.."/boy/level4/level4-2.wav")		-- 20
sfx.level4s3 = audio.loadSound("audio/"..gameSettings.lang.."/boy/level4/level4-3.wav")		-- 21
sfx.level4s4 = audio.loadSound("audio/"..gameSettings.lang.."/boy/level4/level4-4.wav")		-- 22
sfx.level4s5 = audio.loadSound("audio/"..gameSettings.lang.."/boy/level4/level4-5.wav")		-- 23

sfx.level4s1G = audio.loadSound("audio/"..gameSettings.lang.."/girl/level4/level4-1.wav")	-- 24
sfx.level4s2G = audio.loadSound("audio/"..gameSettings.lang.."/girl/level4/level4-2.wav")	-- 25
sfx.level4s3G = audio.loadSound("audio/"..gameSettings.lang.."/girl/level4/level4-3.wav")	-- 26
sfx.level4s4G = audio.loadSound("audio/"..gameSettings.lang.."/girl/level4/level4-4.wav")	-- 27
sfx.level4s5G = audio.loadSound("audio/"..gameSettings.lang.."/girl/level4/level4-5.wav")	-- 28

sfx.level5s1 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level5/level5-0.wav")	-- 29
sfx.level5s2 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level5/level5-1.wav")	-- 30
sfx.level5s3 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level5/level5-2.wav")	-- 31
sfx.level5s4 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level5/level5-3.wav")	-- 32
sfx.click = audio.loadSound("audio/click.wav")												-- 33					
sfx.passed = audio.loadSound("audio/passed.wav")											-- 34	
sfx.achieve = audio.loadSound("audio/achieve.wav")											-- 34	

end

storyboard.gotoScene("menu")