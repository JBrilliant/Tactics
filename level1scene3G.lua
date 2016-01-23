 --Tell your parents
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "mapG", "fade", 200 )
		elseif button == "nextB" then
			storyboard.gotoScene( "level1question3G", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;
	
	local back = widget.newButton
	{
		defaultFile = "images/back2.png",			
		overFile ="images/back2.png",
		id = "back",
		x = _W/30,
		y = _H - _H/10,
		height =  _H/9 + 17,
		width = _W/9 + 18 ,
		onRelease = buttonOnRelease
	}	
	

	local nextB = widget.newButton
	{
		defaultFile = "images/next2.png",			
		overFile ="images/next2.png",
		id = "nextB",
		x = _W - 30,
		y = _H - _H/10,
		height =  _H/9 + 17,
		width = _W/9 + 18 ,
		onRelease = buttonOnRelease
	}	
	
	local scenario = display.newImage("images/level1/scene23.jpg")
	scenario.height = _H; scenario.width = _W + _W/4;
	scenario.x = _W/2; scenario.y = _H/2;
	
	timer.performWithDelay(4000,function(e)
			storyboard.gotoScene("level1question3G","fade",200)
		end,1)	




--animation:addEventListener( "sprite", spriteListener )
group:insert(background)
group:insert(scenario)
group:insert( nextB )
group:insert( back )

		
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene