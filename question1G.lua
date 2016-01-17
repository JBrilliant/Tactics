local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( storyboard.getPrevious() )
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


	local choice1 = display.newImage("images/level1/scene9_1.jpg")
	choice1.height = _H/4; choice1.width =  _W/4;
	choice1.x = _W/4; choice1.y = _H/4;
	choice1.customProperty = 100;

	local animation = transition.to(choice1,{
		time=5000, y = 50, xScale=2, yScale=2,
		transition=easing.inQuad,customProperty=1000})

	local tmr = timer.performWithDelay(3000,function(e){})
		transition.cancel(animation)
		animation = nil
		timer.cancel(tmr)
		tmr = nil
	

	group:insert(textQuest)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene