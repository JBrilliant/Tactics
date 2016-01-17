-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
_W = display.contentWidth;
_H = display.contentHeight;

local storyboard = require("storyboard");
local sfx = require("sfx");
--local widget = require("widget")
	
--display.setStatusBar(display.HiddenStatusBar);

--composer.gotoScene("menu");

-- local mainGroup = display.newGroup();

-- local function main()

-- 	mainGroup:insert(director.currentView)
-- 	mainGroup:insert(director.nextView)
--     director:changeScene("menu");
-- 	return true; 
-- end

-- 
-- forward declare the handle
sfx.bgmusic = nil
sfx.bgmusic = audio.loadSound("audio/Tango.wav")
sfx.level1s1 = audio.loadSound("audio/level1/1.wav")
sfx.level1s2 = audio.loadSound("audio/level1/2.wav")
sfx.level1s3 = audio.loadSound("audio/level1/3.wav")
sfx.level1s4 = audio.loadSound("audio/level1/4.wav")
sfx.level1s5 = audio.loadSound("audio/level1/5.wav")
sfx.level1s6 = audio.loadSound("audio/level1/6.wav")

storyboard.gotoScene("menu")
