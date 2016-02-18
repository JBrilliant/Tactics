 --Yes. Level 1 End. Win
local loadsave = require( "loadsave" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")
local energyM = require("energy")
local gamestate = require("gamestate")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local curLvl = gameSettings.currentLevel
local energy = {}
local numberOfEnergy = gameSettings.levels[curLvl].energy
loadsave.printTable(gameSettings.levels[curLvl].energy)
local tmr

local function buttonOnPress(event)
	if gameSettings.soundOn == true then
		audio.play( sfx.click, { loops = 0, channel = 33, onComplete = function()  audio.dispose( sfx.click )  end } )
	end
end

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			 -- Runtime:removeEventListener("enterFrame", animate);
			 timer.cancel(tmr)
			 storyboard.removeAll(); storyboard.gotoScene( "mapG", "fade", 200 )
		elseif button == "nextB" then
			if gameSettings.unlockedLevels > gameSettings.currentLevel then
				gameSettings.currentLevel = gameSettings.currentLevel + 1; 
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); storyboard.removeAll(); storyboard.gotoScene( "level1scene1G", "fade", 200 )
			end
		elseif button == "badge" then
			storyboard.removeAll(); storyboard.gotoScene("achievements", "fade", 200)
		end
end

function scene:enterScene(event)
	if gameSettings.soundOn == true then
		audio.play( sfx.passed, { loops = 0, channel = 34, onComplete = function()  audio.dispose( sfx.passed )  end } )
	end
end

function scene:createScene( event )
	local group = self.view
	if audio.isChannelPaused( 1 ) and gameSettings.musicOn == true then audio.resume( 1 ) end
	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease , onPress = buttonOnPress}	
	local textmap = display.newText( "Map", _W/30 - 10, _H - _H/40, "riffic", 10 ); textmap:setFillColor( 1,1,1 )
	
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15;candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )
	local text =  display.newText( "Congratulations!", 270, 10, "riffic", 24 ); text.x = _W/2; text.y = _H/10; text:setFillColor( 1,1,1 )
	transition.to(text,{ time=1000, delay=300,y = _H/5, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000})
	transition.to(text,{transition=easing.inQuad, xScale=1, yScale=1, y=_H/10, time=2000, delay=2000, alpha=0})
	

	local sheetOptions = { width = 576, height = 320, numFrames = 12 }
	local sheet1 = graphics.newImageSheet( "images/english/"..gameSettings.character.."/level1/imgsheet3.png", sheetOptions )
	local sequence= { { name = "normalRun",  start = 11, count = 2, time = 1000, loopDirection = "forward" } }
	local animation = display.newSprite( sheet1, sequence); animation.x = _W/2+10; animation.y = _H/2 
		animation:play()	
	group:insert(background)
	group:insert(animation)
	group:insert( candy )
	group:insert( scoreText )
	group:insert( back )
	group:insert(text)
	group:insert(textmap)

	if gameSettings.levels[curLvl].score >= 40 then
		gameSettings.levels[curLvl].stars = 3; loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
	elseif gameSettings.levels[curLvl].score >= 20 and gameSettings.levels[curLvl].score  < 40 then
		gameSettings.levels[curLvl].stars = 2; loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
	else gameSettings.levels[curLvl].stars = 1
	end
	
	local star = {}
	if ( gameSettings.levels[curLvl] and gameSettings.levels[curLvl].stars and gameSettings.levels[curLvl].stars > 0 ) then
        for j = 1, gameSettings.levels[curLvl].stars do
        	star[j] = display.newImage("images/star.png"); star[j].x= _W/4 + _W/8*j; star[j].y=_H/5; star[j].height=_W/8; star[j].width=_W/8;
        	transition.to(star[j],{ time=500, delay=300,y = _H/3, xScale=1, yScale=1, transition=easing.inQuad,customProperty=1000})
			transition.to(star[j],{transition=easing.inQuad, xScale=1, yScale=1, y=_H/4, time=2000, delay=2000, alpha=0})
			group:insert( star[j] )
        end
    end

	if gameSettings.unlockedLevels == gameSettings.currentLevel then
		if gameSettings.levels[curLvl].stars == 3 then
			gameSettings.unlockedLevels = gameSettings.unlockedLevels + 1;
			tmr = timer.performWithDelay(5000,achieveUnlocked,1)	 
			gameSettings.unlockedAchieve = gameSettings.unlockedAchieve + 1;
		end
		gameSettings.levels[curLvl].energy = 3 ; gameSettings.levels[curLvl + 1].energy = 3 ; gameSettings.levels[curLvl].score = 0 
		loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
	end
	loadsave.printTable(gameSettings)

	if gameSettings.unlockedLevels == 6 then
		
	end

	local function achieveUnlocked()
		transition.to(animation,{transition=fade, time=500, alpha=0,onComplete=after})
		local text1 =  display.newText( "Achievement Unlocked!", 270, 10, "riffic", 24 ); text1.x = _W/2; text1.y = _H/10; text1:setFillColor( 1,1,1 )
		transition.to(text1,{ time=1000, delay=300,y = _H/5, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		local badge =  widget.newButton { defaultFile = "images/badge "..curLvl..".png", id = "badge", x = _W/2, y = _H/2, height =  _H/3, width = _W/4 , onRelease = buttonOnRelease, onPress = buttonOnPress }	
		 transition.to(badge,{ time=1000, delay=300,y = _H/2 + 50, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		local nextB = widget.newButton { defaultFile = "images/next2.png", overFile ="images/next2.png", id = "nextB", x = _W - _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease, onPress = buttonOnPress }	
		local nextLvl = display.newText( "Next Level", _W - _W/30,  _H - _H/40, "riffic", 10 );  nextLvl:setFillColor( 1,1,1 )
		local textAch = display.newText( "Tap to view achievements.", _W/2, _H - _H/40, "riffic", 10 );  textAch:setFillColor( 1,1,1 )
		if gameSettings.lang == "tagalog" or gameSettings.lang == "bicol" then 
			nextLvl.text = "Sunod na level"; textAch.text = "Pindutin para makita ang parangal." end
		if gameSettings.soundOn == true then
			audio.play( sfx.achieve, { loops = 0, channel = 35, onComplete = function()  audio.dispose( sfx.achieve )  end } )
		end
		group:insert( text1)
		group:insert( badge)
		group:insert( nextB); group:insert( nextLvl); group:insert( textAch) 
	end
	
	-- if 
		tmr = timer.performWithDelay(5000,achieveUnlocked,1)	

local function spriteListener( event )
    local thisSprite = event.target  -- "event.target" references the sprite
end

animation:addEventListener( "sprite", spriteListener )

for i=1,numberOfEnergy do
	energy[i] = display.newImage("images/english/"..gameSettings.character.."/energy.png"); energy[i].x = _W/90 + (30*i) -_W/9; energy[i].y = _H/15; energy[i].width = 26; energy[i].height = 25
	group:insert(energy[i])
end	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view
loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene