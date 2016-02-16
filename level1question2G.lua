--Cry. tell your parents
local loadsave = require( "loadsave" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")
local energyM = require("energy")
local sceneClass = require("sceneClass")
local gamestate = require( "gamestate" )

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local energy = {}
local curLvl = gameSettings.currentLevel; local numberOfEnergy = gameSettings.levels[curLvl].energy; 
if numberOfEnergy < 1 then storyboard.removeAll(); storyboard.gotoScene("levelfailedG","fade",200) end
loadsave.printTable(gameSettings.levels[curLvl].energy)
local tmr, t;
print("level1question2")
local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			timer.cancel(tmr) -- storyboard.purgeScene( "level1question2G", false ); 
			storyboard.removeAll(); 
			if curLvl == 1 or curLvl == 4 then storyboard.gotoScene( "level1scene2G", "fade", 200  )
			elseif curLvl == 2 then storyboard.gotoScene( "level1scene1G", "fade", 200  ) 
			elseif curLvl == 3 then storyboard.gotoScene( "level1scene5G", "fade", 200  ) end
		elseif button == "choice1" then
			energyM.minus(); energyM.save(); gameSettings.levels[curLvl].energy = energyM.get()
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); loadsave.printTable(gameSettings)
			storyboard.removeAll(); storyboard.purgeScene( "level1question2G", false )
			if curLvl == 1 then storyboard.gotoScene( "level1scene7G", "fade", 200 )
			elseif curLvl == 2 or curLvl == 3 then storyboard.gotoScene( "level1scene2G", "fade", 200 )
			elseif curLvl == 4 then storyboard.gotoScene( "level1scene3G", "fade", 200 ) end
		elseif button == "choice2" then
			score.add(20); score.save(); gameSettings.levels[curLvl].score = score.get()
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); loadsave.printTable(gameSettings)
			storyboard.removeAll(); storyboard.purgeScene( "level1question2G", false )
			if curLvl == 1 then storyboard.gotoScene( "level1scene3G", "fade", 200 )
			elseif curLvl == 2 then storyboard.gotoScene( "level1scene2G", "fade", 200 ) 
			elseif curLvl == 3 or curLvl == 4 then storyboard.gotoScene( "level1scene3G", "fade", 200 ) end
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	-- local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15;candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )
	local textQuest = display.newText( " ", 270, 10, "riffic", 24 ); textQuest.x = _W/2; textQuest.y = _H/5; textQuest:setFillColor( 1,1,1 );
	local text = {}
	if gameSettings.lang == "english" then
		textQuest.text = "What will you do?"
		if curLvl == 1 then text = {"Cry.", "Tell your parents."}
		elseif curLvl == 2 then 
			if gameSettings.character == "boy" then text = {"Cry.", "Ask him politely why he did it."}
			elseif gameSettings.character == "girl" then text = {"Cry.", "Ask her politely why she did it."} end
		elseif curLvl == 3 then text = {"Ignore him and continue playing.", "You will follow him and play another game online."}
		elseif curLvl == 4 then text = {"", ""}
		end
	elseif gameSettings.lang == "tagalog" then
		textQuest.text = "Anong gagawin mo?"
		if curLvl == 1 then text = {"Umiyak", "Magsumbong sa mga magulang"}
		elseif curLvl == 2 then text = {"Umupo na lamang sa sulok at simulang umiyak.", "Tanungin sya kung bakit ka niya tinulak."}
		elseif curLvl == 3 then text = {"Magpapatuloy ka sa paglaro ng counterstrike", "Susundin mo ang tatay mo at maglalaro na lang ng ibang laro."}
		elseif curLvl == 4 then text = {"", ""}
		end
	elseif gameSettings.lang == "bicol" then
		textQuest.text = "Anong gigibuhon mo?"
		if curLvl == 1 then text = {"Magibi", "Itaram mo sa mga magurang mo"}
		elseif curLvl == 2 then text = {"Matukaw sa gilid at magaibi.", "Aputun siya kung nata ka tigatulak"}
		elseif curLvl == 3 then text = {"Mapadagos ka magkawat ki counterstrike", "Susunudun mo si papa mo tapos iba na lang ang kakawaton mo."}
		elseif curLvl == 4 then text = {"", ""}
		end
	end
	local animation1 = transition.to(textQuest,{ time=500, y = _H/2, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000})
	transition.to(textQuest,{transition=easing.inQuad, xScale=1, yScale=1, y=_H/10, time=500, delay=1000})
	
	local images = {}
	if curLvl == 1 then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene2a.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene1b.jpg"}
	elseif curLvl == 2  then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene1a.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene1b.jpg"}
	elseif curLvl == 3 then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene1a.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene3b.jpg"}
	elseif curLvl == 4 then
		textQuest.text = "What would you do?"
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene2a.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene2b.jpg"}
	end	
	local randomImages = {}
	for i, v in ipairs(images) do randomImages[i] = v end
	sceneClass.shuffle(randomImages)

	local function choice1fn()	
		local choice1 = widget.newButton { defaultFile = randomImages[1], id = "choice"..tostring(table.indexOf( images, randomImages[1] )), x = _W/2 , y = _H/3 + _H/4 , height =   _H/4 + 30, width = _W/3 + 30, onRelease = buttonOnRelease }	
		local text = display.newText( text[table.indexOf( images, randomImages[1] )], 270, 10, "riffic", 12 ); text:setFillColor(0,0,0)
		local animation = transition.to(choice1,{time=500, x=_W/2 + 10, y = _W/2-70, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		transition.to(choice1,{time=500,delay=2500, x=_W/4 , y = _H/2 ,  xScale=1, yScale=1, transition=easing.inQuad})				
		animation = transition.to(text,{time=500, x=_W/2 + 10, y =  _H/2 + _H/3, xScale=2, yScale=2, transition=fadeIn,customProperty=1000,onComplete=after})
		transition.to(text,{time=500,delay=2500, x=_W/4 , y = _H/2 + _H/4,  xScale=1, yScale=1, transition=easing.inQuad})				
		tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation);animation = nil; --tmr = nil
		end,1);		
		group:insert(choice1); group:insert(text)	
	end
	tmr = timer.performWithDelay(2000,choice1fn,1)

	local function choice2fn()
		local choice2 = widget.newButton { defaultFile = randomImages[2], id = "choice"..tostring(table.indexOf( images, randomImages[2])), x = _W/2, y = _H/3 + _H/4 , height =  _H/4 + 30, width = _W/3 + 30, onRelease = buttonOnRelease }
		local text = display.newText( text[table.indexOf( images, randomImages[2] )], 270, 10, "riffic", 12 ); text:setFillColor(0,0,0)
		local animation = transition.to(choice2,{ time=500, x=_W/2 +10, y = _W/2-70, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		transition.to(choice2,{time=500,delay=2500, x=_W - _W/4, y = _H/2,  xScale=1, yScale=1, transition=easing.inQuad})		
		animation = transition.to(text,{time=500, x=_W/2 + 10, y = _H/2 + _H/3, xScale=2, yScale=2, transition=fadeIn,customProperty=1000,onComplete=after})
		transition.to(text,{time=500,delay=2500, x=_W - _W/4, y = _H/2 + _H/4,  xScale=1, yScale=1, transition=easing.inQuad})				
		tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation); animation = nil; --tmr = nil
		end,1);
		group:insert(choice2); group:insert(text)	
	end
	tmr = timer.performWithDelay(4500,choice2fn,1)
	tmr = timer.performWithDelay(5500,function(e) 
		local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
		group:insert( back )
		end,1);

group:insert( background )	
-- group:insert( back )	
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
	loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene