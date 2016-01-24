--Are you being teased?
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")

local energy = {}
local numberOfEnergy = 5

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "mapG", "fade", 200  )
		elseif button == "choice1" then
			 storyboard.gotoScene( "level1scene6G", "fade", 200 )
		elseif button == "choice2" then
			-- storyboard.gotoScene( "level1scene3G", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;
--	transition.to( background, {alpha=0,time=3000, delay=2000 } )
	group:insert(background)
		-- group:insert( back )
	
	local textQuest =  display.newText( "What will you say?", 270, 10, native.systemFontBold, 24 )
		textQuest.x = _W/2
		textQuest.y = _H/5
		textQuest:setFillColor( 1,1,1 )
	-- timer.performWithDelay(19000, scene9)


	-- local choice1 = display.newImage("images/level1/scene9_2.jpg")
	-- choice1.height = _H/4; choice1.width =  _W/4;
	-- choice1.x = _W/4; choice1.y = _H/4;
	-- choice1.customProperty = 100;
	local candy = display.newImage("images/candy.png")
	candy.x = _W - 20; candy.y = _H/15
	candy.width = 80; candy.height = 25

	local scoreText = display.newText(score.get(), 270, 10, "Helvetica", 18 )
	scoreText.x = _W - 5; scoreText.y = _H/15
	scoreText:setFillColor( 1,0,0 )
		
		
	
	local function txt()
		local animation1 = transition.to(textQuest,{
			time=1000, y = _H/2, xScale=2, yScale=2,
			transition=easing.inQuad,customProperty=1000})
		transition.to(textQuest,{transition=easing.inQuad,
			xScale=1, yScale=1, y=_H/10,
			time=500, delay=2000})
					
		-- local animation2 = transition.to(choice1,{
		-- 	time=5000, y = 20, xScale=2, yScale=2,
		-- 	transition=easing.inQuad,customProperty=1000,onComplete=after})

		-- local animation2 = transition.to(textQuest,{
		-- 	time=5000, y = 50, xScale=2, yScale=2,
		-- 	transition=easing.inQuad,customProperty=1000})
	end
	txt()

	local function choice1fn()
		
		local choice1 = widget.newButton
		{
			defaultFile = "images/level1/scene24.jpg",			
			overFile ="images/level1/scene24.jpg",
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
			x=_W/4 , y = _H/2 , 
			xScale=1, yScale=1,
			transition=easing.inQuad})	
			
		local tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation)
			animation = nil
			-- timer.cancel(tmr2)
			tmr = nil
		end,1);
		
		group:insert(choice1)
	
	end
	timer.performWithDelay(3000,choice1fn,1)

	local function choice2fn()
		local choice2 = widget.newButton
		{
			defaultFile = "images/level1/scene25.jpg",			
			overFile ="images/level1/scene25.jpg",
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
			x=_W - _W/4, y = _H/2, 
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
	timer.performWithDelay(10000,function(e)
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
		group:insert(back)	
	end,1)

	
	-- group:insert( back )
	group:insert(textQuest)
	group:insert(candy)
	group:insert(scoreText)
	for i=1,numberOfEnergy do
		energy[i] = display.newImage("images/energy.png")
		energy[i].x = _W/90 + (20*i) -_W/15; energy[i].y = _H/15
		energy[i].width = 20; energy[i].height = 25
		group:insert(energy[i])
	end
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene