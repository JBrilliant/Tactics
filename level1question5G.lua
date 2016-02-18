--4. What was that? Nothing mam
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
-- if numberOfEnergy < 1 then storyboard.removeAll(); storyboard.gotoScene("levelfailedG","fade",200) end
loadsave.printTable(gameSettings.levels[curLvl].energy)
local tmr, t;
print("level1question5")

local function buttonOnPress(event)
	local availableChannel = audio.findFreeChannel()
	if gameSettings.soundOn == true then
		audio.play( sfx.click, { loops = 0, channel = availableChannel, onComplete = function()  audio.dispose( sfx.click )  end } )
	end
end

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			timer.cancel(tmr)
			storyboard.removeAll();
			if curLvl == 1  or curLvl == 4 then storyboard.gotoScene( "level1scene5G", "fade", 200  )
			elseif curLvl == 2 then storyboard.gotoScene( "level1scene3G", "fade", 200  ) end
		elseif button == "choice1" then
			energyM.minus(); energyM.save(); gameSettings.levels[curLvl].energy = energyM.get()
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); loadsave.printTable(gameSettings)
			storyboard.removeAll();
			if gameSettings.levels[curLvl].energy == 0 then storyboard.gotoScene( "levelfailedG", "fade", 200 ) 
			elseif curLvl == 1 then storyboard.gotoScene( "levelfailedG", "fade", 200 ) 
			elseif curLvl == 2 then storyboard.gotoScene( "level1scene5G", "fade", 200 )
			elseif curLvl == 4 then storyboard.gotoScene( "levelfailedG", "fade", 200 ) end
		elseif button == "choice2" then
			score.add(20); score.save(); gameSettings.levels[curLvl].score = score.get()
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory); loadsave.printTable(gameSettings)
			loadsave.printTable(gameSettings);  storyboard.removeAll();
			if gameSettings.levels[curLvl].energy == 0 then storyboard.gotoScene( "levelfailedG", "fade", 200 ) 
			elseif curLvl == 1 then storyboard.gotoScene( "level1scene3G", "fade", 200 ) 
			elseif curLvl == 2 then storyboard.gotoScene( "level1scene5G", "fade", 200 )
			elseif curLvl == 4 and gameSettings.character == "boy" then storyboard.gotoScene( "levelpassedG", "fade", 200 )  end
		end
end

function scene:createScene(event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease , onPress = buttonOnPress}	
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15;candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )
	local textmap = display.newText( "Replay", _W/30 - 10, _H - _H/40, "riffic", 10 ); textmap:setFillColor( 1,1,1 )
	
	local textQuest = display.newText( " ", 270, 10, "riffic", 24 ); textQuest.x = _W/2; textQuest.y = _H/5; textQuest:setFillColor( 1,1,1 );
	local text = {}
	if gameSettings.lang == "english" then
		textQuest.text = "What will you say?"
		if curLvl == 1 then text = {"I was afraid to get punished.", "She called me “Hippo” first."}
		elseif curLvl == 2 then text = {"Lie and tell that nothing's wrong \nand go back to your seat.", "Tell the truth about David \nand his friends bullying you."}
		elseif curLvl == 4 then 
			if gameSettings.character == "boy" then text = {"You will use this popularity \nto gain friends.", "You will use this popularity to raise awareness \nto everyone against social bullying"}
			elseif gameSettings.character == "girl" then text = {"Give them the money. You\n don't need it after all.", "Everything's not right. It's time to fight\n back and stop the bullying."} end
		end
	elseif gameSettings.lang == "tagalog" then
		textQuest.text = "Anong sasabihin mo?"
		if curLvl == 1 then text = {"Natatakot akong mapagalitan.", "Nauna po syang tumawag sa akin ng “Hippo”."}
		elseif curLvl == 2 then text = {"Magsinungaling at sabihin na lamang na walang \nproblema at bumalik na lamang sayong upuan.", "Sabihin ang totoo tungkol sa pang aaping \nginagawa nina David at ng kanyang mga kaibigan."} 
		elseif curLvl == 4 then 
			if gameSettings.character == "boy" then text = { "Gamitin ang kasikatang ito upang \nmagkaroon ng madaming kaibigan.", "Gamitin ang kasikatang ito upang magbigay \nkamalayan laban sa social bullying"}
			elseif gameSettings.character == "girl" then text = {"Ibigay sa kanila ang pera.\n Hindi mo naman ito kailangan.", "Hindi na tama ito. Kailangan mo nang labanan\n sila at tigilan na ang pang aaping ito. "} end
		end
	elseif gameSettings.lang == "bicol" then
		textQuest.text = "Anong sasabihon mo?"
		if curLvl == 1 then text = {"Natakot ako baka padusahan ako.", "Tinaraman nya ako madam na “Hippo”."}
		elseif curLvl == 2 then  text = {"Mag utik at taramon na wara man\n nangyayare at magbalik sa tukawan mo.", "Itaram su tunay tungkol kay David \nat sa mga barkada nya na tigaiwal ka."} 
		elseif curLvl == 4 then 
			if gameSettings.character == "boy" then text = {"Gagamitun moa ng kasikatan mo\n para matawan sinda kaaraman sa bullying", "Gagamitun mo ang kasikatan mo para\n matawan sinda kaaraman sa bullying"}
			elseif gameSettings.character == "girl" then text = {"Itao sana sainda su kwartang balon mo", "Magapundo ka na at tataraman mo sinda na \ntumunong na at magali na sa grupo ninda."} end
		end
	end
	local animation1 = transition.to(textQuest,{ time=1000, y = _H/2, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000})
	transition.to(textQuest,{transition=easing.inQuad, xScale=1, yScale=1, y=_H/10, time=500, delay=2000})
	
	local images = {} 
	if curLvl == 1 then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene30.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene17.jpg"}
	elseif curLvl == 2 then
		textQuest.text = "What will you do?"
		if gameSettings.lang == "tagalog" then textQuest.text = "Anong gagawin mo?"
		elseif gameSettings.lang == "bicol" then textQuest.text = "Anong gigibuhon mo?" end
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene4b.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene4a.jpg"}
	elseif curLvl == 4 then
		textQuest.text = "What would you do?"
		if gameSettings.lang == "tagalog" then textQuest.text = "Anong gagawin mo?"
		elseif gameSettings.lang == "bicol" then textQuest.text = "Anong gigibuhon mo?" end
		if gameSettings.character == "boy" then
			images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene5b.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene5a.jpg"}	
		else
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene5a.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene5b.jpg"} end
	end
	local randomImages = {}
	for i, v in ipairs(images) do randomImages[i] = v end
	sceneClass.shuffle(randomImages)

	local function choice1fn()	
		local choice1 = widget.newButton { defaultFile = randomImages[1], id = "choice"..tostring(table.indexOf( images, randomImages[1] )), x = _W/2 , y = _H/3 + _H/4 , height =   _H/4 + 30, width = _W/3 + 30, onRelease = buttonOnRelease }	
		local text = display.newText( text[table.indexOf( images, randomImages[1] )], _W/2, _H - _H/20, "riffic", 12 ); text:setFillColor(0,0,0)
		local animation = transition.to(choice1,{time=500, x=_W/2 + 10, y = _W/2-70, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		transition.to(choice1,{time=500,delay=2500, x=_W/4 , y = _H/2 ,  xScale=1, yScale=1, transition=easing.inQuad})				
		transition.fadeIn(text,{ time=500,  x=_W/2 , y = _H - _H/20})
		transition.to(text,{time=500,delay=2500, x=_W/4 , y = _H/2 + _H/4,  xScale=1, yScale=1, transition=easing.inQuad})				
		tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation);animation = nil; --tmr = nil
		end,1);			
		group:insert(choice1);	group:insert(text)
	end
	tmr = timer.performWithDelay(2000,choice1fn,1)

	local function choice2fn()
		local choice2 = widget.newButton { defaultFile = randomImages[2], id = "choice"..tostring(table.indexOf( images, randomImages[2])), x = _W/2, y = _H/3 + _H/4 , height =  _H/4 + 30, width = _W/3 + 30, onRelease = buttonOnRelease }
		local text = display.newText( text[table.indexOf( images, randomImages[2] )], _W/2, _H - _H/20, "riffic", 12); text:setFillColor(0,0,0)
		local animation = transition.to(choice2,{ time=500, x=_W/2 +10, y = _W/2-70, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		transition.to(choice2,{time=500,delay=2500, x=_W - _W/4, y = _H/2,  xScale=1, yScale=1, transition=easing.inQuad})		
		transition.fadeIn(text,{ time=500,  x=_W/2 , y = _H - _H/20})
		transition.to(text,{time=500,delay=2500, x=_W - _W/4, y = _H/2 + _H/4,  xScale=1, yScale=1, transition=easing.inQuad})				
		tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation); animation = nil; --tmr = nil
		end,1);
		group:insert(choice2);group:insert(text)
	end
	tmr = timer.performWithDelay(4500,choice2fn,1)
	-- tmr = timer.performWithDelay(5500,function(e) 
	-- 	local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	-- 	group:insert( back )
	-- 	end,1);
group:insert( background )	
group:insert( back )	
group:insert(textQuest)
group:insert(candy)
group:insert(scoreText)
group:insert(textmap)
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