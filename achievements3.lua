local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require("widget")


-- gameState.soundOn = nil

local achieve, back

local function buttonOnRelease( event )
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "achievements2", "fade", 200 )
		elseif button == "nextB" then
			storyboard.gotoScene( "achievements4", "fade", 200 )
		end
--gameState.soundOn = nilend
end
function scene:createScene( event )
	local group = self.view

	
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

	achieve = display.newImage("images/inside_achievements2.png");
		achieve.height = _H; achieve.width = _W + _W/4;
		achieve.x = _W/2; achieve.y = _H/2;

	nextB = widget.newButton
	{
		defaultFile = "images/next2.png",			
		overFile ="images/next2.png",
		id = "nextB",
		x = _W - _W/30,
		y = _H - _H/10,
		height =  _H/9 + 17,
		width = _W/9 + 18 ,
		onRelease = buttonOnRelease
	}	



	-- group:insert( bg )
	group:insert( achieve )
	group:insert( back )
	group:insert( nextB )

end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	-- widgets must be manually removed, such as life
	if back and achievements and nextB then
		back:removeSelf()
		achievements:removeSelf()
		nextB:removeSelf()
		back = nil 
		achievements = nil
		nextB = nil 
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene