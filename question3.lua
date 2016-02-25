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
local tmr, t;
print("level1question3")

local function buttonOnPress(event)
	if gameSettings.soundOn == true then
		local button = event.target.id
			if button == "back" then
				audio.play( sfx.click, { loops = 0, channel = 32, onComplete = function()  audio.dispose(32)  end } )
			elseif button == "choice1" then
				audio.play( sfx.correct_answer, { loops = 0, channel = 29, onComplete = function()  audio.dispose(29)  end } )
			elseif button == "choice2" then
				audio.play( sfx.fail, { loops = 0, channel = 26, onComplete = function()  audio.dispose(26)  end } )
			end
	end
end

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			-- timer.cancel(tmr) ;
			storyboard.removeAll();
			if curLvl == 1  or curLvl == 4 then storyboard.gotoScene( "scene3", "fade", 200  )
			elseif curLvl == 2 then storyboard.gotoScene( "scene2", "fade", 200  ) end
		elseif button == "choice1" then
			score.add(20); score.save(); gameSettings.levels[curLvl].score = score.get()
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
			loadsave.printTable(gameSettings)
			storyboard.removeAll(); 
			if gameSettings.levels[curLvl].energy == 0 then storyboard.gotoScene( "levelfailedG", "fade", 200 ) 
			elseif curLvl == 1 then storyboard.gotoScene( "scene6", "fade", 200 ) 
			elseif curLvl == 2 or curLvl == 4 then storyboard.gotoScene( "scene4", "fade", 200 ) end
		elseif button == "choice2" then
			energyM.minus(); energyM.save(); gameSettings.levels[curLvl].energy = energyM.get()
			gameSettings.energy = energyM.get();loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)	;loadsave.printTable(gameSettings)
			storyboard.removeAll(); 
			if gameSettings.levels[curLvl].energy == 0 then storyboard.gotoScene( "levelfailedG", "fade", 200 ) 
			elseif curLvl == 1 then storyboard.gotoScene( "scene2", "fade", 200 ) 
			elseif curLvl == 2  or curLvl == 4 then storyboard.gotoScene( "scene4", "fade", 200 ) end
		end
end

