local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")

local energy = {}
local numberOfEnergy = 3

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "mapG", "fade", 200 )
		elseif button == "nextB" then
			storyboard.gotoScene( "level1question1G", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	-- local background = display.newImage("images/bg.png");
	-- background.height = _H; background.width = _W + _W/4;
	-- background.x = _W/2; background.y = _H/2;
	
	
	local candy = display.newImage("images/candy.png")
	candy.x = _W - 20; candy.y = _H/15
	candy.width = 80; candy.height = 25

	local scoreText = score.init({
		   	fontSize = 18,
		   	font = "Helvetica",
		   	x = _W - 5,
		   	y =  _H/15,
		   	maxDigits = 3,
		   	leadingZeros = false,
		   	filename = "scorefile.txt",
		})
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
		x = _W - _W/30,
		y = _H - _H/10,
		height =  _H/9 + 17,
		width = _W/9 + 18 ,
		onRelease = buttonOnRelease
	}	
	
	
	
	local sheetOptions =
	{
	    width = 576,
	    height = 320,
	    numFrames = 9
	}

	local sheet1 = graphics.newImageSheet( "images/level1/imgsheet1.png", sheetOptions )
	
	local sequence= {
    {
        name = "normalRun",
        start = 1,
        count = 9,
        time = 20000,
        loopCount = 1,
        loopDirection = "forward"
    }
	}
	
	local animation = display.newSprite( sheet1, sequence)
		animation.x = _W/2; animation.y = _H/2
		animation:play()
		group:insert(animation)

		for i=1,numberOfEnergy do
			energy[i] = display.newImage("images/energy.png")
			energy[i].x = _W/90 + (30*i) -_W/9; energy[i].y = _H/15
			energy[i].width = 26; energy[i].height = 25
			group:insert(energy[i])
		end

local function spriteListener( event )

    local thisSprite = event.target  -- "event.target" references the sprite

    
    if ( thisSprite.frame == 2) then
    	sequence.time = 5000
    	audio.play( sfx.level1s1, { loops = 0, channel = 1,
    							onComplete = function() 
                                    audio.dispose( sfx.level1s1 ) 
                                end } )
    elseif (thisSprite.frame==8) then	thisSprite:setFrame(9)
    elseif ( thisSprite.frame == 9) then
    	thisSprite:setFrame(8)
    	audio.play( sfx.level1s3, { loops = 0, channel = 1,
    							onComplete = function() 
                                    audio.dispose( sfx.level1s3 ) 
                                end } )
    	timer.performWithDelay(5000,function(e)
			storyboard.gotoScene("level1question1G","fade",200)
		end,1)
    end

  
end


animation:addEventListener( "sprite", spriteListener )
group:insert( nextB )
group:insert( back )
-- group:insert( energy )
group:insert(candy)
group:insert(scoreText)

		
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene