local loadsave = require("loadsave")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
local back, english, tagalog, bicol

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			storyboard.removeAll();
			storyboard.gotoScene( "settings", "fade", 200 )
		elseif button == "english" then
			gameSettings.lang = "english"; loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
			storyboard.removeAll(); storyboard.gotoScene( "menu", "fade", 200 )
		elseif button == "tagalog" then
			gameSettings.lang = "tagalog"; loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
			storyboard.removeAll(); storyboard.gotoScene( "menu", "fade", 200 )
		elseif button == "bicol" then
			gameSettings.lang = "bicol"; loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
			storyboard.removeAll(); storyboard.gotoScene("menu", "fade", 200)
		end
end

function scene:createScene( event )
	local group = self.view
	
	local background = display.newImage("images/bgplain.jpg");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;
	group:insert(background)
		
	back = widget.newButton { defaultFile = "images/back.png", overFile ="images/back.png", id = "back", x = _W/30, y = _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease }	
	english = widget.newButton { defaultFile = "images/english.png", overFile ="images/english.png", id = "english", x = _W /2, y = _H/10 + 80, height =  _H/7, width = _W/2, onRelease = buttonOnRelease }	
	tagalog = widget.newButton { defaultFile = "images/tagalog.png", overFile ="images/tagalog.png", id = "tagalog", x = _W /2, y = _H/10 + 80*2, height =  _H/7, width = _W/2, onRelease = buttonOnRelease }	
	bicol = widget.newButton { defaultFile = "images/bicol.png", overFile ="images/bicol.png", id = "bicol", x = _W /2, y = _H/10 + 80*3, height =  _H/7, width = _W/2, onRelease = buttonOnRelease }	
	-- group:insert( choose )
	group:insert( back )
	group:insert( english )
	group:insert( tagalog )
	group:insert( bicol )

loadsave.saveTable(t, "myTable.json", system.DocumentsDirectory)
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene