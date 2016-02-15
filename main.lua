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
sfx.bgmusic = audio.loadSound("audio/bgmusic.mp3")
sfx.level1s1 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-1.mp3")
sfx.level1s2 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-1a.mp3")
sfx.level1s3 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-1b.mp3")
sfx.level1s4 = audio.loadSound("audio/"..gameSettings.lang.."/girl/level1/level1-1c.mp3")
-- sfx.level1s5 = audio.loadSound("audio/level1/Voice 5.3gpp")
-- sfx.level1s6 = audio.loadSound("audio/level1/Voice 5(2).3gpp")



storyboard.gotoScene("menu")
