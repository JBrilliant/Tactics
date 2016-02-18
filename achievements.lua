local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require("widget")
local sfx = require("sfx")
local loadsave = require("loadsave")
local gamestate = require("gamestate")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
-- gameState.soundOn = nil

local bg, back, nextB

local function buttonOnRelease( event )
	local button = event.target.id
		if button == "back" then
			storyboard.removeAll();
			storyboard.gotoScene( "menu", "fade", 200 )
		elseif button == "nextB" then
			storyboard.gotoScene( "achievements2", "fromRight", 500 )
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

	back = widget.newButton { defaultFile = "images/back.png", overFile ="images/back.png", id = "back", x = _W/40, y = _H/15, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease, onPress = buttonOnPress }	
	nextB = widget.newButton { defaultFile = "images/next.png", overFile ="images/next.png", id = "nextB", x = _W - _W/80, y = _H/15, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease, onPress = buttonOnPress }	
	bg = display.newImage("images/bgplain.jpg"); bg.height = _H; bg.width = _W + _W/4; bg.x = _W/2; bg.y = _H/2;
	group:insert( bg )
	local lang = gameSettings.lang
		if lang == "bicol" then lang = "tagalog" end
	local badge = {}
	local box = {}
	for i=1, 4 do 
		-- box[i] = display.newImage("images/english/b"..i..".png"); box[i].x = box[i].x + (125*i) - 60;box[i].y =  _H/2 + 10; box[i].width =_W/5 + 30;box[i].height = 280; 
		box[i] = display.newImage("images/"..lang.."/b"..i..".png"); box[i].x = box[i].x + (125*i) - 60;box[i].y =  _H/2 + 10; box[i].width =_W/5 + 30;box[i].height = 280; 
		group:insert(box[i])
		badge[i] = display.newImage("images/badge "..i..".png"); badge[i].height = _W/5 + 20; badge[i].width = _W/5 + 20; badge[i].x = badge[i].x + (125*i) - 60; badge[i].y = _H/4 + 15;
		group:insert(badge[i])
		 if ( i > gameSettings.unlockedAchieve) then
			badge[i].alpha = 0.3; box[i].alpha = 0.3
        end  
	end	
group:insert( back )
	group:insert( nextB )

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