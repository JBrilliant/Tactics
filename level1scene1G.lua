local loadsave = require("loadsave")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")
local sceneClass = require("sceneClass")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local energy = {}
local curLvl = gameSettings.currentLevel; local numberOfEnergy = gameSettings.levels[curLvl].energy; 
loadsave.printTable(gameSettings.levels[curLvl].energy)
--local tmr
-- local function tmr()
-- 	local tmr = timer.performWithDelay(4500,function(e)
-- 			storyboard.gotoScene( "level1question1G", "fade", 200);  --timer.cancel(tmr); tmr = nil--
-- 		end,1)
-- 	return tmr
-- end

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.purgeScene( storyboard.getCurrentSceneName(), false ); audio.stop( 2 ); audio.resume(1)
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
					 { name = "level2", start = 1, count = 9, time = 17500, loopCount = 1, loopDirection = "forward" }}	
	local animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2
		animation:play()

local function spriteListener( event )
    local thisSprite = event.target  -- "event.target" references the sprite    
    if ( thisSprite.frame == 2) then
    	audio.play( sfx.level1s1, { loops = 0, channel = 2,
    							onComplete = function() 
                                    audio.dispose( sfx.level1s1 ) 
                                end } )
  	elseif ( thisSprite.frame == 9) then
  	  	 timer.performWithDelay(4500,function(e)
			storyboard.gotoScene( "level1question1G", "fade", 200);  --timer.cancel(tmr); --tmr = nil--
		end,1)
    end
end


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
	--timer.cancel(tmr)
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene