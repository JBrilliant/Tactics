local loadsave = require( "loadsave" )
local sfx = require( "sfx" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
local gamestate = require("gamestate")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)

		
local welcome, newGame, settings, achieve, credits, candy 

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "newGame" then
			if gameSettings.character == " " then
				storyboard.gotoScene( "character", "fade", 200 )
			else storyboard.gotoScene( "mapG", "fade", 200 )
			end
		elseif button == "achievements" then
			storyboard.gotoScene( "achievements", "fade", 200 )
		elseif button == "settings" then
			storyboard.gotoScene( "settings", "fade", 200 )
		elseif button == "credits" then
			storyboard.gotoScene( "creditshow")
		end
end

local function buttonOnPress(event)
	if gameSettings.soundOn == true then
		audio.play( sfx.click, { loops = 0, channel = 32, onComplete = function()  audio.dispose(32)  end } )
	end
end

function scene:createScene( event )
	local group = self.view

	welcome = display.newImage ("images/welcome.png"); welcome.height = _H; welcome.width = _W + _W/4; welcome.x = _W/2; welcome.y = _H/2;
	local sheetOptions = { width = 576, height = 320, numFrames = 12 }
	local sheet1 = graphics.newImageSheet( "images/english/girl/level1/imgsheet4.png", sheetOptions)
	local sequence= { { name = "normalRun", start = 3, count = 2, time = 2000,  loopDirection = "forward" }}
	local animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2
		animation:play()
		
	candy = display.newImage ("images/level_candies_active.png"); candy.height = _W/13; candy.width = _W/13; candy.x =_W/2 + 9;candy.y = _H/2 - 75 ; candy.alpha = 0.8
	
	newGame = widget.newButton { defaultFile = "images/newGame.png", overFile ="images/newGame_o.png", id = "newGame", x = _W/2, y = _H/2 + _H/7, height =  _H/7, width = _W/2, onRelease = buttonOnRelease , onPress = buttonOnPress}
	achieve = widget.newButton { defaultFile = "images/achievements.png", overFile ="images/achievements_o.png", id = "achievements", x = _W/3 , y = _H/2 + newGame.width/2, height =  _H/6, width = _W/9 , onRelease = buttonOnRelease, onPress = buttonOnPress }
	credits = widget.newButton { defaultFile = "images/tactics iconn.png", overFile ="images/tactics icon.png", id = "credits", x =_W/2 , y = _H/2 + newGame.width/2, height =  _H/5, width = _W/9 , onRelease = buttonOnRelease, onPress = buttonOnPress }	
	settings = widget.newButton { defaultFile = "images/settings.png", overFile ="images/settings_o.png", id = "settings", x =_W/3 + _W/3, y = _H/2 + newGame.width/2, height =  _H/6, width = _W/9 , onRelease = buttonOnRelease, onPress = buttonOnPress }
	
	local label1 = display.newText("Achievements", _W/3 , _H/2 + newGame.width/2 + 30, "riffic", 8 );
	local label2 = display.newText("Credits", _W/2 + 3, _H/2 + newGame.width/2 + 30, "riffic", 8 );
	local label3 = display.newText("Settings", _W/3 + _W/3 , _H/2 + newGame.width/2 + 30, "riffic", 8 );
		
	group:insert( welcome)
	group:insert(animation)
	group:insert( candy)
	group:insert( newGame)
	group:insert( settings)
	group:insert( achieve)
	group:insert( credits)
	group:insert(label1); group:insert(label2); group:insert(label3);
	loadsave.printTable(gameSettings);
end

function scene:enterScene( event )
	audio.reserveChannels( 1 )
    if gameSettings ~= nil then
	    if  gameSettings.musicOn   then
	  		 audio.play( sfx.bgmusic, { loops = -1, channel = 1, onComplete = function()  audio.dispose( 1)  end } )
		end
	else
		gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
		 if  gameSettings.musicOn   then
	  		 audio.play( sfx.bgmusic, { loops = -1, channel = 1, onComplete = function()  audio.dispose( sfx.bgmusic )  end } )
		end
	end
end

function scene:destroyScene( event )
	local group = self.view
	if newGame and settings and achieve and rank and upgrades and credits then
		newGame:removeSelf()
		settings:removeSelf()
		rank:removeSelf()
		upgrades:removeSelf()
		credits:removeSelf()
		newGame = nil 
		settings = nil 
		achieve = nil 
		rank = nil
		credits = nil  
	end

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene