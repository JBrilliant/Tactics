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
local curLvl = gameSettings.currentLevel; local numberOfEnergy = gameSettings.levels[curLvl].energy; 
-- if numberOfEnergy < 1 then storyboard.removeAll(); storyboard.gotoScene("levelfailedG","fade",200) end
loadsave.printTable(gameSettings.levels[curLvl].energy); print("CURRENT LEVEL = "..tostring(curLvl))
gameSettings.levels[curLvl].score = 0; gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local tmr, t;
print("level1question8")

local function buttonOnPress(event)
	if gameSettings.soundOn == true then
		audio.play( sfx.click, { loops = 0, channel = 33, onComplete = function()  audio.dispose( sfx.click )  end } )
	end
end

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			timer.cancel(tmr) -- storyboard.purgeScene( "level1question1G", false ); 
			storyboard.removeAll();
			if curLvl == 3 then storyboard.gotoScene( "level1scene4G", "fade", 200  )
			elseif curLvl == 5 then storyboard.gotoScene( "level1scene3G", "fade", 200  ) end
		elseif button == "choice1" then
			score.add(20); score.save(); gameSettings.levels[curLvl].score = score.get()
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); loadsave.printTable(gameSettings)
			storyboard.removeAll();
			if gameSettings.levels[curLvl].energy == 0 then storyboard.gotoScene( "levelfailedG", "fade", 200 ) 
			elseif curLvl == 3 then  storyboard.gotoScene( "level1scene3G", "fade", 200 ) 
			elseif curLvl == 5 then   storyboard.gotoScene( "level1scene6G", "fade", 200 ) end
		elseif button == "choice2" then
			if curLvl == 5 then
				energyM.minus(); energyM.save(); gameSettings.levels[curLvl].energy = energyM.get(); loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); loadsave.printTable(gameSettings)
			else
			score.add(20); score.save();  gameSettings.levels[curLvl].score = score.get(); loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); loadsave.printTable(gameSettings) end
			storyboard.removeAll();
			if gameSettings.levels[curLvl].energy == 0 then storyboard.gotoScene( "levelfailedG", "fade", 200 ) 
			elseif curLvl == 3 then  storyboard.gotoScene( "level1scene3G", "fade", 200 ) 
			elseif curLvl == 5 then  storyboard.gotoScene( "levelfailedG", "fade", 200 ) end
		elseif button == "choice3" then
			energyM.minus(); energyM.save(); gameSettings.levels[curLvl].energy = energyM.get(); loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); loadsave.printTable(gameSettings)
			storyboard.removeAll();
			if gameSettings.levels[curLvl].energy == 0 then storyboard.gotoScene( "levelfailedG", "fade", 200 ) 
			elseif curLvl == 3 then storyboard.gotoScene( "level1scene6G", "fade", 200 ) 
			elseif curLvl == 5 then storyboard.gotoScene( "levelfailedG", "fade", 200 ) end
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease , onPress = buttonOnPress}	
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15;candy.width = 80; candy.height = 25	
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )
	local textmap = display.newText( "Replay", _W/30 - 10, _H - _H/40, "riffic", 10 ); textmap:setFillColor( 1,1,1 )
	local textQuest = display.newText( " ", 270, 10, "riffic", 24 ); textQuest.x = _W/2; textQuest.y = _H/5; textQuest:setFillColor( 1,1,1 );
	local text = {}
	if gameSettings.lang == "english" then
		textQuest.text = "What will you do?"
		if curLvl == 3 then text = {"You will get out of the game.", "You will ignore him and continue playing.", "You will reply with lots of curse \nbefore getting out of the game."}
		elseif curLvl == 5 then text = {"Push him away and run and\n tell your mom what happened", "Ignore because it’s quite normal \nin your every session", "Pretend that it didn't happen."}
		end
	elseif gameSettings.lang == "tagalog" then
		textQuest.text = "Anong gagawin mo?"
		if curLvl == 3 then text = {"Huwag nang maglaro.", "Hayaan lamang sila at \nipagpatuloy ang paglalaro", "Sasagot ka ng mas marami \npang mura bago ka umalis."}
		elseif curLvl == 5 then text = {"Itulak ito at tumakbo palabas \nat isumbong ito sa nanay mo.", "Hayaan ito dahil normal lang naman\n ito palagi pag sya ay nagtuturo.", "Magpanggap na walang nangyari."}
		end
	elseif gameSettings.lang == "bicol" then
		textQuest.text = "Anong gigibuhon mo?"
		if curLvl == 3 then text = {"Dae ka na magakawat\n at maali ka na", "Bayaan sana sinda at tigpadagos ang pagkawat.", "Mumudahun mo sinda bago ka magali "}
		elseif curLvl == 5 then text = {"Itulak sya at magali pagkatapos \nay iusip mon a sya sa magurang mo", "Babayaan mo na sna ta pirmi man sanang \nnangyayare pagtigaturuan ka nya", "Isipun na warang nangyare."}
		end
	end
	local animation1 = transition.to(textQuest,{ time=1000, y = _H/2, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000})
	transition.to(textQuest,{transition=easing.inQuad, xScale=1, yScale=1, y=_H/10, time=500, delay=1000})

	local images = {}
	if curLvl == 3 then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene3b.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene1a.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene4b.jpg"}
	elseif curLvl == 5 then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene3a.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene3b.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene3c.jpg"}
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
	tmr = timer.performWithDelay(3000,choice1fn,1);  
		
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
	tmr = timer.performWithDelay(5500,choice2fn,1);  

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
	tmr = timer.performWithDelay(8000,choice3fn,1);

	-- tmr = timer.performWithDelay(9000,function(e) 
	-- 	local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	-- 	group:insert( back )
	-- 	end,1);
group:insert( background )	
-- group:insert( back )	
group:insert(textQuest)
group:insert(candy)
group:insert(scoreText)
group:insert(textmap)
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