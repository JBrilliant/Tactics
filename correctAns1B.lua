local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local widget = require("widget")

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "scene1B", "fade", 200 )
		elseif button == "nexts" then
			--storyboard.gotoScene( "scene2B", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	
	local background = display.newImage("bgcorrect.jpg");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;
	
	local back = widget.newButton
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

	local nexts = widget.newButton
	{
		defaultFile = "next.png",
		overFile ="next.png",
		id = "nexts",
		x = _W + _W/40,
		y = _H/10,
		height =  _H/9 + 17,
		width = _W/9 + 18 ,
		onRelease = buttonOnRelease
	}	

	local correct = display.newImage("correct.png");
	correct.x = _W/2 + 10 ; correct.y = _H/3 + _H/5;
	correct.width = _W/2 + _W/3 + _W/10; correct.height = _H/2 +_H/3 + _H/6;

    
	--boy.scene = "mapB"
	local anim;

	anim = transition.to( correct,{
		time = 2000,
		y= 50,
		xScale = 2,
		yScale = 2,
		transition = easing.inQuad,
		customProperty = 1000
	});


	local tmr;
	tmr = timer.performWithDelay(500, function(e)
		transition.cancel(anim);
		anim = nil;

		timer.cancel(tmr);
		tmr = nil;
	end,1); 

	
	
	group:insert( background )
	group:insert( correct )
	group:insert( back )
	group:insert( nexts )
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene