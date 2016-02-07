local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local gamestate = require( "gamestate" )
local loadsave = require("loadsave")
gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)

function scene:createScene( event )
	local group = self.view

	local sheetOptions = { width = 576, height = 320, numFrames = 7 }
	local sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..gameSettings.currentLevel.."/imgsheet1.png", sheetOptions )
	local sequence= { { name = "normalRun",  start = 1, count = 7, time = 5000, loopCount = 1, loopDirection = "forward" } }
	local animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2 
		animation:play()
	
	timer.performWithDelay(8000,function(e)
			storyboard.gotoScene( "level1scene1G", "fade", 200 ); 
			if  gameSettings.musicOn == true then audio.stop( 1 ) end 
		end,1)	

local function spriteListener( event )
    local thisSprite = event.target  -- "event.target" references the sprite 
    if ( thisSprite.frame == 11) then  	
    end 
end

animation:addEventListener( "sprite", spriteListener )
group:insert(animation)
		
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene