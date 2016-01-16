local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local widget = require("widget")

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "character", "fade", 200 )
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
	
	-- media.playVideo("level1.mp4", true)
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
	
-- 	local sceneArray = {"images/level1/scene01.jpg", "images/level1/scene02.jpg",
-- "images/level1/scene03.jpg","images/level1/scene04.jpg",
-- "images/level1/scene05.jpg","images/level1/scene06.jpg",
-- "images/level1/scene07.jpg","images/level1/scene08.jpg",
-- "images/level1/scene09.jpg"} 
	
-- 	for i=1, 8	 do
-- 		print(i)
-- 		scene = display.newImage(sceneArray[i], 200, 60)
-- 		scene.height = _H; scene.width = _W + _W/4;
-- 		scene.x = _W/2; scene.y = _H/2;
-- 		-- scene.alpha = 8
-- 		transition.to( scene, {alpha=0,delay=1000,time=3000,onComplete=after } )
-- 		-- timer.performWithDelay(3000,  10 )
-- 	end
	
	local function scene1()
		scene = display.newImage("images/level1/scene01.jpg", 200, 60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		transition.to( scene, {alpha=0,time=3000, delay=2000 } )
	end
	
	local function scene2()
		scene = display.newImage("images/level1/scene02.jpg", 200, 60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		transition.to( scene, {alpha=0,time=3000 } )
	end

	local function scene3()
		scene = display.newImage("images/level1/scene03.jpg", 200, 60)
		scene.height = _H; scene.width = _W + _W/4;
		scene.x = _W/2; scene.y = _H/2;
		-- scene.alpha = 8
		transition.to( scene, {alpha=0,time=3000 } )
	end

	-- trans = {scene1, scene2, scene3}
	-- for i=1, 3 do
	-- 	trans[i]()
	-- 	timer.performWithDelay(3000, trans[i](), 10)
	-- end
	scene1(); timer.performWithDelay(3000)
	-- scene2(); timer.performWithDelay(3000)
	-- scene3(); timer.performWithDelay(3000)
		-- count = 0

	-- local function repeatFade (event)
	
	-- frame2.alpha = 1
	-- 	transition.to( frame2, { alpha=0, time=3000 } )
	-- 	-- end

	-- Fade out rectangle every second 20x using transition.to()       
	
	group:insert( background )	
	--group:insert( sceneArray )
	-- group:insert( frame2 )
	group:insert( back )
	-- frame1:removeSelf()
	-- group:insert( video )
	-- group:insert( scenario )
	-- group:insert( choice1 )
	-- group:insert( choice2 )
	-- group:insert( choice3 )
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene