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
    		if audio.isChannelPlaying( 1 )  then
				audio.pause( 1 )
				gameSettings.musicOn = false;
			elseif audio.isChannelPaused( 1 ) then
				audio.resume( 1 )
				gameSettings.musicOn = true;
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

	bg = display.newImage("images/settings_bg.png");
		bg.height = _H; bg.width = _W + _W/4;
		bg.x = _W/2; bg.y = _H/2;
	
	
	lang = widget.newButton
	{
		defaultFile = "images/chooselang.png",
		overFile ="images/chooselang.png",
		id = "langTX",
		x = _W/2 ,
		y = _H/2 + _H/3,
		height =   _H/6,
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

	
	
	musicSwitch = widget.newSwitch
	{
	    x = _W/2 + _W/4,
		y = _H/2 - _H/3 + 20,
		style = "onOff",
	    id = "musicSwitch",
	    initialSwitchState = true,
	    onPress =  onSwitchPress
	}
	
	sfxSwitch = widget.newSwitch
	{
	    x = _W/2 + _W/4,
		y = _H/2 ,
		style = "onOff",
	    id = "sfxSwitch",
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