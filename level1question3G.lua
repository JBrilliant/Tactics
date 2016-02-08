--Are you being teased?
local loadsave = require( "loadsave" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")
local energyM = require("energy")
local sceneClass = require("sceneClass")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local energy = {}
local curLvl = gameSettings.currentLevel; local numberOfEnergy = gameSettings.levels[curLvl].energy; 
loadsave.printTable(gameSettings.levels[curLvl].energy)


local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.removeScene( "level1scene3G", false )
			storyboard.gotoScene( "level1scene3G", "fade", 200  )
		elseif button == "choice1" then
			score.add(20); score.save(); gameSettings.levels[curLvl].score = score.get()
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
			loadsave.printTable(gameSettings)
			storyboard.removeScene( "level1question3G", false )
			if curLvl == 1 then storyboard.gotoScene( "level1scene6G", "fade", 200 ) 
			elseif curLvl == 2 then storyboard.gotoScene( "level1scene4G", "fade", 200 ) end
		elseif button == "choice2" then
			energyM.minus(); energyM.save(); gameSettings.levels[curLvl].energy = energyM.get()
			gameSettings.energy = energyM.get()
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)		
			loadsave.printTable(gameSettings)
			storyboard.removeScene( "level1question3G", false )
			if curLvl == 1 then storyboard.gotoScene( "level1scene2G", "fade", 200 ) 
			elseif curLvl == 2 then storyboard.gotoScene( "level1scene4G", "fade", 200 ) end
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15;candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )
	local textQuest =  display.newText( "What will you say?", 270, 10, "riffic", 24 ); textQuest.x = _W/2; textQuest.y = _H/5; textQuest:setFillColor( 1,1,1 )
	local animation1 = transition.to(textQuest,{ time=1000, y = _H/2, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000})
	transition.to(textQuest,{transition=easing.inQuad, xScale=1, yScale=1, y=_H/10, time=500, delay=2000})
	
	local images = {}
	if curLvl == 1 then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level1/scene24.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level1/scene25.jpg"}
	elseif curLvl == 2 then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level2/scene2a.png", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level2/scene2b.png"}
	end
	local randomImages = {}
	for i, v in ipairs(images) do randomImages[i] = v end
	sceneClass.shuffle(randomImages)

	local function choice1fn()
		local choice1 = widget.newButton { defaultFile = randomImages[1], id = "choice"..tostring(table.indexOf( images, randomImages[1] )), x = _W/2 , y = _H/2 , height =   _H/4 + 30, width = _W/3 + 30, onRelease = buttonOnRelease }
		local animation = transition.to(choice1,{ time=500, x=_W/2 + 10, y = _W/2-100, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		transition.to(choice1,{time=500,delay=1000, x=_W/4 , y = _H/2 , xScale=1, yScale=1, transition=easing.inQuad})			
		local tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation); animation = nil; tmr = nil
		end,1);	
		group:insert(choice1)
	end
	timer.performWithDelay(2000,choice1fn,1)

	local function choice2fn()
		local choice2 = widget.newButton { defaultFile = randomImages[2], id = "choice"..tostring(table.indexOf( images, randomImages[2])), x = _W/2, y = _H/2 , height =  _H/4 + 30, width = _W/3 + 30, onRelease = buttonOnRelease }
		local animation = transition.to(choice2,{ time=500, x=_W/2 +10, y = _W/2-100, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		transition.to(choice2,{time=500,delay=1000, x=_W - _W/4, y = _H/2, xScale=1, yScale=1, transition=easing.inQuad})		
		local tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation); animation = nil; tmr = nil
		end,1);
		group:insert(choice2)
	end
	timer.performWithDelay(3000,choice2fn,1)
	-- timer.performWithDelay(000,function(e)
		
	-- end,1)

group:insert( background )	
group:insert( back )	
group:insert(textQuest)
group:insert(candy)
group:insert(scoreText)
for i=1,numberOfEnergy do
	energy[i] = display.newImage("images/english/"..gameSettings.character.."/energy.png"); energy[i].x = _W/90 + (30*i) -_W/9; energy[i].y = _H/15; energy[i].width = 26; energy[i].height = 25
	group:insert(energy[i])
end
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view
	if back and choice1 and choice2  then
		back:removeSelf()
		choice1:removeSelf()
		choice2:removeSelf()
		back = nil 
		choice1 = nil 
		choice2 = nil  
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene