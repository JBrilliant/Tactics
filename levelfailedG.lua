 --. Level 1 End. Lose
local loadsave = require( "loadsave" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")
local energyM = require("energy")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local curLvl = gameSettings.currentLevel
local energy = {}
local numberOfEnergy = gameSettings.levels[curLvl].energy
loadsave.printTable(gameSettings.levels[curLvl].energy)

local function buttonOnPress(event)
	if gameSettings.soundOn == true then
		audio.play( sfx.click, { loops = 0, channel = 33, onComplete = function()  audio.dispose( sfx.click )  end } )
	end
end

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			 storyboard.removeAll(); storyboard.gotoScene( "mapG", "fade", 200 )
		elseif button == "nextB" then
			-- storyboard.gotoScene( "level1question2G", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view
	if audio.isChannelPaused( 1 ) and gameSettings.musicOn == true then audio.resume( 1 ) end
	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease , onPress = buttonOnPress}	
	local textmap = display.newText( "MAP", 270, 10, "riffic", 18 ); textmap.x =_W/30 + 30; textmap.y = _H - _H/10; textmap:setFillColor( 1,1,1 )
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15;candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )
	
	local textF =  display.newText( "Failed!", 270, 10, "riffic", 24 ); textF.x = _W/2; textF.y = _H/10; textF:setFillColor( 1,1,1 )
	transition.to(textF,{ time=1000, delay=300,y = _H/5, xScale=2, yScale=2, transition=easing.inQuad,customProperty=1000})
	-- transition.to(textF,{transition=easing.inQuad, xScale=1, yScale=1, y=_H/10, time=2000, delay=2000, alpha=0})
	if gameSettings.lang == "english" then
		textF.text = "You failed!"
	elseif gameSettings.lang == "tagalog" then
		textF.text = "You failed!"
	elseif gameSettings.lang == "bicol" then
		textF.text = "You failed!"
	end

	local sheetOptions = { width = 576, height = 320, numFrames = 12 }
	local sheet1 = graphics.newImageSheet( "images/english/girl/level1/imgsheet4.png", sheetOptions )	
	local sequence= {  { name = "girl", start = 1,  count = 2, time = 1000, loopDirection = "forward" },
					{ name = "boy", start = 5,  count = 2, time = 1000, loopDirection = "forward" } }
	local animation = display.newSprite( sheet1, sequence); animation.x = _W/2+10; animation.y = _H/2 
	if gameSettings.character == "boy" then animation:setSequence("boy") end
		animation:play()
	
	timer.performWithDelay(8000,function(e)
			-- storyboard.gotoScene("level1question2G","fade",200)
			--Level 1 passed!!!!!!!!
		end,1)	

local function spriteListener( event )
    local thisSprite = event.target  -- "event.target" references the sprite
    if ( thisSprite.frame == 11) then
    end
end
animation:addEventListener( "sprite", spriteListener )
group:insert(background)
group:insert(animation)
group:insert( textmap )
group:insert( back )
group:insert( candy )
group:insert( scoreText )
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
scene:addEventListener( "destroyScene", scene )


return scene