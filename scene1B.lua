local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local widget = require("widget")

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "character", "fade", 200 )
		elseif button == "choice1" then
			storyboard.gotoScene( "wrongAns1B", "fade", 200 )
		elseif button == "choice2" then
			storyboard.gotoScene( "wrongAns1B", "fade", 200 )
		elseif button == "choice3" then
			storyboard.gotoScene( "correctAns1B", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/scbg.jpg");
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

	local boy = display.newImage("images/boy_normal.png");
	boy.x = _W/2 - 210 ; boy.y = _H/2 + 30;
	boy.width = 230; boy.height = 240;
	
	local scenario = display.newImage("images/sc1.png");
	scenario.x = _W/3 +  _W/3 - 20; scenario.y = _H/3 + _H/5;
	scenario.width = _W/2 + _W/3 + _W/10; scenario.height = _H/2 +_H/3 + _H/6;
	
    local choice1 = widget.newButton
	{
		defaultFile = "images/sc1c1.png",
		overFile ="images/sc1c1.png",
		id = "choice1",
		x = _W/3  + _W/3 - 20,
		y = _H/2 + 20,
		height =   _H/19,
		width = _W/2 +_W/3 -10 ,
		onRelease = buttonOnRelease
	}	

	local choice2 = widget.newButton
	{
		defaultFile = "images/sc1c2.png",
		overFile ="images/sc1c2.png",
		id = "choice2",
		x = _W/3 + _W/3 - 20,
		y =  _H/2 + 60,
		height =   _H/19,
		width =_W/2 +_W/5 ,
		onRelease = buttonOnRelease
	}	

	
	local choice3 = widget.newButton
	{
		defaultFile = "images/sc1c3.png",
		overFile ="images/sc1c3.png",
		id = "choice3",
		x = _W/3 + _W/3 - 20,
		y =  _H/2 + 100,
		height =   _H/19,
		width =_W/2 +_W/3,
		onRelease = buttonOnRelease
	}	
	--boy.scene = "mapB"
	local anim;

	anim = transition.to( scenario,{
		time = 5000,
		y= 50,
		xScale = 2,
		yScale = 2,
		transition = easing.inQuad,
		customProperty = 1000
	});


	local tmr;
	tmr = timer.performWithDelay(1000, function(e)
		transition.cancel(anim);
		anim = nil;

		timer.cancel(tmr);
		tmr = nil;
	end,1); 

	
	group:insert( background )
	group:insert( back )
	group:insert( boy )
	group:insert( scenario )
	group:insert( choice1 )
	group:insert( choice2 )
	group:insert( choice3 )
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene