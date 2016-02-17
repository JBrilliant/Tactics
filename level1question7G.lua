local loadsave = require("loadsave")
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
local curLvl = gameSettings.currentLevel; local numberOfEnergy = gameSettings.levels[curLvl].energy; print("numberOf Energy  = "..numberOfEnergy)
-- if numberOfEnergy < 1 then storyboard.removeAll(); storyboard.gotoScene("levelfailedG","fade",200) end
loadsave.printTable(gameSettings.levels[curLvl].energy); print("CURRENT LEVEL = "..tostring(curLvl))
gameSettings.levels[curLvl].score = 0; gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local tmr, t;
print("level1question7")
local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			timer.cancel(tmr) -- storyboard.purgeScene( "level1question1G", false ); 
			storyboard.removeAll(); 
			if curLvl == 3 or curLvl == 5 then storyboard.gotoScene( "level1scene2G", "fade", 200  ) end
		elseif button == "choice1" then
			score.add(20); score.save(); gameSettings.levels[curLvl].score = score.get()
			energyM.minus(); energyM.save(); gameSettings.levels[curLvl].energy = energyM.get(); loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); loadsave.printTable(gameSettings)
			storyboard.removeAll();-- if curLvl == 1 then	storyboard.purgeScene( "level1question1G", false ); storyboard.gotoScene( "level1scene2G", "fade", 200 )
			if curLvl == 3 then storyboard.purgeScene( "level1question1G", false ); storyboard.gotoScene( "level1scene4G", "fade", 200 ) 
			elseif curLvl == 5 then storyboard.purgeScene( "level1question1G", false ); storyboard.gotoScene( "level1scene3G", "fade", 200 ) end
		elseif button == "choice2" then
			score.add(20); score.save(); gameSettings.levels[curLvl].score = score.get()
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); loadsave.printTable(gameSettings)
			-- if curLvl == 1 then storyboard.purgeScene( "level1question1G", false ); storyboard.gotoScene( "level1scene3G", "fade", 200 )
			if curLvl == 3 or curLvl == 5 then storyboard.purgeScene( "level1question1G", false ); storyboard.gotoScene( "level1scene6G", "fade", 200 ) end
		elseif button == "choice3" then
			energyM.minus(); energyM.save(); gameSettings.levels[curLvl].energy = energyM.get(); loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); loadsave.printTable(gameSettings)
			storyboard.removeAll();-- if curLvl == 1 then storyboard.purgeScene( "level1question1G", false ); storyboard.gotoScene( "level1scene4G", "fade", 200 )
			if curLvl == 3 or curLvl == 5 then storyboard.purgeScene( "level1question1G", false ); storyboard.gotoScene( "level1scene3G", "fade", 200 ) end
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
		if curLvl == 3 then text = {"They are not stopping, you\n will tell your dad about this.", "You just ignore him and \ncontinue playing again", "You’re mad. You will curse them also."}
		elseif curLvl == 5 then text = {"Go to canteen and pretend that\n you will just buy snacks", "You’ll just let him, because\n you’re afraid of him", "After your class you will tell \nwhat happened to your mom."}
		end
	elseif gameSettings.lang == "tagalog" then
		textQuest.text = "Anong gagawin mo?"
		if curLvl == 3 then text = {"Hindi sila titigil, \nisumbong sila sa iyong tatay.", "Hayaan lamang sila at \nipagpatuloy ang paglalaro.", "Galit na galit ka. Mumurahin mo rin sya."}
		elseif curLvl == 5 then text = {"Pumunta ng kantin at magkunwaring\n bibili ka ng pagkain.", "Hayaan sya dahil takot ka sa kanya.", "Pagkatapos ng iyong klase, \nsabihin ito sa iyong nanay.", }
		end
	elseif gameSettings.lang == "bicol" then
		textQuest.text = "Anong gigibuhon mo?"
		if curLvl == 3 then text = {"Dae sinda nagatunong kaya \niusip mo sya sa iyong tatay ", "Bayaan sana sinda at \ntigpadagos ang pagkawat", "Dagitunon ka at mumudahun mo man sya "}
		elseif curLvl == 5 then text = {"Magduman sa canteen at taraman syang \nmagabakal kang pagkaon ta nagutom ka na", "Bayae sana sya ta natakot ka saiya", "Pakatapos kang klase nindo ay tinaram \nmo ang nangyare sa magurang mo"}
		end
	end
	local animation1 = transition.to(textQuest,{ time=1000, y = _H/2, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000})
	transition.to(textQuest,{transition=easing.inQuad, xScale=1, yScale=1, y=_H/10, time=500, delay=1000})

	local images = {}
	if curLvl == 3 then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene2b.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene1a.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene2a.jpg"}
	elseif curLvl == 5 then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene2c.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene2a.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene2b.jpg"}
	end
	local randomImages = {}
	for i, v in ipairs(images) do randomImages[i] = v end
	sceneClass.shuffle(randomImages)

	local function choice1fn()		
		local choice1 = widget.newButton { defaultFile = randomImages[1], id = "choice"..tostring(table.indexOf( images, randomImages[1] )), x = _W/2 , y = _H/2 + _H/3 , height =   _H/4 + 30, width = _W/3 + 30, onRelease = buttonOnRelease }	
		local text = display.newText( text[table.indexOf( images, randomImages[1] )], _W/2, _H - _H/20, "riffic", 12 ); text:setFillColor(0,0,0)
		local animation = transition.to(choice1,{ time=500,  x=_W/2 + 10, y = _W/2-70, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
			transition.to(choice1,{time=500,delay=2500, x=_W/4, y = _H/3, xScale=1, yScale=1, transition=easing.inQuad})	
		transition.fadeIn(text,{ time=500,  x=_W/2 , y = _H - _H/20})
		transition.to(text,{time=500,delay=2500, x=_W/4, y = _H/2 + 10, transition=easing.inQuad})	
		tmr = timer.performWithDelay(1000,function(e) transition.cancel(animation); animation = nil; end,1); 
		group:insert(choice1); group:insert(text)
	end
	tmr = timer.performWithDelay(3000,choice1fn,1); print("tmr = choice1fn 2")
		
	local function choice2fn()	
		local choice2 = widget.newButton { defaultFile = randomImages[2], id = "choice"..tostring(table.indexOf( images, randomImages[2] )), x = _W/2, y = _H/2 + _H/3, height =  _H/4 + 30, width = _W/3 + 30, onRelease = buttonOnRelease }
		local text = display.newText( text[table.indexOf( images, randomImages[2] )], _W/2, _H - _H/20, "riffic", 12); text:setFillColor(0,0,0)
		local animation = transition.to(choice2,{ time=500,  x=_W/2 +10, y = _W/2-70, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
			transition.to(choice2,{time=500,delay=2500, x=_W - _W/4, y = _H/3, xScale=1, yScale=1, transition=easing.inQuad})		
		transition.fadeIn(text,{ time=500,  x=_W/2 , y = _H - _H/20})
		transition.to(text,{time=500,delay=2500, x=_W - _W/4, y = _H/2 + 10,  transition=easing.inQuad})	
		tmr = timer.performWithDelay(1000,function(e) transition.cancel(animation); animation = nil;  end,1); 
		group:insert(choice2); group:insert(text)
	end
	tmr = timer.performWithDelay(5500,choice2fn,1); print("tmr = choice2fn 2")

	
	local function choice3fn()
		local choice3 = widget.newButton { defaultFile = randomImages[3], id = "choice"..tostring(table.indexOf( images, randomImages[3] )), x = _W/2, y = _H/2 + _H/4, height =  _H/4 + 30, width = _W/3 + 30, onRelease = buttonOnRelease }
		local text = display.newText( text[table.indexOf( images, randomImages[3] )], _W/2, _H - _H/20, "riffic", 12 ); text:setFillColor(0,0,0)
		local animation = transition.to(choice3,{ time=500, x=_W/2 +10, y = _W/2-70, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
			transition.to(choice3,{time=500,delay=2500, x=_W/2 , y = _H/2 + 80 ,  xScale=1, yScale=1, transition=easing.inQuad})		
		transition.fadeIn(text,{ time=500,  x=_W/2 , y = _H - _H/20})
		transition.to(text,{time=500,delay=2500, x=_W/2, y = _H - _H/20,  transition=easing.inQuad})	
		tmr = timer.performWithDelay(1000,function(e)  transition.cancel(animation); animation = nil; end,1); 
		group:insert(choice3); group:insert(text)
	end
	tmr = timer.performWithDelay(8000,choice3fn,1);print("tmr = choice3fn 2")
	tmr = timer.performWithDelay(9000,function(e) 
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


function scene:destroyScene( event )
local group = self.view
	if back and choice1 and choice2 and choice3  then
		back:removeSelf()
		choice1:removeSelf()
		choice2:removeSelf()
		choice3:removeSelf()
		back = nil 
		choice1 = nil 
		choice2 = nil 
		choice3 = nil 
	end
	loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
end

loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene