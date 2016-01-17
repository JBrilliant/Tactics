local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "character", "fade", 200 )
		elseif button == "nextB" then
		-- 	media.playVideo("level1.mp4", true)
			storyboard.gotoScene( "question1G", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

-- 	local background = display.newImage("images/bg.png");
-- 	background.height = _H; background.width = _W + _W/4;
-- 	background.x = _W/2; background.y = _H/2;
-- --	transition.to( background, {alpha=0,time=3000, delay=2000 } )
-- 	group:insert(background)

-- 	-- media.playVideo("level1.mp4", true)
	

	local nextB = widget.newButton
	{
		defaultFile = "images/next.png",			
		overFile ="images/next.png",
		id = "nextB",
		x = _W - 30,
		y = _H/10,
		height =  _H/9 + 17,
		width = _W/9 + 18 ,
		onRelease = buttonOnRelease
	}	
	group:insert( nextB )
	
	local function scene1()
		scene = display.newImage("images/level1/scene01.jpg",200,60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		-- group:insert( scene )
		transition.to( scene, {alpha=0,time=7000, delay=2000 } )
		-- transition.to( scene, {alpha=1.0,time=7000, delay=2000 } )	
	end
	
	scene1();
	-- display.remove(scene)
	-- timer.performWithDelay(1000, scene1)

	local function scene2()
		audio.play( sfx.level1s1, { loops = 0, channel = 1,
    							onComplete = function() 
                                    audio.dispose( sfx.level1s1 ) 
                                end } )
		scene = display.newImage("images/level1/scene02.jpg",200,60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		group:insert( scene )
		transition.to( scene, {alpha=0,time=4000, delay=2000 } )		
		-- scene:translate(100,100)
		-- scene:removeSelf()
		-- scene = nil
	end
	-- scene2();
	-- timer.performWithDelay(3000, scene2)
	
	local function scene3()
		scene = display.newImage("images/level1/scene03.jpg",200,60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		group:insert( scene )
		transition.to( scene, {alpha=0,time=3000, delay=2000 } )
	end
	-- timer.performWithDelay(5000, scene3)
	-- display.remove(scene)

	local function scene4()
		scene = display.newImage("images/level1/scene04.jpg",200,60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		group:insert( scene )
		transition.to( scene, {alpha=0,time=3000, delay=2000 } )
	end
	-- timer.performWithDelay(6000, scene4)
	-- display.remove(scene)

	local function scene5()
		scene = display.newImage("images/level1/scene05.jpg",200,60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		group:insert( scene )
		transition.to( scene, {alpha=0,time=3000, delay=1000 } )
	end
	-- timer.performWithDelay(7000, scene5)
	-- display.remove(scene)

	local function scene6()
		scene = display.newImage("images/level1/scene06.jpg",200,60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		group:insert( scene )
		transition.to( scene, {alpha=0,time=6000, delay=3000 } )
	end
	-- timer.performWithDelay(8000, scene6)
	-- display.remove(scene)
	
	-- timer.performWithDelay(10000, scene9)
	
	local function scene7()
		scene = display.newImage("images/level1/scene07.jpg",200,60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		group:insert( scene )
		transition.to( scene, {alpha=0,time=5000, delay=3000 } )
	end
	-- timer.performWithDelay(11000, scene7)
	-- display.remove(scene)

	local function scene8()
		audio.play( sfx.level1s2, { loops = 0, channel = 2,
    							onComplete = function() 
                                    audio.dispose( sfx.level1s2 ) 
                                end } )
		scene = display.newImage("images/level1/scene08.jpg",200,60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		group:insert( scene )
		transition.to( scene, {alpha=0,time=4000, delay=3000 } )
	end
	-- timer.performWithDelay(15000, scene8)
	-- display.remove(scene)

	-- scene9()
	local function scene9()
		audio.play( sfx.level1s3, { loops = 0, channel = 3,
    							onComplete = function() 
                                    audio.dispose( sfx.level1s3 ) 
                                end } )
		scene = display.newImage("images/level1/scene09.jpg",200,60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		group:insert( scene )
		transition.to( scene, {alpha=0,  time=3000, delay=3000 } )
		-- display.remove(scene)
	end-- scene9();	
	-- timer.performWithDelay(18000, scene9)

	-- local textQuest =  display.newText( "What will you do?", 270, 10, native.systemFontBold, 24 )
	-- 	textQuest.x = _W/2
	-- 	textQuest.y = _H/4
	-- 	textQuest:setFillColor( 1,1,1 )
	
	
	-- group:insert(textQuest)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene