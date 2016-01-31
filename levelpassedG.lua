 --Yes. Level 1 End. Win
local loadsave = require( "loadsave" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")
local energyM = require("energy")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local energy = {}
local numberOfEnergy = gameSettings.energy
loadsave.printTable(gameSettings.energy)

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			 storyboard.gotoScene( "mapG", "fade", 200 )
		elseif button == "nextB" then
			-- storyboard.gotoScene( "level1question2G", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;

	local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png",
		id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	
	local candy = display.newImage("images/candy.png")
	candy.x = _W - 20; candy.y = _H/15
	candy.width = 80; candy.height = 25

	local scoreText = display.newText(score.get(), 270, 10, "Helvetica", 18 )
	scoreText.x = _W - 5; scoreText.y = _H/15
	scoreText:setFillColor( 1,0,0 )
	
	local sheetOptions = { width = 576, height = 320, numFrames = 12 }

	local sheet1 = graphics.newImageSheet( "images/level1/imgsheet2.png", sheetOptions )
	
	local sequence= { { name = "normalRun",  start = 11, count = 2, time = 1000, loopDirection = "forward" } }
	
	local animation = display.newSprite( sheet1, sequence)
		animation.x = _W/2+10; animation.y = _H/2 
		animation:play()
	
	timer.performWithDelay(8000,function(e)
			-- storyboard.gotoScene("level1question2G","fade",200)
			--Level 1 passed!!!!!!!!
		end,1)	

local function spriteListener( event )

    local thisSprite = event.target  -- "event.target" references the sprite   
    if ( thisSprite.frame == 11) then    	
    end
 
end


animation:addEventListener( "sprite", spriteListener )
group:insert(background)
group:insert(animation)
group:insert( candy )
group:insert( scoreText )
group:insert( back )
for i=1,numberOfEnergy do
		energy[i] = display.newImage("images/energy.png")
			energy[i].x = _W/90 + (30*i) -_W/9; energy[i].y = _H/15
			energy[i].width = 26; energy[i].height = 25
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