local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")

local back, boy, girl

function scene:createScene( event )
	local group = self.view
	local choose = display.newImage("images/choose.png");
		choose.height = _H; choose.width = _W + _W/4;
		choose.x = _W/2; choose.y = _H/2;
		
	back = widget.newButton
	{
		defaultFile = "images/back.png",
		overFile ="images/back.png",
		x = _W/30,
		y = _H/10,
		height =  _H/9 + 17,
		width = _W/9 + 18 ,
		onRelease = function()
			storyboard.gotoScene( "menu", "fade", 200 )
		end
	}	

	boy = widget.newButton
	{
		defaultFile = "images/boy.png",
		overFile ="images/boy.png",
		x = _W/2 - 130 ,
		y = _H/2 + 30,
		height =  240,
		width = 230 ,
		onRelease = function()
			storyboard.gotoScene( "mapB", "fade", 200 )
		end
	}	
	
	girl = widget.newButton
	{
		defaultFile = "images/girl.png",
		overFile ="images/girl.png",
		x = _W/2 + 140 ,
		y = _H/2 + 30,
		height =  240,
		width = 230 ,
		onRelease = function()
			storyboard.gotoScene( "mapG", "fade", 500 )
		end
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