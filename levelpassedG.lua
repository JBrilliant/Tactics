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

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			 -- Runtime:removeEventListener("enterFrame", animate);
			 storyboard.purgeScene( "mapG", false ); storyboard.purgeScene( "achievements", false );  storyboard.purgeScene( "achievements2", false )
			 storyboard.gotoScene( "mapG", "fade", 200 )
		elseif button == "nextB" then
			--storyboard.gotoScene( "level2scene1G", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15;candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )
	local text =  display.newText( "Congratulations!", 270, 10, "riffic", 24 ); text.x = _W/2; text.y = _H/10; text:setFillColor( 1,1,1 )
	transition.to(text,{ time=1000, delay=300,y = _H/5, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000})
	transition.to(text,{transition=easing.inQuad, xScale=1, yScale=1, y=_H/10, time=2000, delay=2000, alpha=0})
	print("umabot dito")
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
	print("umabot dito sa stars")
	if gameSettings.levels[curLvl].score >= 40 then
		gameSettings.levels[curLvl].stars = 3; loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
	elseif gameSettings.levels[curLvl].score >= 20 and gameSettings.levels[curLvl].score  < 40 then
		gameSettings.levels[curLvl].stars = 2; loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
	else gameSettings.levels[curLvl].stars = 1
	end
	gameSettings.unlockedLevels = gameSettings.unlockedLevels + 1; loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
	gameSettings.unlockedAchieve = gameSettings.unlockedAchieve + 1; loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
	loadsave.printTable(gameSettings)
	local star = {}
	if ( gameSettings.levels[curLvl] and gameSettings.levels[curLvl].stars and gameSettings.levels[curLvl].stars > 0 ) then
        for j = 1, gameSettings.levels[curLvl].stars do
        	star[j] = display.newImage("images/star.png"); star[j].x= _W/4 + _W/8*j; star[j].y=_H/5; star[j].height=_W/8; star[j].width=_W/8;
        	transition.to(star[j],{ time=500, delay=300,y = _H/3, xScale=1, yScale=1, transition=easing.inQuad,customProperty=1000})
			transition.to(star[j],{transition=easing.inQuad, xScale=1, yScale=1, y=_H/4, time=2000, delay=2000, alpha=0})
			group:insert( star[j] )
        end
    end
	print("umabot dito sa achievement")
	local function achieveUnlocked()
		transition.to(animation,{transition=fade, time=500, alpha=0,onComplete=after})
		local text1 =  display.newText( "Achievement Unlocked!", 270, 10, "riffic", 24 ); text1.x = _W/2; text1.y = _H/10; text1:setFillColor( 1,1,1 )
		transition.to(text1,{ time=1000, delay=300,y = _H/5, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		local badge = display.newImage("images/badge "..curLvl..".png"); badge.x = _W/2; badge.y = _H/2; badge.height = _H/3; badge.width = _W/4
		transition.to(badge,{ time=1000, delay=300,y = _H/2 + 50, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		local nextB = widget.newButton { defaultFile = "images/next2.png", overFile ="images/next2.png", id = "nextB", x = _W - _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
		group:insert( text1)
		group:insert( badge)
		group:insert( nextB)
	end
	
	timer.performWithDelay(5000,achieveUnlocked,1)	

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

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene