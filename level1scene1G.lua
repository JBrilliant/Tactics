local loadsave = require("loadsave")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local score = require("score")
local energyM = require("energy")
local sceneClass = require("sceneClass")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)

local energy = {}
local curLvl = gameSettings.currentLevel; print("dito ung error");
local numberOfEnergy = gameSettings.levels[curLvl].energy;  print("energy = "..gameSettings.levels[curLvl].energy); print("LEVEL "..gameSettings.currentLevel.." NA! scene1G")
local tmr, t;
print("level1scene1")


function scene:createScene( event )
	local group = self.view

	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15;candy.width = 80; candy.height = 25	
	local scoreText = score.init({ fontSize = 18, font = "riffic", x = _W - 5, y =  _H/15, maxDigits = 3, leadingZeros = false,	filename = "scorefile.txt"}); scoreText:setFillColor( 1,0,0 )
	score.set(0); score.save(); gameSettings.levels[curLvl].score = score.get()

	local sheetOptions = { width = 576, height = 320, numFrames = 12 }
	local sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/imgsheet2.png", sheetOptions)	
	local sheet2 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/imgsheet1.png", sheetOptions)	
	local sequence= { { name = "level1", start = 1, count = 9, time = 17500, loopCount = 1, loopDirection = "forward" },
					 { name = "level2", start = 1, count = 6, time = 22500, loopCount = 1, loopDirection = "forward" },
					 { name = "level3", start = 1, count = 2, time = 13000, loopCount = 1, loopDirection = "forward" },
					 { name = "level4", start = 1, count = 2, time = 30000, loopCount = 1, loopDirection = "forward" },
					 { name = "level4G", start = 1, count = 7, time = 60000, loopCount = 1, loopDirection = "forward" },
					 { name = "level5", start = 9, count = 3, time = 15000, loopCount = 1, loopDirection = "forward" }}	
	local  animation; 
	if curLvl == 4 and gameSettings.character == "girl" then  
		animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2; 
	animation:setSequence("level4G")  
	elseif curLvl == 5 then  animation = display.newSprite( sheet2, sequence); animation.x = _W/2; animation.y = _H/2; animation:setSequence("level5")  
	else  animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2; 
	animation:setSequence("level"..tostring(curLvl));	end
	
	animation:play()

local function spriteListener( event )
    local thisSprite = event.target    
    if gameSettings.lang == "english" then 
    	if thisSprite.frame == 2 and curLvl == 1 then
	    	audio.play( sfx.level1s1, { loops = 0, channel = 2, onComplete = audio.stop(2)}) 
	    end
    elseif gameSettings.lang == "tagalog" then
    	if thisSprite.frame == 2 and curLvl == 1 then
	    	audio.play( sfx.level1s1t, { loops = 0, channel = 2, onComplete = audio.stop(2)}) 
	    end 
    elseif gameSettings.lang == "bicol" then 
    	if thisSprite.frame == 2 and curLvl == 1 then
	    	audio.play( sfx.level1s1g, { loops = 0, channel = 2, onComplete = audio.stop(2)}) 
	    end
    end
end

	if gameSettings.lang == "english" then 
    	if curLvl == 2  then
	    	audio.play( sfx.level2s1, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 5 ) 
	    elseif curLvl == 3  then
	    	audio.play( sfx.level3s1, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 4) 
	    elseif curLvl == 4 and gameSettings.character == "boy" then
	    	audio.play( sfx.level4s1, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 4 ) 
	    elseif curLvl == 4 and gameSettings.character == "girl" then
	    	audio.play( sfx.level4s1G, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 4) 
    	elseif curLvl == 5 then
	    	audio.play( sfx.level5s1, { loops = 0, channel = 7, onComplete = audio.stop(7)}) ; audio.setVolume( 4) 
    	end
    elseif gameSettings.lang == "tagalog" then
    	if curLvl == 2  then
	    	audio.play( sfx.level2s1t, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 5 ) 
	    elseif curLvl == 3  then
	    	audio.play( sfx.level3s1t, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 4) 
	    elseif curLvl == 4 and gameSettings.character == "boy" then
	    	audio.play( sfx.level4s1t, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 4 ) 
	    elseif curLvl == 4 and gameSettings.character == "girl" then
	    	audio.play( sfx.level4s1Gt, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 4) 
    	elseif curLvl == 5 then
	    	audio.play( sfx.level5s1t, { loops = 0, channel = 7, onComplete = audio.stop(7)}) ; audio.setVolume( 4) 
    	end
    elseif gameSettings.lang == "bicol" then
    	if curLvl == 2  then
	    	audio.play( sfx.level2s1g, { loops = 0, channel = 3, onComplete = audio.stop(3)}) ; audio.setVolume( 5 ) 
	    elseif curLvl == 3  then
	    	audio.play( sfx.level3s1g, { loops = 0, channel = 4, onComplete = audio.stop(4)}) ; audio.setVolume( 4) 
	    elseif curLvl == 4 and gameSettings.character == "boy" then
	    	audio.play( sfx.level4s1g, { loops = 0, channel = 5, onComplete = audio.stop(5)}) ; audio.setVolume( 4 ) 
	    elseif curLvl == 4 and gameSettings.character == "girl" then
	    	audio.play( sfx.level4s1Gg, { loops = 0, channel = 6, onComplete = audio.stop(6)}) ; audio.setVolume( 4) 
    	elseif curLvl == 5 then
	    	audio.play( sfx.level5s1g, { loops = 0, channel = 7, onComplete = audio.stop(7)}) ; audio.setVolume( 4) 
    	end
    end
    
if curLvl == 1 then t = 19500 elseif curLvl == 2 then t = 22500 elseif curLvl == 3 then t = 13000 elseif curLvl == 4  and gameSettings.character == "boy" then t = 30000 elseif curLvl == 4 and gameSettings.character == "girl" then t = 60000 elseif curLvl == 5 then t = 15000 end
tmr = timer.performWithDelay(t,function(e)
	storyboard.removeAll()
	if curLvl == 1 or curLvl == 3 or curLvl == 5 then  storyboard.gotoScene( "level1question1G", "fade", 200)
	elseif curLvl == 2 then storyboard.gotoScene( "level1question2G", "fade", 200) 
	elseif curLvl == 4 then storyboard.gotoScene( "level1question6G", "fade", 200) 
	end
end,1)

animation:addEventListener( "sprite", spriteListener )
group:insert(animation)
group:insert(candy)
group:insert(scoreText)
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
	audio.dispose( 2 ); audio.dispose(9); audio.dispose(14); audio.dispose(19); audio.dispose(24);	
	loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene