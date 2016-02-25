local loadsave = require("loadsave")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local energy = {}
local curLvl = gameSettings.currentLevel;
local numberOfEnergy = gameSettings.levels[curLvl].energy
gameSettings.levels[curLvl].score = score.get()
loadsave.printTable(gameSettings.levels[curLvl].energy); loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
local tmr, t, duration
print("level1scene7")


function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15; candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, _W - 5, _H/15, "riffic", 18 );  scoreText:setFillColor( 1,0,0 )	
	
	if gameSettings.lang == "english" then 	
		if curLvl == 1 then 
			audio.play( sfx.level1s7, { loops = 0, channel = 2, onComplete = audio.stop(2)} )
			duration = sfx.time1s7
		end
	elseif gameSettings.lang == "tagalog" then 
		if curLvl == 1 then 
			audio.play( sfx.level1s7t, { loops = 0, channel = 2, onComplete = audio.stop(2)} )
			duration = sfx.time1s7t
		end
	elseif gameSettings.lang == "bicol" then 
		if curLvl == 1 then 
			audio.play( sfx.level1s7g, { loops = 0, channel = 2, onComplete = audio.stop(2)} )
			duration = sfx.time1s7g
		end
	end

	local sheetOptions = { width = 576, height = 320, numFrames = 12 }
	local sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/imgsheet3.png", sheetOptions )
	local sequence= { { name = "normalRun", start = 8, count = 3, time = duration, loopCount = 1, loopDirection = "forward" } }
	local animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2 
		animation:play()
		
	
	

	-- t = 9000 --if curLvl == 1 then t = 11000 elseif curLvl == 2 then t = 4000  end
	tmr = timer.performWithDelay(duration,function(e) storyboard.removeAll()
		storyboard.gotoScene( "question6", "fade", 200 )
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
	audio.dispose( 8 ); 	
	loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene