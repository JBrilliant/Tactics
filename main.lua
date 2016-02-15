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
loadsave.saveTable(gamestate.gameSettings, "myTable.json", system.DocumentsDirectory)
gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)

-- voiceovers
sfx.bgmusic = nil
sfx.bgmusic = audio.loadSound("audio/bgmusic.m4a")		-- 1								-- channel
sfx.level1s1 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-1.mp3")	-- 2
sfx.level1s2 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-2.mp3")	-- 3
sfx.level1s3 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-3.mp3")	-- 4
sfx.level1s4 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-4.mp3")	-- 5
sfx.level1s5 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-5.mp3")	-- 6
sfx.level1s6 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-6.mp3")	-- 7
sfx.level1s7 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-7.mp3")	-- 8

sfx.level2s1 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level2/level2-1.mp3")	-- 9
sfx.level2s2 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level2/level2-2.mp3")	-- 10
sfx.level2s3 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level2/level2-3.mp3")	-- 11
sfx.level2s4 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level2/level2-4.mp3")	-- 12
sfx.level2s5 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level2/level2-5.mp3")	-- 13

sfx.level3s1 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level3/level3-1.mp3")	-- 14
sfx.level3s2 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level3/level3-2.mp3")	-- 15
sfx.level3s3 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level3/level3-3.mp3")	-- 16
sfx.level3s4 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level3/level3-4.mp3")	-- 17
sfx.level3s5 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level3/level3-5.mp3")	-- 18

sfx.level4s1 = audio.loadSound("audio/"..gameSettings.lang.."/boy/level4/level4-1.mp3")	-- 19
sfx.level4s2 = audio.loadSound("audio/"..gameSettings.lang.."/boy/level4/level4-2.mp3")	-- 20
sfx.level4s3 = audio.loadSound("audio/"..gameSettings.lang.."/boy/level4/level4-3.mp3")	-- 21
sfx.level4s4 = audio.loadSound("audio/"..gameSettings.lang.."/boy/level4/level4-4.mp3")	-- 22
sfx.level4s5 = audio.loadSound("audio/"..gameSettings.lang.."/boy/level4/level4-5.mp3")	-- 23

sfx.level4s1G = audio.loadSound("audio/"..gameSettings.lang.."/girl/level4/level4-1.mp3")	-- 24
sfx.level4s2G = audio.loadSound("audio/"..gameSettings.lang.."/girl/level4/level4-2.mp3")	-- 25
sfx.level4s3G = audio.loadSound("audio/"..gameSettings.lang.."/girl/level4/level4-3.mp3")	-- 26
sfx.level4s4G = audio.loadSound("audio/"..gameSettings.lang.."/girl/level4/level4-4.mp3")	-- 27
sfx.level4s5G = audio.loadSound("audio/"..gameSettings.lang.."/girl/level4/level4-5.mp3")	-- 28

sfx.level5s1 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level5/level5-0.mp3")	-- 29
sfx.level5s2 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level5/level5-1.mp3")	-- 30
sfx.level5s3 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level5/level5-2.mp3")	-- 31
sfx.level5s4 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level5/level5-3.mp3")	-- 32

storyboard.gotoScene("menu")

local function onSystemEvent( event )
if event.type == "applicationStart" then
	loadsave.loadTable("myTable.json", system.DocumentsDirectory)
	gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
elseif event.type == "applicationOpen" then
	loadsave.loadTable("myTable.json", system.DocumentsDirectory)
	gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
elseif event.type == "applicationExit" then
	loadsave.saveTable(gamestate.gameSettings, "myTable.json", system.DocumentsDirectory)
elseif event.type == "applicationSuspend" then
	loadsave.saveTable(gamestate.gameSettings, "myTable.json", system.DocumentsDirectory)
elseif event.type == "applicationResume" then
	loadsave.loadTable("myTable.json", system.DocumentsDirectory)
end
end
Runtime:addEventListener( "system", onSystemEvent )
