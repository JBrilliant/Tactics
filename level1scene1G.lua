local loadsave = require("loadsave")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")
local sceneClass = require("sceneClass")
local gamestate = require( "gamestate" )

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
loadsave.printTable(gameSettings);
local energy = {}
local curLvl = gameSettings.currentLevel; local numberOfEnergy = gameSettings.levels[curLvl].energy; 
  print("LEVEL "..gameSettings.currentLevel.." NA! scene1G")
local tmr, t;


local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			timer.cancel(tmr) 
			storyboard.purgeScene(storyboard.getCurrentSceneName(), false); audio.stop( 2 ); audio.resume(1)
			storyboard.gotoScene( "mapG", "fade", 200 );-- timer.cancel(tmr()); --tmr = nil
		elseif button == "nextB" then
			storyboard.purgeScene( storyboard.getCurrentSceneName(), false )
			storyboard.gotoScene( "level1question1G", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15;candy.width = 80; candy.height = 25	
	local scoreText = score.init({ fontSize = 18, font = "riffic", x = _W - 5, y =  _H/15, maxDigits = 3, leadingZeros = false,	filename = "scorefile.txt"}); scoreText:setFillColor( 1,0,0 )
	score.set(0); score.save(); gameSettings.levels[curLvl] = score.get()

	local sheetOptions = { width = 576, height = 320, numFrames = 12 }
	local sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/imgsheet2.png", sheetOptions)	
	local sequence= { { name = "level1", start = 1, count = 9, time = 17500, loopCount = 1, loopDirection = "forward" },
					 { name = "level2", start = 1, count = 6, time = 16000, loopCount = 1, loopDirection = "forward" },
					 { name = "level3", start = 1, count = 2, time = 6000, loopCount = 1, loopDirection = "forward" },
					 { name = "level4", start = 1, count = 2, time = 8000, loopCount = 1, loopDirection = "forward" },
					 { name = "level4G", start = 1, count = 4, time = 8000, loopCount = 1, loopDirection = "forward" }}	
	local animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2; 
	animation:setSequence("level"..tostring(curLvl));	
	if curLvl == 4 and gameSettings.character == "girl" then  animation:setSequence("level4G")  end
	-- elseif (curLvl == 3) then  animation:setSequence("level3") end
		animation:play()

local function spriteListener( event )
    local thisSprite = event.target  -- "event.target" references the sprite    
    if ( thisSprite.frame == 2) then
    	audio.play( sfx.level1s1, { loops = 0, channel = 2,  onComplete = function() audio.dispose( sfx.level1s1 )  end } )
 --  	elseif (curLvl == 1 and  thisSprite.frame == 9) or (curLvl == 2 and  thisSprite.frame == 6) then
    end
end

if curLvl == 1 then t = 17500 elseif curLvl == 2 then t = 1600 elseif curLvl == 3 then t = 6000 elseif curLvl == 4 then t = 8000  end
tmr = timer.performWithDelay(t,function(e)
	if curLvl == 1 or curLvl == 3 then 
		print("curLvl ==3!!!!"); storyboard.gotoScene( "level1question1G", "fade", 200)
	elseif curLvl == 2 then storyboard.gotoScene( "level1question2G", "fade", 200) 
	elseif curLvl == 4 then storyboard.gotoScene( "level1question6G", "fade", 200) 
	end
end,1)

animation:addEventListener( "sprite", spriteListener )
group:insert(animation)
group:insert( back )
group:insert(candy)
group:insert(scoreText)
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
	  -- timer.cancel(tmr)
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene