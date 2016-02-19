--Why did you lie?
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
-- if numberOfEnergy < 1 then storyboard.removeAll(); storyboard.gotoScene("levelfailedG","fade",200) end
gameSettings.levels[curLvl].score = score.get(); loadsave.printTable(gameSettings.levels[curLvl].energy)
local tmr, t;
print("level1scene5")


function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	-- local back = widget.newButton{ defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10,height =  _H/9 + 17, width = _W/9 + 18 ,onRelease = buttonOnRelease , onPress = buttonOnPress}
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15; candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, _W - 5, _H/15, "riffic", 18 );  scoreText:setFillColor( 1,0,0 )	
	-- local textmap = display.newText( "Map", _W/30 - 10, _H - _H/40, "riffic", 10 ); textmap:setFillColor( 1,1,1 )
		
	local sheetOptions = { width = 576, height = 320, numFrames = 12 }
	local sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level1/imgsheet3.png", sheetOptions )
	local sheet2 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/imgsheet2.png", sheetOptions )
	local sequence= { { name = "level1",  start = 5,  count = 3, time = 9000, loopCount = 1, loopDirection = "forward" },
					  { name = "level2",  start = 11,  count = 2, time = 15000, loopCount = 1, loopDirection = "forward" },
					  { name = "level3",  start = 5,  count = 4, time = 20000, loopCount = 1, loopDirection = "forward" },
					  { name = "level4",  start = 7,  count = 2, time = 8000, loopCount = 1, loopDirection = "forward" },
					  { name = "level4G",  start = 8,  count = 2, time = 8000, loopCount = 1, loopDirection = "forward" } }	
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

	if gameSettings.lang == "english" then 
	    if curLvl == 1 then audio.play( sfx.level1s5, { loops = 0, channel = 6} )
		elseif curLvl == 2  then	audio.play( sfx.level2s5, { loops = 0, channel = 13}) 
    	elseif  curLvl == 3 and thisSprite.frame == 3 then	
	    	audio.play( sfx.level3s3, { loops = 0, channel = 2, onComplete = audio.stop(2)}) ; audio.setVolume( 1 ) 
	    elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s5, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 1 ) 
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s5G, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 1 ) 
		end
	elseif gameSettings.lang == "tagalog" then
		if curLvl == 1 then audio.play( sfx.level1s5t, { loops = 0, channel = 6} )
		elseif curLvl == 2  then	audio.play( sfx.level2s5t, { loops = 0, channel = 13}) 
    	elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s5t, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 1 ) 
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s5Gt, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 1 ) 
		end
	elseif gameSettings.lang == "bicol" then
		if curLvl == 1 then audio.play( sfx.level1s5tg, { loops = 0, channel = 6} )
		elseif curLvl == 2  then	audio.play( sfx.level2s5g, { loops = 0, channel = 13}) 
    	elseif curLvl == 4 and gameSettings.character == "boy" then
			audio.play( sfx.level4s5g, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 1 ) 
		elseif curLvl == 4 and gameSettings.character == "girl" then
			audio.play( sfx.level4s5Gg, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 1 ) 
		end
	end

	

if curLvl == 1 then t = 9000 elseif curLvl == 2 then t = 15000 elseif curLvl == 3 then t = 20000 elseif curLvl == 4 then t = 8000 end
tmr = timer.performWithDelay(t,function(e) storyboard.removeAll()
	if curLvl == 1 or curLvl == 4  then storyboard.gotoScene( "level1question5G", "fade", 200);  --timer.cancel(tmr); --tmr = nil--
	elseif curLvl == 2 then storyboard.gotoScene( "level1question6G", "fade", 200); 
	elseif curLvl == 3 then storyboard.gotoScene( "level1question2G", "fade", 200); 
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

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
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