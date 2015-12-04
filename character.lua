local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local widget = require("widget")

local back, boy, girl

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "menu", "fade", 200 )
		elseif button == "boy" then
			storyboard.gotoScene( "mapB", "fade", 200 )
		elseif button == "girl" then
			--storyboard.gotoScene( "mapG", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view
	local choose = display.newImage("choose.png");
		choose.height = _H; choose.width = _W + _W/4;
		choose.x = _W/2; choose.y = _H/2;
		
	back = widget.newButton
	{
		defaultFile = "back.png",
		overFile ="back.png",
		id = "back", 
		x = _W/30,
		y = _H/10,
		height =  _H/9 + 17,
		width = _W/9 + 18 ,
		onRelease = buttonOnRelease
	}	

	boy = widget.newButton
	{
		defaultFile = "boy.png",
		overFile ="boy.png",
		id = "boy",
		x = _W/2 - 130 ,
		y = _H/2 + 30,
		height =  240,
		width = 230 ,
		onRelease = buttonOnRelease
	}	
	
	girl = widget.newButton
	{
		defaultFile = "girl.png",
		overFile ="girl.png",
		id = "girl",
		x = _W/2 + 140 ,
		y = _H/2 + 30,
		height =  240,
		width = 230 ,
		onRelease = buttonOnRelease
	}	
		
	group:insert( choose )
	group:insert( back )
	group:insert( boy )
	group:insert( girl )
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene