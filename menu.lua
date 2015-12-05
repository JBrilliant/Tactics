local gameState = require( "gamestate" )
local sfx = require( "sfx" )

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local widget = require("widget")


local welcome, newGame, settings, achieve, rank, upgrades

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "newGame" then
			storyboard.gotoScene( "character", "fade", 200 )
		elseif button == "settings" then
			storyboard.gotoScene( "settings", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	welcome = display.newImage ("images/welcome.png")
	welcome.height = _H; welcome.width = _W + _W/4;
	welcome.x = _W/2; welcome.y = _H/2;

	
	newGame = widget.newButton
	{
		defaultFile = "images/newGame.png",
		overFile ="images/newGame_o.png",
		id = "newGame",
		x = _W/2,
		y = _H/2 + _H/7,
		height =  _H/7,
		width = _W/2,
		onRelease = buttonOnRelease
	}
	
	settings = widget.newButton
	{
		defaultFile = "images/settings.png",
		overFile ="images/settings.png",
		id = "settings",
		x = _W/3 - newGame.width/3,
		y = _H/2 + newGame.width/2,
		height =  _H/7,
		width = _W/9 ,
		onRelease = buttonOnRelease
	}
	
	achieve = widget.newButton
	{
		defaultFile = "images/achievements.png",
		overFile ="images/achievements.png",
		id = "achievements",
		x =_W/2 - newGame.width/4,
		y = _H/2 + newGame.width/2,
		height =  _H/7,
		width = _W/9 ,
		onRelease = buttonOnRelease
	}

	rank = widget.newButton
	{
		defaultFile = "images/ranking.png",
		overFile ="images/ranking.png",
		id = "ranking",
		x =_W/2 + newGame.width/4,
		y = _H/2 + newGame.width/2,
		height =  _H/7,
		width = _W/9 ,
		onRelease = buttonOnRelease
	}	

	upgrades = widget.newButton
	{
		defaultFile = "images/upgrades.png",
		overFile ="images/upgrades.png",
		id = "upgrades",
		x = _W - newGame.width/4,
		y = _H/2 + newGame.width/2,
		height =  _H/7,
		width = _W/9 ,
		onRelease = buttonOnRelease
	}

	group:insert( welcome)
	group:insert( newGame)
	group:insert( settings)
	group:insert( achieve)
	group:insert( rank)
	group:insert( upgrades)
end

function scene:enterScene( event )
    -- sfx.bgmusic = audio.loadSound("bgmusic.mp3")
    if ( gameState.soundOn ) then
  		 audio.play( sfx.bgmusic, { loops = -1, channel = 1,
    							onComplete = function() 
                                    audio.dispose( sfx.bgmusic ) 
                                end } )
	end

end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view

	-- widgets must be manually removed, such as life
	if newGame and settings and achieve and rank and upgrades then
		newGame:removeSelf()
		settings:removeSelf()
		achieve:removeSelf()
		rank:removeSelf()
		upgrades:removeSelf()
		newGame = nil 
		settings= nil 
		achieve= nil 
		rank= nil  
		upgrades= nil 
	end

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene