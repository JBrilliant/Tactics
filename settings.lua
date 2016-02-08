local loadsave = require( "loadsave" )
local sfx = require( "sfx" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
-- gameState.soundOn = nil
--sfx.bgmusic = nil

local bg, back,  musicSwitch, sfxSwitch, lang

local function onSwitchPress( event )
    local switch = event.target.id
    	if switch == "musicSwitch" then
    		if audio.isChannelPlaying( 1 ) and  gameSettings.musicOn == true then
				audio.pause( 1 )
				gameSettings.musicOn = false;
				loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
			elseif audio.isChannelPaused( 1 ) and gameSettings.musicOn == false then
				audio.resume( 1 )
				gameSettings.musicOn = true;
				loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
			end
	    elseif switch == "sfxSwitch" then
	    	--stop sfx
	    end
end

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "langTX" then
			storyboard.gotoScene( "chooseLang", "fade", 200 )
		elseif button == "back" then
			storyboard.gotoScene( "menu", "fade", 200 )
		-- elseif button == "credits" then
		-- 	--storyboard.gotoScene( "credits", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	bg = display.newImage("images/settings_bg.png"); bg.height = _H; bg.width = _W + _W/4; bg.x = _W/2; bg.y = _H/2;
	back = widget.newButton { defaultFile = "images/back.png", overFile ="images/back.png", id = "back", x = _W/30, y = _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	lang = widget.newButton { defaultFile = "images/"..gameSettings.lang.."/chooselang.png", overFile ="images/"..gameSettings.lang.."/chooselang.png", id = "langTX", x = _W/2 , y = _H/2 + _H/3, height =   _H/6, width = _W/2 + _W/6 , onRelease = buttonOnRelease }

local options = {
    frames = {
        { x=0, y=0, width=160, height=44 },
        { x=0, y=45, width=42, height=42 },
        { x=44, y=45, width=42, height=42 },
        { x=88, y=44, width=96, height=44 }
    },
    sheetContentWidth = 184,
    sheetContentHeight = 88
	}
	local onOffSwitchSheet = graphics.newImageSheet( "images/widget-on-off-sheet.png", options )

	musicSwitch = widget.newSwitch
	{
	    x = _W/2 + _W/4,
		y = _H/2 - _H/3 + 20,
		style = "onOff",
	    id = "musicSwitch",
	    initialSwitchState = gameSettings.musicOn,
	    onPress =  onSwitchPress,

	    sheet = onOffSwitchSheet,

	        onOffBackgroundFrame = 1,
	        onOffBackgroundWidth = 160,
	        onOffBackgroundHeight = 44,
	        onOffMask = "images/widget-on-off-mask.png",

	        onOffHandleDefaultFrame = 2,
	        onOffHandleOverFrame = 3,

	        onOffOverlayFrame = 4,
	        onOffOverlayWidth = 96,
	        onOffOverlayHeight = 44

	}
	

	sfxSwitch = widget.newSwitch
	{
	    x = _W/2 + _W/4,
		y = _H/2 ,
		style = "onOff",
	    id = "sfxSwitch",
	    initialSwitchState = gameSettings.soundOn,
	    onPress = onSwitchPress
	}
	
	
	group:insert( bg )
	group:insert( back )
	group:insert( lang )
	group:insert( musicSwitch )
	group:insert( sfxSwitch )
	-- group:insert( credits )
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	-- widgets must be manually removed, such as life
	if back and langTx and credits  then
		back:removeSelf()
		langTx:removeSelf()
		credits:removeSelf()
		back = nil 
		langTx= nil 
		credits= nil 
	end
end

loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene