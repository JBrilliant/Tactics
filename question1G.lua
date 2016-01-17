local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "scene1G", "fade", 200 )
		elseif button == "video" then
		-- 	media.playVideo("level1.mp4", true)
			display.newImage("images/lvl1.gif")
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;
--	transition.to( background, {alpha=0,time=3000, delay=2000 } )
	group:insert(background)
	local back = widget.newButton
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
		group:insert( back )
	
	local textQuest =  display.newText( "What will you do?", 270, 10, native.systemFontBold, 24 )
		textQuest.x = _W/2
		textQuest.y = _H/4
		textQuest:setFillColor( 1,1,1 )
	-- timer.performWithDelay(19000, scene9)
	group:insert(textQuest)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene