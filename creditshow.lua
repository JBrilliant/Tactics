local loadsave = require( "loadsave" )
local sfx = require( "sfx" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")

local back, credits, howtoplay

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( "settings", "fade", 200 )
		elseif button == "credit" then
			-- gameSettings.lang = "english"; loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
			--storyboard.purgeAll(); storyboard.gotoScene( "menu", "fade", 200 )
		elseif button == "howtoplay" then
			-- gameSettings.lang = "tagalog"; loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
		--	storyboard.purgeAll(); storyboard.gotoScene( "menu", "fade", 200 )
		end
end

function scene:createScene( event )
	local group = self.view
	
	local background = display.newImage("images/bgplain.jpg");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;
	group:insert(background)
	
	local lang = gameSettings.lang
	if lang == "bicol" then lang ="tagalog" end
	back = widget.newButton { defaultFile = "images/back.png", overFile ="images/back.png", id = "back", x = _W/30, y = _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	credit = widget.newButton { defaultFile = "images/credits.png",  id = "credits", x = _W /8, y = _H/10 + 80, height =  _H/9, width = _W/3, onRelease = buttonOnRelease }	
	howtoplay = widget.newButton { defaultFile = "images/"..lang.."/how.png", id = "howtoplay", x = _W /8, y = _H/10 + 150, height =  _H/9, width = _W/3, onRelease = buttonOnRelease }	
	
	group:insert( back )
	group:insert( credit )
	group:insert( howtoplay )

loadsave.saveTable(t, "myTable.json", system.DocumentsDirectory)
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

loadsave.saveTable(t, "myTable.json", system.DocumentsDirectory)
scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene