--1A. Nothing. They will stop soon.
local loadsave = require("loadsave")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local energy = {}
local curLvl = gameSettings.currentLevel; local numberOfEnergy = gameSettings.levels[curLvl].energy; 
loadsave.printTable(gameSettings.levels[curLvl].energy)
gameSettings.levels[curLvl].score = score.get()
local tmr, t;
local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			timer.cancel(tmr) 
			storyboard.removeAll();storyboard.gotoScene("mapG", "fade", 200 )
		elseif button == "nextB" then
			storyboard.purgeScene( storyboard.getCurrentSceneName(), false )
			if curLvl == 1 then storyboard.gotoScene( "level1question2G", "fade", 200 ) 
			elseif curLvl == 2 then storyboard.gotoScene( "level1question3G", "fade", 200 ) end
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local back = widget.newButton{ defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10,height =  _H/9 + 17, width = _W/9 + 18 ,onRelease = buttonOnRelease }
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15; candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )	
	local scenario, sheetOptions, sheet1, sequence, animation
	if curLvl == 4 and gameSettings.character == "girl" then
		scenario = display.newImage("images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene4.jpg")
		scenario.height = _H; scenario.width = _W + _W/4; scenario.x = _W/2; scenario.y = _H/2;
		group:insert(scenario)
	else
		sheetOptions = { width = 576, height = 320, numFrames = 12}
		sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/imgsheet2.png", sheetOptions )
		sequence= { {name = "level1", start = 10,count = 3, time = 11000, loopCount = 1, loopDirection = "forward" },
							{name = "level2", start = 7,count = 2, time = 4000, loopCount = 1, loopDirection = "forward" },
							{name = "level3", start = 1,count = 4, time = 8000, loopCount = 1, loopDirection = "forward" },
							{name = "level4", start = 3,count = 2, time = 6000, loopCount = 1, loopDirection = "forward" }   }
		animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2 
		animation:setSequence("level"..tostring(curLvl)); animation:play()
		-- if (curLvl == 2) then  animation:setSequence("level2")  elseif (curLvl == 3) then  animation:setSequence("level3")  end
	end

local function spriteListener( event )
    local thisSprite = event.target  -- "event.target" references the sprite  
    if ( thisSprite.frame == 1) then
    	-- audio.play( sfx.level1s2, { loops = 0, channel = 3,
    	-- 						onComplete = function() 
     --                                audio.dispose( sfx.level1s2 ) 
     --                            end } )
    end
end

if curLvl == 1 then t = 11000 elseif curLvl == 2 then t = 4000 elseif curLvl == 3 then t = 8000 elseif curLvl == 4 then t = 6000  end
tmr = timer.performWithDelay(t,function(e)
	if curLvl == 1 then storyboard.gotoScene( "level1question2G", "fade", 200);  --timer.cancel(tmr); --tmr = nil--
	elseif curLvl == 2 then storyboard.gotoScene( "level1question3G", "fade", 200); 
	elseif curLvl == 3 then storyboard.gotoScene( "level1question7G", "fade", 200); 
	elseif curLvl == 4 then storyboard.gotoScene( "level1question2G", "fade", 200); 
	end
end,1)

animation:addEventListener( "sprite", spriteListener )
group:insert(background)
group:insert(animation)
group:insert( back )
group:insert( candy )
group:insert( scoreText )

for i=1,numberOfEnergy do
	energy[i] = display.newImage("images/english/"..gameSettings.character.."/energy.png"); energy[i].x = _W/90 + (30*i) -_W/9; energy[i].y = _H/15; energy[i].width = 26; energy[i].height = 25
	group:insert(energy[i])
end

		
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view
	if back and nextB  then
		back:removeSelf()
		nextB:removeSelf()
		back = nil 
		nextB = nil 
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene