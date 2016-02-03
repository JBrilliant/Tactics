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
sfx.bgmusic = audio.loadSound("audio/bgmusic.3gp")
sfx.level1s1 = audio.loadSound("audio/level1/English/Voice 15.3gpp")
sfx.level1s2 = audio.loadSound("audio/level1/English/Voice 16.3gpp")
sfx.level1s3 = audio.loadSound("audio/level1/English/Voice 17.3gpp")
sfx.level1s4 = audio.loadSound("audio/level1/English/Voice 18.3gpp")
sfx.level1s5 = audio.loadSound("audio/level1/Voice 5.3gpp")
sfx.level1s6 = audio.loadSound("audio/level1/Voice 5(2).3gpp")

storyboard.gotoScene("menu")
