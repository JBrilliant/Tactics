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


-- save default game settings
loadsave.saveTable(gamestate.gameSettings, "myTable.json", system.DocumentsDirectory)

-- voiceover
sfx.bgmusic = nil
sfx.bgmusic = audio.loadSound("audio/Tango.wav")
sfx.level1s1 = audio.loadSound("audio/level1/Voice 1.3gpp")
sfx.level1s2 = audio.loadSound("audio/level1/Voice 2.3gpp")
sfx.level1s3 = audio.loadSound("audio/level1/Voice 3.3gpp")
sfx.level1s4 = audio.loadSound("audio/level1/Voice 4.3gpp")
sfx.level1s5 = audio.loadSound("audio/level1/Voice 5.3gpp")
sfx.level1s6 = audio.loadSound("audio/level1/Voice 5(2).3gpp")

storyboard.gotoScene("menu")
