local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require("widget")
local sfx = require("sfx")
local loadsave = require("loadsave")
gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)


-- gameState.soundOn = nil

local bg, back, nextB

local function buttonOnRelease( event )
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "achievements", "fromLeft", 500 )
		end
end

local function buttonOnPress(event)
	local availableChannel = audio.findFreeChannel()
	if gameSettings.soundOn == true then
		audio.play( sfx.click, { loops = 0, channel = availableChannel, onComplete = function()  audio.dispose( sfx.click )  end } )
	end
end

function scene:createScene( event )
	local group = self.view

	back = widget.newButton { defaultFile = "images/back.png", overFile ="images/back.png", id = "back", x = _W/30, y = _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease , onPress = buttonOnPress}	
	-- nextB = widget.newButton { defaultFile = "images/next2.png", overFile ="images/next2.png", id = "nextB", x = _W - _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	bg = display.newImage("images/bgplain.jpg"); bg.height = _H; bg.width = _W + _W/4; bg.x = _W/2; bg.y = _H/2;
	group:insert( bg )
	-- group:insert( nextB )
	local lang = gameSettings.lang
		if lang == "bicol" then lang = "tagalog" end

	local box = display.newImage("images/"..lang.."/b5.png"); box.x = box.x + 125 - 60;box.y =  _H/2 + 10; box.width =_W/5 + 30;box.height = 280; 
	local badge = display.newImage("images/badge 5.png"); badge.height = _W/5 + 20; badge.width = _W/5 + 20; badge.x = badge.x + 125 - 60; badge.y = _H/4 + 15;
	local confetti = display.newImage("images/confetti.png"); confetti.x = _W - _W/3; confetti.y =  _H/2 ; confetti.width =_W/2 + 200;confetti.height = _H; 
	local trophy = display.newImage("images/trophy.png"); trophy.x = _W - _W/3; trophy.y =  _H/2 ; trophy.width =_W/2 + 10;trophy.height = 280; 
		
	if ( 6 > gameSettings.unlockedAchieve) then
		badge.alpha = 0.3;  box.alpha = 0.3; trophy.alpha = 0.3; confetti.alpha = 0.3
    end

	group:insert(box)
	group:insert(badge)
	group:insert(confetti) 
	group:insert(trophy)
	
	group:insert( back )
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	-- widgets must be manually removed, such as life
	if back  and nextB then
		back:removeSelf()
		nextB:removeSelf()
		back = nil 
		nextB = nil 
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene