local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local loadsave = require("loadsave")
local sfx = require("sfx")
gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
loadsave.printTable(gameSettings); print("TRIVIA")

local tmr 

function scene:createScene( event )
	local group = self.view

	local sheetOptions = { width = 576, height = 320, numFrames = 7 }
	local sheet1 = graphics.newImageSheet( "images/"..gameSettings.lang.."/"..gameSettings.character.."/level"..gameSettings.currentLevel.."/imgsheet1.png", sheetOptions )
	local sequence= { { name = "normalRun",  start = 1, count = 7, time = 5000, loopCount = 1, loopDirection = "forward" } }
	local animation = display.newSprite( sheet1, sequence); animation.x = _W/2; animation.y = _H/2 
		animation:play()
	
	tmr = timer.performWithDelay(8000,function(e)
			storyboard.removeAll();
			storyboard.gotoScene( "scene1", "fade", 200 ); 
			if  gameSettings.musicOn == true then audio.pause( 1 ) end 
		end,1)	

group:insert(animation)
		
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene