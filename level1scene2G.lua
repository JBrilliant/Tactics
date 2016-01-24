--1A. Nothing. They will stop soon.
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "mapG", "fade", 200 )
		elseif button == "nextB" then
			storyboard.gotoScene( "level1question2G", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;

	for i=1,5 do
		local energy = display.newImage("images/energy.png")
		energy.x = _W/90 + (20*i) -_W/15; energy.y = _H/15
		energy.width = 20; energy.height = 25
		group:insert(energy)
	end

	local candy = display.newImage("images/candy.png")
	candy.x = _W - 20; candy.y = _H/15
	candy.width = 80; candy.height = 25

	-- local scoreText =  score.init({
	-- 	   	fontSize = 18,
	-- 	   	font = "Helvetica",
	-- 	   	x = _W - 5,
	-- 	   	y =  _H/15,
	-- 	   	maxDigits = 3,
	-- 	   	leadingZeros = true,
	-- 	   	filename = "scorefile.txt",
		--})
	local scoreText = display.newText(score.get(), 270, 10, "Helvetica", 18 )
	scoreText.x = _W - 5; scoreText.y = _H/15
	scoreText:setFillColor( 1,0,0 )
	
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
	

	local nextB = widget.newButton
	{
		defaultFile = "images/next2.png",			
		overFile ="images/next2.png",
		id = "nextB",
		x = _W -_W/30,
		y = _H - _H/10,
		height =  _H/9 + 17,
		width = _W/9 + 18 ,
		onRelease = buttonOnRelease
	}	
	
	local sheetOptions =
	{
	    width = 576,
	    height = 320,
	    numFrames = 12
	}

	local sheet1 = graphics.newImageSheet( "images/level1/imgsheet1.png", sheetOptions )
	
	local sequence= {
    {
        name = "normalRun",
        start = 10,
        count = 3,
        time = 9000,
        loopCount = 1,
        loopDirection = "forward"
    }
	}
	
	local animation = display.newSprite( sheet1, sequence)
		animation.x = _W/2; animation.y = _H/2 
		animation:play()
	
	timer.performWithDelay(8000,function(e)
			storyboard.gotoScene("level1question2G","fade",200)
		end,1)	

local function spriteListener( event )

    local thisSprite = event.target  -- "event.target" references the sprite

    
    if ( thisSprite.frame == 11) then
    	
    end

  
end


animation:addEventListener( "sprite", spriteListener )
group:insert(background)
group:insert(animation)
group:insert( nextB )
group:insert( back )
-- group:insert( energy )
group:insert( candy )
group:insert( scoreText )


		
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene