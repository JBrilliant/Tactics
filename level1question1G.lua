local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( storyboard.getPrevious() )
		elseif button == "choice1" then
			storyboard.gotoScene( "level1scene2G", "fade", 200 )
		elseif button == "choice2" then
			storyboard.gotoScene( "level1scene3G", "fade", 200 )
		elseif button == "choice3" then
			storyboard.gotoScene( "level1scene4G", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;
	group:insert(background)
	
		
		
	local textQuest =  display.newText( "What will you do?", 270, 10, native.systemFontBold, 24 )
		textQuest.x = _W/2
		textQuest.y = _H/5
		textQuest:setFillColor( 1,1,1 )
	
	local function txt()
		local animation1 = transition.to(textQuest,{
			time=1000, y = _H/2, xScale=2, yScale=2,
			transition=easing.inQuad,customProperty=1000})
		transition.to(textQuest,{transition=easing.inQuad,
			xScale=1, yScale=1, y=_H/10,
			time=500, delay=2000})
	end
	txt()


	local function choice1fn()
		
		local choice1 = widget.newButton
		{
			defaultFile = "images/level1/scene9_2.jpg",			
			overFile ="images/level1/scene9_2.jpg",
			id = "choice1",
			x = _W/2 ,
			y = _H/2 ,
			height =   _H/4 + 30,
			width = _W/3 + 30,
			onRelease = buttonOnRelease
		}	

		local animation = transition.to(choice1,{
			time=2000, --delay=2000,
			x=_W/2 + 10, y = _W/2-100, xScale=9.5, yScale=9.5,
			transition=easing.inQuad,customProperty=1000,onComplete=after})

		transition.to(choice1,{time=1000,delay=4000,
			x=_W/4 , y = _H/3 , 
			xScale=1, yScale=1,
			transition=easing.inQuad})	
		-- transition.to(text, {alpha=1, time=2000, x = _W-10; y = _H - _H/5})	--text
			
		local tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation)
			animation = nil
			-- timer.cancel(tmr2)
			tmr = nil
		end,1);
		
		group:insert(choice1)
		
	end
	timer.performWithDelay(3000,choice1fn,1)
	timer.performWithDelay(8000,function(e)
		local text =  display.newText( "Nothing. They will stop soon.", 270, 10, native.systemFontBold, 10 )
			text.x = _W/4 ; text.y = _H/2 +10
			text:setFillColor( 0,0,0 )
			group:insert(text)
		end,1)
		
	local function choice2fn()
		
		local choice2 = widget.newButton
		{
			defaultFile = "images/level1/scene9_31.jpg",			
			overFile ="images/level1/scene9_31.jpg",
			id = "choice2",
			x = _W/2,
			y = _H/2 ,
			height =  _H/4 + 30,
			width = _W/3 + 30,
			onRelease = buttonOnRelease
		}

		local animation = transition.to(choice2,{
				time=2000, 
				x=_W/2 +10, y = _W/2-100, xScale=9.5, yScale=9.5,
				transition=easing.inQuad,customProperty=1000,onComplete=after})
		transition.to(choice2,{time=1000,delay=4000,
			x=_W - _W/4, y = _H/3, 
			xScale=1, yScale=1,
			transition=easing.inQuad})		

		local tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation)
			animation = nil
			-- timer.cancel(tmr2)
			tmr = nil
		end,1);

		group:insert(choice2)
		
	end
	timer.performWithDelay(10000,choice2fn,1)
	timer.performWithDelay(15000,function(e)
		local text =  display.newText( "Go to your parents.", 270, 10, native.systemFontBold, 10 )
			text.x = _W-_W/4 ; text.y = _H/2 +10
			text:setFillColor( 0,0,0 )
			group:insert(text)
			-- group:insert( back )
		end,1)
	
	local function choice3fn()
		local choice3 = widget.newButton
		{
			defaultFile = "images/level1/scene12.jpg",			
			overFile ="images/level1/scene12.jpg",
			id = "choice3",
			x = _W/2,
			y = _H/2 ,
			height =  _H/4 + 30,
			width = _W/3 + 30,
			onRelease = buttonOnRelease
		}

		local animation = transition.to(choice3,{
				time=2000, 
				x=_W/2 +10, y = _W/2-100, xScale=9.5, yScale=9.5,
				transition=easing.inQuad,customProperty=1000,onComplete=after})
		transition.to(choice3,{time=1000,delay=4000,
			x=_W/2 , y = _H/2 + 80 , 
			xScale=1, yScale=1,
			transition=easing.inQuad})		

		local tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation)
			animation = nil
			-- timer.cancel(tmr2)
			tmr = nil
		end,1);

		group:insert(choice3)
	
	end
	timer.performWithDelay(18000,choice3fn,1)
	timer.performWithDelay(23000,function(e)
		local text =  display.newText( "Tease her also.", 270, 10, native.systemFontBold, 10 )
			text.x = _W/2; text.y = _H - 15
			text:setFillColor( 0,0,0 )
			group:insert(text)
		local back = widget.newButton
		{
			defaultFile = "images/back2.png",			
			overFile ="images/back2.png",
			id = "back",
			x = _W/30,
			y = _H - _H/10,
			height =  _H/9 + 17,
			width = _W/9 + 18 ,
			onRelease = buttonOnRelease
			}
		group:insert( back )
		end,1)
	
	group:insert(textQuest)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene