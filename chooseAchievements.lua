local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")

local back, achievements

function scene:createScene( event )
	local group = self.view

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

	achievements = widget.newButton
	{
		defaultFile = "images/inside_achievements.png",
		overFile = "images/inside_achievements.png",
		x = _W/2,
		y = _H/2 + _H/8,
		height = _H/3,
		width = _W/2 + _W/6,
		onRelease = buttonOnRelease
		end
	}

	group.insert(back)
	group.insert(achievements)
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene