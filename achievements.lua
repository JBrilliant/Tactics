local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require("widget")

--gameState.soundOn = nil

local bg, achievements, back

local function buttonOnRelease( event )
	local button = event.target.id
		if button == "achievements" then
			storyboard.gotoScene( "achievements", "fade", 200 )
				elseif button == "back" then
					storyboard.gotoScene( "menu", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	bg = display.newImage("images/settings_bg.png");
		bg.height = _H; bg.width = _W + _W/4;
		bg.x = _W/2; bg.y = _H/2;

	back = widget.newButton
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

	achievements = widget.newButton
	{
	defaultFile = "images/inside_achievements.png",
	overFile = "images/inside_achievements.png",
	id = "achievements",
	x = _W/2,
	y = _H/2 + _H/8,
	height = _H/3,
	width = _W/2 + _W/6,
	onRelease = buttonOnRelease
}

	group:insert( bg )
	group:insert( back )
	group:insert( achievements )
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	-- widgets must be manually removed, such as life
	if back and achievements then
		back:removeSelf()
		achievements:removeSelf()
		back = nil 
		achievements = nil 
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene