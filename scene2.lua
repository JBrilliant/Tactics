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
loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
local tmr, t, duration
print("level1scene2")


function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15; candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, _W - 5, _H/15, "riffic", 18 ); scoreText:setFillColor( 1,0,0 )	
	group:insert(background)
	
	if gameSettings.lang == "english" then 
		if curLvl == 1 then
			audio.play( sfx.level1s2, { loops = 0, channel = 2, onComplete = audio.stop(2)})
	    	duration = sfx.time1s2
	    elseif curLvl == 2  then
	        audio.play( sfx.level2s2, { loops = 0, channel = 3, onComplete = audio.stop(3)}) 
	    	duration = sfx.time2s2
	    elseif curLvl == 3  then
	    	audio.play( sfx.level3s2, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 1 ) 
	    	duration = sfx.time3s2
	    elseif curLvl == 4 and gameSettings.character == "boy" then
		   	audio.play( sfx.level4s2, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 1 ) 
			duration = sfx.time4s2
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s2G, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 1 ) 
			duration = sfx.time4s2G
		elseif curLvl == 5 then
			audio.play( sfx.level5s2, { loops = 0, channel = 7, onComplete = audio.stop(7)}) ; audio.setVolume( 4) 
			duration = sfx.time5s2
		end
	elseif gameSettings.lang == "tagalog" then 
		if curLvl == 1 then
			audio.play( sfx.level1s2t, { loops = 0, channel = 2, onComplete = audio.stop(2)})
			duration = sfx.time1s2t
		elseif curLvl == 2  then
	    	audio.play( sfx.level2s2t, { loops = 0, channel = 3, onComplete = audio.stop(3)}) 
	    	duration = sfx.time2s2t
	    elseif curLvl == 3  then
	    	audio.play( sfx.level3s2t, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 4 ) 
	    	duration = sfx.time3s2t
	    elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s2t, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s2t
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s2Gt, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s2Gt
		elseif curLvl == 5 then
			audio.play( sfx.level5s2t, { loops = 0, channel = 7, onComplete = audio.stop(7)}) ; audio.setVolume( 4) 
			duration = sfx.time5s2t
		end
	elseif gameSettings.lang == "bicol" then 
		if curLvl == 1 then
			audio.play( sfx.level1s2g, { loops = 0, channel = 2, onComplete = audio.stop(2)})
			duration = sfx.time1s2g
		elseif curLvl == 2  then
	    	audio.play( sfx.level2s2g, { loops = 0, channel = 3, onComplete = audio.stop(3)}) 
	    	duration = sfx.time2s2g
	    elseif curLvl == 3  then
	    	audio.play( sfx.level3s2g, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 4) 
	    	duration = sfx.time3s2g
	    elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s2g, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s2g
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s2Gg, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s2Gg
		elseif curLvl == 5 then
			audio.play( sfx.level5s2g, { loops = 0, channel = 7, onComplete = audio.stop(7)}) ; audio.setVolume( 4) 
			duration = sfx.time5s2g
		end
	end
	
	local scenario, sheetOptions, sheet1, sequence, animation
	if (curLvl == 4 and gameSettings.character == "girl") or curLvl == 5 then
		scenario = display.newImage("images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene2.jpg")
		scenario.height = _H; scenario.width = _W + _W/4; scenario.x = _W/2; scenario.y = _H/2;
		group:insert(scenario)
	elseif curLvl == 1 or curLvl == 2 or curLvl == 3 or curLvl == 4 then
		sheetOptions = { width = 576, height = 320, numFrames = 12}
		sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/imgsheet2.png", sheetOptions )
		sequence= { {name = "level1", start = 10,count = 3, time = duration, loopCount = 1, loopDirection = "forward" },
					{name = "level2", start = 7,count = 2, time = duration, loopCount = 1, loopDirection = "forward" },
					{name = "level3", start = 1,count = 4, time = duration, loopCount = 1, loopDirection = "forward" },
					{name = "level4", start = 3,count = 2, time = duration, loopCount = 1, loopDirection = "forward" }   }
		animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2 
		animation:setSequence("level"..tostring(curLvl)); animation:play()
		
		group:insert(animation)
		-- if (curLvl == 2) then  animation:setSequence("level2")  elseif (curLvl == 3) then  animation:setSequence("level3")  end
	end	

	
	

-- if curLvl == 1 then t = 11000 elseif curLvl == 2 then t = 12000 elseif curLvl == 3 then t = 17000 elseif curLvl == 4 and gameSettings.character == "boy" then t = 18000  elseif curLvl == 4 and gameSettings.character == "girl" then t = 12000 elseif curLvl == 5 then t = 15000 end
tmr = timer.performWithDelay(duration,function(e)
	storyboard.removeAll()
	if curLvl == 1 then storyboard.gotoScene( "question2", "fade", 200);  
	elseif curLvl == 2 then storyboard.gotoScene( "question3", "fade", 200); 
	elseif curLvl == 3 or curLvl == 5 then storyboard.gotoScene( "question7", "fade", 200); 
	elseif curLvl == 4 then storyboard.gotoScene( "question2", "fade", 200); 
	end
end,1)

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
	audio.dispose(3); audio.dispose(10); audio.dispose(15); audio.dispose(20); audio.dispose(25);	
	loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene