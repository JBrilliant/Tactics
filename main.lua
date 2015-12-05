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

storyboard.gotoScene("menu")
