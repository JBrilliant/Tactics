 --Tell your parents
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
loadsave.printTable(gameSettings.levels[curLvl].energy)
local tmr, t;

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			timer.cancel(tmr) 
			storyboard.removeAll(); storyboard.gotoScene( "mapG", "fade", 200 ); --storyboard.gotoScene( "level1question1G", "fade", 200 ); 
		elseif button == "nextB" then
			storyboard.removeScene( "level1scene3G", false )
			if curLvl == 1 then storyboard.gotoScene( "level1question3G", "fade", 200 )
			elseif curLvl == 2 then storyboard.gotoScene( "level1question5G", "fade", 200 ) end
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local back = widget.newButton{ defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10,height =  _H/9 + 17, width = _W/9 + 18 ,onRelease = buttonOnRelease }
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15; candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )	
	local scenario
	if curLvl == 1 then
		scenario = display.newImage("images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene23.jpg")
	elseif curLvl == 2 then
		scenario = display.newImage("images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene4.jpg")
	elseif curLvl == 3 then
		scenario = display.newImage("images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene1a.jpg")
	elseif curLvl == 4 then
		scenario = display.newImage("images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene3.jpg")
	end
	scenario.height = _H; scenario.width = _W + _W/4; scenario.x = _W/2; scenario.y = _H/2;
	
	audio.play( sfx.level1s3, { loops = 0, channel = 3,
    							onComplete = function() 
                                    audio.dispose( sfx.level1s3 ) 
                                end } )


-- if curLvl == 1 then t = 11000 elseif curLvl == 2 then t = 4000  end
tmr = timer.performWithDelay(8000,function(e)
	if curLvl == 1 or curLvl == 4 then storyboard.gotoScene( "level1question3G", "fade", 200);  --timer.cancel(tmr); --tmr = nil--
	elseif curLvl == 2 then storyboard.gotoScene( "level1question5G", "fade", 200); 
	elseif curLvl == 3 then storyboard.gotoScene( "levelpassedG", "fade", 200); 
	end
end,1)
--animation:addEventListener( "sprite", spriteListener )
group:insert(background)
group:insert(scenario)
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