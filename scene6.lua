local loadsave = require("loadsave")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")
local energyM = require("energy")
local gamestate = require( "gamestate" )

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local energy = {}
local curLvl = gameSettings.currentLevel; local numberOfEnergy = gameSettings.levels[curLvl].energy; 
loadsave.printTable(gameSettings.levels[curLvl].energy)
gameSettings.levels[curLvl].score = score.get()
loadsave.printTable(gameSettings.levels[curLvl].energy)
local tmr, t, duration
loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
print("level1scene6")


function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;group:insert(background)
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15; candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, _W - 5, _H/15, "riffic", 18 ); scoreText:setFillColor( 1,0,0 )	
	
	if gameSettings.lang == "english" then 		
		if curLvl == 1 then 
			audio.play( sfx.level1s6, { loops = 0, channel = 2, onComplete = audio.stop(2)} )
			duration = sfx.time1s6
		elseif curLvl == 5 then
	    	audio.play( sfx.level5s4, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 4) 
			duration = sfx.time5s4
		end
	elseif gameSettings.lang == "tagalog" then 
		if curLvl == 1 then 
			audio.play( sfx.level1s6t, { loops = 0, channel = 2, onComplete = audio.stop(2)} )
			duration = sfx.time1s6t
		elseif curLvl == 5 then
	    	audio.play( sfx.level5s4t, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 4) 
			duration = sfx.time5s4t
		end
	elseif gameSettings.lang == "bicol" then
		if curLvl == 1 then 
			audio.play( sfx.level1s6g, { loops = 0, channel = 2, onComplete = audio.stop(2)} )
			duration = sfx.time1s6g
		elseif curLvl == 5 then
	    	audio.play( sfx.level5s4g, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 4) 
			duration = sfx.time5s4g
		end 
	end

	local scenario, sheetOptions, sheet1, sequence, animation
	if curLvl == 5 then
		scenario = display.newImage("images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene5.jpg")
		scenario.height = _H; scenario.width = _W + _W/4; scenario.x = _W/2; scenario.y = _H/2;
		group:insert(scenario)
	else
		sheetOptions = { width = 576, height = 320, numFrames = 12 }
		sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/imgsheet1.png", sheetOptions )
		sequence= { { name = "level1", start = 9, count = 4, time = duration, loopCount = 1, loopDirection = "forward" } }	
		animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2 
		animation:setSequence("level"..tostring(curLvl))
		animation:play()					
		group:insert(animation)
	end
	
	
	-- if curLvl == 1 then t = 17000 elseif curLvl == 3 then t = 3000 elseif curLvl == 5 then t = 5000  end
	tmr = timer.performWithDelay(duration,function(e) storyboard.removeAll()
		if curLvl == 1 or curLvl == 5 then storyboard.gotoScene( "levelpassedG", "fade", 200);  
		end
	end,1)


group:insert( candy )
group:insert( scoreText )
for i=1,numberOfEnergy do
	energy[i] = display.newImage("images/english/"..gameSettings.character.."/energy.png"); energy[i].x = _W/90 + (30*i) -_W/9; energy[i].y = _H/15; energy[i].width = 26; energy[i].height = 25
		group:insert(energy[i])
end
		
end

function scene:destroyScene( event )
local group = self.view
	if back and nextB  then
		back:removeSelf()
		nextB:removeSelf()
		back = nil 
		nextB = nil 
	end
	audio.dispose(7);
	loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene