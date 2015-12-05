local gameState = require( "gamestate" )
local sfx = require( "sfx" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")

gameState.soundOn = nil
--sfx.bgmusic = nil

local bg, back, credits, musicSwitch, sfxSwitch, musicTX, langTX

local function onSwitchPress( event )
    local switch = event.target.id
    	if switch == "musicSwitch" then
    		if audio.isChannelPlaying( 1 )  then
				audio.pause( 1 )
				gameState.soundOn = false;
			elseif audio.isChannelPaused( 1 ) then
				audio.resume( 1 )
				gameState.soundOn = true;
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
		elseif button == "credits" then
			--storyboard.gotoScene( "credits", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	bg = display.newImage("images/settings_bg.png");
		bg.height = _H; bg.width = _W + _W/4;
		bg.x = _W/2; bg.y = _H/2;
	
	musicTX = display.newImage("images/musicTX.png");
		musicTX.height = _H/8; musicTX.width = _W/3 ;
		musicTX.x = _W/2 - _W/5 - 9; musicTX.y = _H/2 - _H/3 + 5;
	
	sfxTX = display.newImage("images/sfxTX.png");
		sfxTX.height = _H/9; sfxTX.width =_W/3;
		sfxTX.x = _W/2 - _W/6; sfxTX.y = _H/2 - _H/11;
	
	
	langTX = widget.newButton
	{
		defaultFile = "images/langTX.png",
		overFile ="images/langTX.png",
		id = "langTX",
		x = _W/2 ,
		y = _H/2 + _H/8,
		height =   _H/3,
		width = _W/2 + _W/6 ,
		onRelease = buttonOnRelease
	}

	back = widget.newButton
	{
		defaultFile = "images/back.png",
		overFile ="images/back.png",
		id = "back",
		x = _W/30,
		y = _H/10,
		height =  _H/9 + 17,
		width = _W/9 + 18 ,
		onRelease = buttonOnRelease
	}	

	credits = widget.newButton
	{
		defaultFile = "images/credits.png",
		overFile ="images/credits.png",
		id = "credits",
		x = _W/2,
		y = _H/2 + _H/3,
		height =  _H/7,
		width = _W/2 ,
		onRelease = buttonOnRelease
	}	
	
	musicSwitch = widget.newSwitch
	{
	    x = _W/2 + _W/4,
		y = _H/2 - _H/3 + 4,
		style = "onOff",
	    id = "musicSwitch",
	    initialSwitchState = true,
	    onPress =  onSwitchPress
	}
	
	sfxSwitch = widget.newSwitch
	{
	    x = _W/2 + _W/4,
		y = _H/2 - _H/11 + 1,
		style = "onOff",
	    id = "sfxSwitch",
	    onPress = onSwitchPress
	}

	-- musicSwitch:addEventListener("touch", onPress)
	    	
	group:insert( bg )
	group:insert( back )
	group:insert( musicTX )
	group:insert( sfxTX )
	group:insert( langTX )
	group:insert( musicSwitch )
	group:insert( sfxSwitch )
	group:insert( credits )
	-- group:insert( pickerWheel )
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

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene