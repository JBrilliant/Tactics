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

	local background = display.newImage("images/bgwrong.jpg");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;
	
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

	local nexts = widget.newButton
	{
		defaultFile = "images/next.png",
		overFile ="images/next.png",
		id = "nexts",
		x = _W + _W/40,
		y = _H/10,
		height =  _H/9 + 17,
		width = _W/9 + 18 ,
		onRelease = buttonOnRelease
	}	


	local wrong = display.newImage("images/wrong1.png");
	wrong.x = _W/2 + 10 ; wrong.y = _H/3 + _H/5;
	wrong.width = _W/2 + _W/3 + _W/10; wrong.height = _H/2 +_H/3 + _H/6;

    
	--boy.scene = "mapB"
	local anim;

	anim = transition.to( wrong,{
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
	group:insert( wrong )
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