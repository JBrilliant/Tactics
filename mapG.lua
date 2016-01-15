local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local widget = require("widget")

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "level1" then
			storyboard.gotoScene( "scene1G", "fade", 200 )
		elseif button == "back" then
			storyboard.gotoScene( "character", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view
	
	local bg = display.newImage("images/map.png");
	bg.height = _H; bg.width = _W + _W/4;
	bg.x = _W/2; bg.y = _H/2;
	
	-- local level1 = display.newImage("level.png");
	-- level1.height = _H/13 +5; level1.width = _W/13 +1;
	-- level1.x = _W/2 + _W/6 +8; level1.y = _H/2 + _H/4 +6;

	local level1 = widget.newButton
	{
		defaultFile = "images/level_candies_active.png",
		overFile ="images/level_candies_active.png",
		id = "level1",
		x = _W/2 + _W/6  + 19,
		y = _H/2 + _H/4 + 21, 
		height = _W/15,
		width = _W/15 ,
		onRelease = buttonOnRelease
	}	

	local function animate(event)
		level1.rotation = level1.rotation + 3
	end
	Runtime:addEventListener("enterFrame",animate);

	
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
--	level1.self = "self";
	
	-- function enterFrame( e )

	-- 	for i,v in ipairs( e.target.self ) do
	-- 		v.rotation = v.rotation + v.dr
	-- 	end
	-- end

	-- Runtime:addEventListener( "enterFrame", level1 )

		
	group:insert( bg )
	group:insert( level1 )
	group:insert( back )
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene