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
local curLvl = gameSettings.currentLevel; local numberOfEnergy = gameSettings.levels[curLvl].energy; loadsave.printTable(gameSettings.levels[curLvl].energy)
gameSettings.levels[curLvl].score = score.get(); loadsave.printTable(gameSettings.levels[curLvl].energy)
loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
local tmr, t, duration
print("level1scene5")


function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15; candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, _W - 5, _H/15, "riffic", 18 );  scoreText:setFillColor( 1,0,0 )	
		
	if gameSettings.lang == "english" then 
	    if curLvl == 1 then 
	    	audio.play( sfx.level1s5, { loops = 0, channel = 6} )
			duration = sfx.time1s5
		elseif curLvl == 2  then	
			audio.play( sfx.level2s5, { loops = 0, channel = 13}) 
    		duration = sfx.time2s5
    	elseif curLvl == 3 then 
    		duration = sfx.time3s3
    	elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s5, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s5
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s5G, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s5G
		end
	elseif gameSettings.lang == "tagalog" then
		if curLvl == 1 then 
			audio.play( sfx.level1s5t, { loops = 0, channel = 6} )
			duration = sfx.time1s5t
		elseif curLvl == 2  then	
			audio.play( sfx.level2s5t, { loops = 0, channel = 13}) 
    		duration = sfx.time2s5t
    	elseif curLvl == 3 then 
    		duration = sfx.time3s3t
    	elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s5t, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s5t
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s5Gt, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s5Gt
		end
	elseif gameSettings.lang == "bicol" then
		if curLvl == 1 then 
			audio.play( sfx.level1s5g, { loops = 0, channel = 6} )
			duration = sfx.time1s5g
		elseif curLvl == 2  then	
			audio.play( sfx.level2s5g, { loops = 0, channel = 13}) 
    		duration = sfx.time2s5g
    	elseif curLvl == 3 then 
    		duration = sfx.time3s3g
    	elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s5g, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s5g
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s5Gg, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 4 ) 
			duration = sfx.time4s5Gg
		end
	end

	local sheetOptions = { width = 576, height = 320, numFrames = 12 }
	local sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level1/imgsheet3.png", sheetOptions )
	local sheet2 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/imgsheet2.png", sheetOptions )
	local sequence= { { name = "level1",  start = 5,  count = 3, time = duration, loopCount = 1, loopDirection = "forward" },
					  { name = "level2",  start = 11,  count = 2, time = duration, loopCount = 1, loopDirection = "forward" },
					  { name = "level3",  start = 5,  count = 4, time = duration, loopCount = 1, loopDirection = "forward" },
					  { name = "level4",  start = 7,  count = 2, time = duration, loopCount = 1, loopDirection = "forward" },
					  { name = "level4G",  start = 8,  count = 2, time = duration, loopCount = 1, loopDirection = "forward" } }	
	local animation 
	if curLvl == 1 then animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2 
	elseif curLvl ==  2 then  animation = display.newSprite( sheet2, sequence); animation.x = _W/2; animation.y = _H/2; animation:setSequence("level2")
	elseif curLvl ==  3 then  animation = display.newSprite( sheet2, sequence); animation.x = _W/2; animation.y = _H/2; animation:setSequence("level3") 
	elseif curLvl ==  4  and gameSettings.character == "boy" then  animation = display.newSprite( sheet2, sequence); animation.x = _W/2; animation.y = _H/2; animation:setSequence("level4") 
	elseif curLvl ==  4 and gameSettings.character == "girl" then  animation = display.newSprite( sheet2, sequence); animation.x = _W/2; animation.y = _H/2; animation:setSequence("level4G") 
	end
	animation:play()

	local function spriteListener( event )
    	local thisSprite = event.target  
    	if gameSettings.lang == "english" then  
    		if  curLvl == 3 and thisSprite.frame == 3 then	
	    		audio.play( sfx.level3s3, { loops = 0, channel = 2, onComplete = audio.stop(2)}) ; audio.setVolume( 1 ) end
	 	elseif gameSettings.lang == "tagalog" then
	 		if  curLvl == 3 and thisSprite.frame == 3 then	
	    		audio.play( sfx.level3s3t, { loops = 0, channel = 2, onComplete = audio.stop(2)}) ; audio.setVolume( 1 ) end    
	    elseif gameSettings.lang == "bicol" then
	    	if  curLvl == 3 and thisSprite.frame == 3 then	
	    	audio.play( sfx.level3s3g, { loops = 0, channel = 2, onComplete = audio.stop(2)}) ; audio.setVolume( 1 ) end
	 	end
    end

	

	

-- if curLvl == 1 then t = 9000 elseif curLvl == 2 then t = 15000 elseif curLvl == 3 then t = 20000 elseif curLvl == 4 then t = 8000 end
tmr = timer.performWithDelay(duration,function(e) storyboard.removeAll()
	if curLvl == 1 or curLvl == 4  then storyboard.gotoScene( "question5", "fade", 200);  --timer.cancel(tmr); --tmr = nil--
	elseif curLvl == 2 then storyboard.gotoScene( "question6", "fade", 200); 
	elseif curLvl == 3 then storyboard.gotoScene( "question2", "fade", 200); 
	end
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
	audio.dispose(6); audio.dispose(13); audio.dispose(16); audio.dispose(23); audio.dispose(28);	
	loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene