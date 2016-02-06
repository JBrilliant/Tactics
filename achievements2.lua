local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require("widget")
local loadsave = require("loadsave")
gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)


-- gameState.soundOn = nil

local bg, back, nextB

local function buttonOnRelease( event )
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "achievements", "fade", 200 )
		elseif button == "nextB" then
			storyboard.gotoScene( "achievements2", "fade", 200 )
		end

end

function scene:createScene( event )
	local group = self.view

	back = widget.newButton { defaultFile = "images/back.png", overFile ="images/back.png", id = "back", x = _W/30, y = _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	-- nextB = widget.newButton { defaultFile = "images/next2.png", overFile ="images/next2.png", id = "nextB", x = _W - _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	bg = display.newImage("images/bgplain.jpg"); bg.height = _H; bg.width = _W + _W/4; bg.x = _W/2; bg.y = _H/2;
	group:insert( bg )
	-- group:insert( nextB )
	
	local badge = {}
	local j = 1
	local box = {}
	for i=5, 8 do 
		box[i] = display.newImage("images/"..gameSettings.lang.."/b"..i..".png"); box[i].x = box[i].x + (125*j) - 60;box[i].y =  _H/2 + 10; box[i].width =_W/5 + 30;box[i].height = 280; 
		group:insert(box[i])
		badge[i] = display.newImage("images/badge "..i..".png"); badge[i].height = _W/5 + 20; badge[i].width = _W/5 + 20; badge[i].x = badge[i].x + (125*j) - 60; badge[i].y = _H/4 + 15;
		group:insert(badge[i])
		j = j + 1
		if ( i > gameSettings.unlockedAchieve) then
			badge[i].alpha = 0.5; box[i].alpha = 0.5
        end  
	end
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