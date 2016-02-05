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
			storyboard.gotoScene( "menu", "fade", 200 )
		elseif button == "nextB" then
			storyboard.gotoScene( "achievements2", "fade", 200 )
		end

end

function scene:createScene( event )
	local group = self.view

	back = widget.newButton { defaultFile = "images/back.png", overFile ="images/back.png", id = "back", x = _W/30, y = _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	nextB = widget.newButton { defaultFile = "images/next2.png", overFile ="images/next2.png", id = "nextB", x = _W - _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	bg = display.newImage("images/bgplain.jpg"); bg.height = _H; bg.width = _W + _W/4; bg.x = _W/2; bg.y = _H/2;
	group:insert( bg )
	group:insert( back )
	group:insert( nextB )
	
	local badge = {}
	-- local box = {}
	for i=1, 4 do 
		badge[i] = display.newImage("images/badge "..i..".png"); badge[i].height = _W/5 + 20; badge[i].width = _W/5 + 20; badge[i].x = badge[i].x + (120*i) - 60; badge[i].y = _H/4 + 30;
		group:insert(badge[i])
		-- box[i] = display.newRect(badge[i].x + (120*i) - 60,  _H/4 + 30, _W/5 + 25, _H/3); box[i]:setFillColor(205, 192, 203)
		-- group:insert(box[i])
		 if ( i > gameSettings.unlockedAchieve) then
			badge[i].alpha = 0.3
        end  
	end	
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