function scene:enterScene(event)
	if gameSettings.soundOn == true then
		audio.play( sfx.choices, { loops = -1, channel = 31,  onComplete = function()  audio.dispose(31)  end } )
	end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15;candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )
	
	local textQuest = display.newText( " ", 270, 10, "riffic", 24 ); textQuest.x = _W/2; textQuest.y = _H/5; textQuest:setFillColor( 1,1,1 );
	local text = {}
	if gameSettings.lang == "english" then
		textQuest.text = "What will you say?"
		if curLvl == 1 then text = {"Yes.", "None."}
		elseif curLvl == 2 then  
			if gameSettings.character == "boy" then text = {"Tell him that this \nis not fun anymore.", "Sulk and cry in your seat."}
			elseif gameSettings.character == "girl" then text = {"Tell her that this \nis not fun anymore.", "Sulk and cry in your seat."} end
		elseif curLvl == 4 then 
			if gameSettings.character == "boy" then text = {"Name the bullies.", "Do not name the persons \nwho bullied you."}
			elseif gameSettings.character == "girl" then text = {"Refuse to do it. Just find other\n friends that won't treat you the way they do.", "Follow their orders." } end
		end
	elseif gameSettings.lang == "tagalog" then
		textQuest.text = "Anong sasabihin mo?"
		if curLvl == 1 then text = {"Opo.", "Wala po."}
		elseif curLvl == 2 then text = {"Kausapin siya at sabihing \nhindi na ito nakakatawa.", "Magtampo at umiyak sa upuan mo."}
		elseif curLvl == 4 then 
			if gameSettings.character == "boy" then text = {"Pangalanan sila.", "Wag pangalanan ang mga ito."}
			elseif gameSettings.character == "girl" then text = {"Tanggihan ang mga ito. Maghanap ka na lang ng \nibang magiging kaibigan.", "Sundin ang mga utos nito."} end
		end
	elseif gameSettings.lang == "bicol" then
		textQuest.text = "Anong sasabihon mo?"
		if curLvl == 1 then text = {"Igwa po.", "Wara po."}
		elseif curLvl == 2 then  text = {"Taraman mo siya na bako na ini maogma.", "Magibi sa tukawan mo."} 
		elseif curLvl == 4 then 
			if gameSettings.character == "boy" then text = {"Papangaranan mo su mga nagaiwal saimo.", "Dae mo itataram kung sisay sinda."}
			elseif gameSettings.character == "girl" then text = {"Magdae sa mga tigapagibo ninda. \nMaganap ka na sana ki ibang barkada.", "Sunudun sana su mga \ntigapagibo nya saimo"} end
		end
	end
	local animation1 = transition.to(textQuest,{ time=1000, y = _H/2, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000})
	transition.to(textQuest,{transition=easing.inQuad, xScale=1, yScale=1, y=_H/10, time=500, delay=2000})
	
	local images = {}
	if curLvl == 1 then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene24.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene25.jpg"}
	elseif curLvl == 2 then
		textQuest.text = "What would you do?"
		if gameSettings.lang == "tagalog" then textQuest.text = "Anong gagawin mo?"
		elseif gameSettings.lang == "bicol" then textQuest.text = "Anong gigibuhon mo?" end
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene2a.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene2b.jpg"}
	elseif curLvl == 4 then
		textQuest.text = "What would you do?"
		if gameSettings.lang == "tagalog" then textQuest.text = "Anong gagawin mo?"
		elseif gameSettings.lang == "bicol" then textQuest.text = "Anong gigibuhon mo?" end
		if gameSettings.character == "boy" then
		images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene3a.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene3b.jpg"}
		elseif gameSettings.character == "girl" then
			images = {"images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene3b.jpg", "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/scene3a.jpg"}
		end
	end
	local randomImages = {}
	for i, v in ipairs(images) do randomImages[i] = v end
	sceneClass.shuffle(randomImages)

	local function choice1fn()	
		local choice1 = widget.newButton { defaultFile = randomImages[1], id = "choice"..tostring(table.indexOf( images, randomImages[1] )), x = _W/2 , y = _H/3 + _H/4 , height =   _H/4 + 30, width = _W/3 + 30, onRelease = buttonOnRelease, onPress = buttonOnPress  }	
		local text = display.newText( text[table.indexOf( images, randomImages[1] )], _W/2, _H - _H/10, "riffic", 12 ); text:setFillColor(0,0,0)
		local animation = transition.to(choice1,{time=500, x=_W/2 + 10, y = _W/2-70, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		transition.to(choice1,{time=500,delay=2500, x=_W/4 , y = _H/2 ,  xScale=1, yScale=1, transition=easing.inQuad})				
		transition.fadeIn(text,{ time=500,  x=_W/2 , y = _H - _H/20})
		transition.to(text,{time=500,delay=2500, x=_W/4 , y = _H/2 + _H/4,  xScale=1, yScale=1, transition=easing.inQuad})				
		tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation);animation = nil; timer.cancel(tmr); tmr = nil
		end,1);		
		group:insert(choice1)	; group:insert(text)
	end
	tmr = timer.performWithDelay(2000,choice1fn,1)

	local function choice2fn()
		local choice2 = widget.newButton { defaultFile = randomImages[2], id = "choice"..tostring(table.indexOf( images, randomImages[2])), x = _W/2, y = _H/3 + _H/4 , height =  _H/4 + 30, width = _W/3 + 30, onRelease = buttonOnRelease, onPress = buttonOnPress  }
		local text = display.newText( text[table.indexOf( images, randomImages[2] )], _W/2, _H - _H/10, "riffic", 12); text:setFillColor(0,0,0)
		local animation = transition.to(choice2,{ time=500, x=_W/2 +10, y = _W/2-70, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000,onComplete=after})
		transition.to(choice2,{time=500,delay=2500, x=_W - _W/4, y = _H/2,  xScale=1, yScale=1, transition=easing.inQuad})		
		transition.fadeIn(text,{ time=500,  x=_W/2 , y = _H - _H/20})
		transition.to(text,{time=500,delay=2500, x=_W - _W/4, y = _H/2 + _H/4,  xScale=1, yScale=1, transition=easing.inQuad})				
		tmr = timer.performWithDelay(1000,function(e)
			transition.cancel(animation); animation = nil; timer.cancel(tmr); tmr = nil--tmr = nil
		end,1);
		group:insert(choice2); group:insert(text)
	end
	tmr = timer.performWithDelay(4500,choice2fn,1)
	tmr = timer.performWithDelay(7500,function(e) 
		local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
		local textmap = display.newText( "Replay", _W/30 - 10, _H - _H/40, "riffic", 10 ); textmap:setFillColor( 1,1,1 )
		group:insert( back ); group:insert(textmap)
		end,1);

group:insert( background )
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

function scene:exitScene( event )
	audio.stop(31)
end

scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene