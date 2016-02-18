local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
local sfx = require("sfx")
local loadsave = require("loadsave")
local gamestate = require("gamestate")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local back, boy, girl

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			-- if storyboard.getPreviousSceneName() == "settings" then
			-- 	storyboard.gotoScene( "settings", "fade", 200 )
			-- else 
				storyboard.gotoScene( "menu", "fade", 200 ) 
			-- end
		elseif button == "boy" then
			gameSettings.character = "boy"
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
			loadsave.printTable(gameSettings)
			storyboard.gotoScene( "mapG", "fade", 200 )
		elseif button == "girl" then
			gameSettings.character = "girl"
			loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
			loadsave.printTable(gameSettings)
			storyboard.gotoScene( "mapG", "fade", 200 )
		end
end

local function buttonOnPress(event)
	if gameSettings.soundOn == true then
		audio.play( sfx.click, { loops = 0, channel = 33, onComplete = function()  audio.dispose( sfx.click )  end } )
	end
end

function scene:createScene( event )
	local group = self.view
	local choose = display.newImage("images/"..gameSettings.lang.."/choose.jpg");
		choose.height = _H; choose.width = _W + _W/4;
		choose.x = _W/2; choose.y = _H/2;
		
	back = widget.newButton { defaultFile = "images/back.png", overFile ="images/back.png", id = "back", x = _W/40, y = _H/15, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease, onPress = buttonOnPress }	
	boy = widget.newButton { defaultFile = "images/boy_normal.png", overFile ="images/boy.png", id = "boy", x = _W/2 - 130 , y = _H/2 + 30, height =  240, width = 230 , onRelease = buttonOnRelease , onPress = buttonOnPress }	
	girl = widget.newButton { defaultFile = "images/girl_normal.png", overFile ="images/girl.png", id = "girl", x = _W/2 + 140 , y = _H/2 + 30, height =  240, width = 230 , onRelease = buttonOnRelease , onPress = buttonOnPress }	
		
	group:insert( choose )
	group:insert( back )
	group:insert( boy )
	group:insert( girl )
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view
loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)

end
			
scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene