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

	local background = display.newImage("images/bg.png");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;
--	transition.to( background, {alpha=0,time=3000, delay=2000 } )
	
-- 	-- media.playVideo("level1.mp4", true)
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
	
	local sheetOptions =
	{
	    width = 512,
	    height = 256,
	    numFrames = 8
	}

	local sheet1 = graphics.newImageSheet( "images/level1/imgsheet1.png", sheetOptions )
	
	local sequence= {
    -- consecutive frames sequence
    {
        name = "normalRun",
        start = 1,
        count = 8,
        time = 20000,
        loopCount = 1,
        loopDirection = "forward"
    }
	}
	
	local animation = display.newSprite( sheet1, sequence)
		-- animation.height = _H-20; animation.width = _W ;
		animation.x = _W/2; animation.y = _H/2 +20
	
	local function animate( ... )
		animation:play()
		-- body
	end

local function spriteListener( event )

    local thisSprite = event.target  -- "event.target" references the sprite

    if ( event.phase == "ended" ) then 
    	timer.performWithDelay(3000, spriteListener) 
        storyboard.gotoScene( "question1G", "fade", 200 )
    end

    if ( event.phase == "next") then
    	audio.play( sfx.level1s1, { loops = 0, channel = 1,
    							onComplete = function() 
                                    audio.dispose( sfx.level1s1 ) 
                                end } )
    end
end

Runtime:addEventListener("enterFrame",animate);

-- add the event listener to the sprite
animation:addEventListener( "sprite", spriteListener )
group:insert(background)
group:insert(animation)
group:insert( nextB )
group:insert( back )

		
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene