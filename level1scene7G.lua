 --Yes. Level 1 End. Win
local loadsave = require("loadsave")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local energy = {}
local numberOfEnergy = gameSettings.levels[curLvl].energy
gameSettings.levels[curLvl].score = score.get()
loadsave.printTable(gameSettings.levels[curLvl].energy)
local tmr, t;

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			timer.cancel(tmr) 
			storyboard.removeAll(); storyboard.gotoScene( "mapG", "fade", 200 ); --storyboard.gotoScene( "level1question2G", "fade", 200 )
		elseif button == "nextB" then
			storyboard.removeScene( "level1scene7G", false )
			storyboard.gotoScene( "level1question6G", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local back = widget.newButton{ defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10,height =  _H/9 + 17, width = _W/9 + 18 ,onRelease = buttonOnRelease }
	local candy = display.newImageh ("images/candy.png"); candy.x = _W - 20; candy.y = _H/15; candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )	
	-- local nextB = widget.newButton { defaultFile = "images/next2.png", overFile ="images/next2.png", id = "nextB", x = _W - 30, y = _H - _H/10,
	-- 	height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	local sheetOptions = { width = 576, height = 320, numFrames = 12 }
	local sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..curLvl.."/imgsheet3.png", sheetOptions )
	local sequence= { { name = "normalRun", start = 8, count = 3, time = 9000, loopCount = 1, loopDirection = "forward" } }
	local animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2 
		animation:play()
		
	timer.performWithDelay(9000,function(e)
			local nextB = widget.newButton{
				defaultFile = "images/next2.png", overFile ="images/next2.png", id = "nextB", x = _W -_W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 ,
				onRelease = buttonOnRelease }	
			group:insert( nextB )
			-- storyboard.gotoScene("level1question6G","fade",200)
			-- storyboard.prugeScene("level1scene7G",false)
		end,1)	

local function spriteListener( event )
    local thisSprite = event.target  -- "event.target" references the sprite 
    if ( thisSprite.frame == 11) then 	
    end
end

t = 9000 --if curLvl == 1 then t = 11000 elseif curLvl == 2 then t = 4000  end
tmr = timer.performWithDelay(t,function(e)
	-- if curLvl == 1 then storyboard.gotoScene( "level1question5G", "fade", 200);  --timer.cancel(tmr); --tmr = nil--
	-- elseif curLvl == 2 then storyboard.gotoScene( "level1question6G", "fade", 200); 
	-- end
	storyboard.removeScene( "level1scene7G", false )
	storyboard.gotoScene( "level1question6G", "fade", 200 )
end,1)

animation:addEventListener( "sprite", spriteListener )
group:insert(background)
group:insert(animation)
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
	if back and nextB  then
		back:removeSelf()
		nextB:removeSelf()
		back = nil 
		nextB = nil 
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene