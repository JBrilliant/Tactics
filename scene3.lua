local loadsave = require("loadsave")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")
local gamestate = require( "gamestate" )

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local energy = {}
local curLvl = gameSettings.currentLevel; local numberOfEnergy = gameSettings.levels[curLvl].energy; 
loadsave.printTable(gameSettings.levels[curLvl].energy)
gameSettings.levels[curLvl].score = score.get()
loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
loadsave.printTable(gameSettings.levels[curLvl].energy)
local tmr, t, duration
print("level1scene3")

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15; candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, _W - 5, _H/15, "riffic", 18 ); scoreText:setFillColor( 1,0,0 )	
	
	local scenario
	if curLvl == 1 then
		scenario = display.newImage("images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene23.jpg")
	elseif curLvl == 2 then
		scenario = display.newImage("images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene4.jpg")
	elseif curLvl == 3 then
		scenario = display.newImage("images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene1a.jpg")
	elseif curLvl == 4 or curLvl == 5 then
		scenario = display.newImage("images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene3.jpg")
	end
	scenario.height = _H; scenario.width = _W + _W/4; scenario.x = _W/2; scenario.y = _H/2;

	if gameSettings.lang == "english" then
		if curLvl == 1 then	 
			audio.play( sfx.level1s3, { loops = 0, channel = 2, onComplete = audio.stop(2)} ) 
			duration = sfx.time1s3
		elseif curLvl == 2  then 
			audio.play( sfx.level2s4, { loops = 0, channel = 3, onComplete = audio.stop(3)})  audio.setVolume( 2 ) 
	    	duration = sfx.time2s4
	    elseif curLvl == 3  then 
	    	audio.play( sfx.level3s5, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ;  audio.setVolume( 2 ) 
	    	duration = sfx.time3s5
	    elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s3, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 1 ) 
			duration = sfx.time4s3
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s3G, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 1 ) 
			duration = sfx.time4s3G
		elseif curLvl == 5 then
	    	audio.play( sfx.level5s3, { loops = 0, channel = 7, onComplete = audio.stop(7)}) ; audio.setVolume( 4) 
			duration = sfx.time5s3
		end
	elseif gameSettings.lang == "tagalog" then
		if curLvl == 1 then	 
			audio.play( sfx.level1s3t, { loops = 0, channel = 2, onComplete = audio.stop(2)} ) 
			duration = sfx.time1s3t
		elseif curLvl == 2  then 
			audio.play( sfx.level2s4t, { loops = 0, channel = 3, onComplete = audio.stop(3)})  audio.setVolume( 4 ) 
	    	duration = sfx.time2s4t
	    elseif curLvl == 3  then 
	    	audio.play( sfx.level3s5t, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ;  audio.setVolume( 4) 
	    	duration = sfx.time3s5t
	    elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s3t, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s3t
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s3Gt, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s3Gt
		elseif curLvl == 5 then
	    	audio.play( sfx.level5s3t, { loops = 0, channel = 7, onComplete = audio.stop(7)}) ; audio.setVolume( 4) 
			duration = sfx.time5s3t
		end
	elseif gameSettings.lang == "bicol" then
		if curLvl == 1 then	 
			audio.play( sfx.level1s3g, { loops = 0, channel = 2, onComplete = audio.stop(2)} ) 
			duration = sfx.time1s3g
		elseif curLvl == 2  then 
			audio.play( sfx.level2s4g, { loops = 0, channel = 3, onComplete = audio.stop(3)})  audio.setVolume( 4 ) 
	    	duration = sfx.time2s4g
	    elseif curLvl == 3  then 
	    	audio.play( sfx.level3s5g, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ;  audio.setVolume( 4 ) 
	    	duration = sfx.time3s5g
	    elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s3g, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s3g
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s3Gg, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s3Gg
		elseif curLvl == 5 then
	    	audio.play( sfx.level5s3g, { loops = 0, channel = 7, onComplete = audio.stop(7)}) ; audio.setVolume( 4) 
			duration = sfx.time5s3g
		end
	end
-- t = 8000;	
-- if curLvl == 5 then t = 13000  end
	tmr = timer.performWithDelay(duration,function(e) storyboard.removeAll()
		if curLvl == 1 or curLvl == 4 then storyboard.gotoScene( "question3", "fade", 200);  --timer.cancel(tmr); --tmr = nil--
		elseif curLvl == 2 then storyboard.gotoScene( "question5", "fade", 200); 
		elseif curLvl == 3 then storyboard.gotoScene( "levelpassedG", "fade", 200); 
		elseif curLvl == 5 then storyboard.gotoScene( "question8", "fade", 200); 
		end
	end,1)

group:insert(background)
group:insert(scenario)
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
	audio.dispose(4); audio.dispose(12); audio.dispose(18); audio.dispose(21); audio.dispose(26);	
	loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene