local loadsave = require("loadsave")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")
local energyM = require("energy")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local energy = {}
local curLvl = gameSettings.currentLevel; local numberOfEnergy = gameSettings.levels[curLvl].energy; 
loadsave.printTable(gameSettings.levels[curLvl].energy)
gameSettings.levels[curLvl].score = score.get()
loadsave.printTable(gameSettings.levels[curLvl].energy)
loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
local tmr,t, duration
print("level1scene4")


function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15; candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, _W - 5, _H/15, "riffic", 18 );  scoreText:setFillColor( 1,0,0 )	
	
	if gameSettings.lang == "english" then
	    if curLvl == 1 then
	    	duration = sfx.time1s4
	    elseif curLvl == 2  then
	    	audio.play( sfx.level2s3, { loops = 0, channel = 3, onComplete = audio.stop(3)}) 
	    	duration = sfx.time2s3
	    elseif curLvl == 3  then
	    	audio.play( sfx.level3s4, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 4 ) 
			duration = sfx.time3s4
		elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s4, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s4
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s4G, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s4G
		end
	elseif gameSettings.lang == "tagalog" then
		if curLvl == 1 then
			duration = sfx.time1s4t
		elseif curLvl == 2  then
	    	audio.play( sfx.level2s3t, { loops = 0, channel = 3, onComplete = audio.stop(3)}) 
	    	duration = sfx.time2s3t
	    elseif curLvl == 3  then
	    	audio.play( sfx.level3s4t, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 4 ) 
			duration = sfx.time3s4t
		elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s4t, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 4) 
			duration = sfx.time4s4t
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s4Gt, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 4) 
			duration = sfx.time4s4Gt
		end
	elseif gameSettings.lang == "bicol" then
		if curLvl == 1 then
	    	duration = sfx.time1s4g
	    elseif curLvl == 2  then
	    	audio.play( sfx.level2s3g, { loops = 0, channel = 3, onComplete = audio.stop(3)}) 
	    	duration = sfx.time2s3g
	    elseif curLvl == 3  then
	    	audio.play( sfx.level3s4g, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 4 ) 
			duration = sfx.time3s4g
		elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s4g, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s4g
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s4Gg, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s4Gg
		end
	end

	local sheetOptions = {  width = 576, height = 320, numFrames = 12 }
	local sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level1/imgsheet3.png", sheetOptions )	
	local sheet2 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/imgsheet2.png", sheetOptions )	
	local sequence= { { name = "level1", start = 1, count = 3, time = duration, loopCount = 1, loopDirection = "forward" },
					  { name = "level2", start = 9, count = 2, time = duration, loopCount = 1, loopDirection = "forward" },
					  { name = "level3", start = 9, count = 4, time = duration, loopCount = 1, loopDirection = "forward" },
					  { name = "level4", start = 5, count = 2, time = duration, loopCount = 1, loopDirection = "forward" },
					  { name = "level4G", start = 10, count = 2, time = duration, loopCount = 1, loopDirection = "forward" }    }	
	local animation 
	if curLvl == 1 then animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2 
	elseif curLvl == 2 then  animation = display.newSprite( sheet2, sequence); animation.x = _W/2; animation.y = _H/2; animation:setSequence("level2")  
	elseif curLvl == 3 then  animation = display.newSprite( sheet2, sequence); animation.x = _W/2; animation.y = _H/2; animation:setSequence("level3")  
	elseif curLvl == 4 and gameSettings.character == "boy" then animation = display.newSprite( sheet2, sequence); animation.x = _W/2; animation.y = _H/2; animation:setSequence("level4")  
	elseif curLvl == 4 and gameSettings.character == "girl" then  animation = display.newSprite( sheet2, sequence); animation.x = _W/2; animation.y = _H/2; animation:setSequence("level4G")  end
		animation:play()

	local function spriteListener( event )
	    local thisSprite = event.target  -- "event.target" references the sprite  
	    if gameSettings.lang == "english" then
	   		if  thisSprite.frame == 2 and curLvl == 1 then audio.play( sfx.level1s4, { loops = 0, channel = 2, onComplete = audio.stop(2)} )
		    end
	   	elseif gameSettings.lang == "tagalog" then
	   		if  thisSprite.frame == 2 and curLvl == 1 then audio.play( sfx.level1s4t, { loops = 0, channel = 2, onComplete = audio.stop(2)} )
		    end
	   	elseif gameSettings.lang == "bicol" then
	   		if  thisSprite.frame == 2 and curLvl == 1 then audio.play( sfx.level1s4g, { loops = 0, channel = 2, onComplete = audio.stop(2)} )
		    end
	    end
	end



	-- if curLvl == 1 then t = 9000 elseif curLvl == 2 then t = 10000 elseif curLvl == 3 then t = 15000 elseif curLvl == 4 then t = 15000 end
	tmr = timer.performWithDelay(duration,function(e) storyboard.removeAll()
		if curLvl == 1 or curLvl == 2 or curLvl == 4 then storyboard.gotoScene("question4","fade",200) 
		elseif curLvl == 3 then storyboard.gotoScene("question8","fade",200)  end 
	end,1)

animation:addEventListener( "sprite", spriteListener )
group:insert(background)
group:insert(animation)
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
	audio.dispose(5); audio.dispose(11); audio.dispose(17); audio.dispose(22); audio.dispose(27);
	loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)	
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene