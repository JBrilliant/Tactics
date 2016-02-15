local loadsave = require( "loadsave" )
local sfx = require( "sfx" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
local gamestate = require("gamestate");

local back, credits, howtoplay, background, bg, bg2, bgb


gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)

function scene:createScene( event )
	local group = self.view
	
	background = display.newImage("images/bgplain.jpg"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	group:insert(background)
	bg = display.newImage("images/creditss.jpg"); bg.height = _H; bg.width = _W/2 + 120; bg.x = _W - _W/3; bg.y = _H/2;
	group:insert(bg)
	bgb = display.newImage("images/Tactics_Blank Button.png"); bgb.height = _H/10; bgb.width = _W/3; bgb.x = _W /8; bgb.y = _H/10 + 80;
	group:insert(bgb)

	local lang = gameSettings.lang
	if lang == "bicol" then lang ="tagalog" end
	back = widget.newButton { defaultFile = "images/back.png", overFile ="images/back.png", id = "back", x = _W/30, y = _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = function(e) storyboard.purgeScene("creditshow", false); storyboard.gotoScene( "menu") end}	
	credit = widget.newButton { defaultFile = "images/credits.jpg",  id = "credits", x = _W /8, y = _H/10 + 80, height =  _H/16, width = _W/3 - 10, onRelease = function(e)
			bg = display.newImage("images/creditss.jpg"); bg.height = _H; bg.width = _W/2 + 120; bg.x = _W - _W/3; bg.y = _H/2;
			group:insert(bg)
			bgb:removeSelf()
			bgb = display.newImage("images/Tactics_Blank Button.png"); bgb.height = _H/10; bgb.width = _W/3; bgb.x = _W /8; bgb.y = _H/10 + 80;
			group:insert(bgb); group:insert( credit )
			end  }	
	howtoplay = widget.newButton { defaultFile = "images/"..lang.."/how.jpg", id = "howtoplay", x = _W /8, y = _H/10 + 150, height =  _H/15, width = _W/3 - 20, onRelease = 
	function(e)
			bg2 = display.newImage("images/howto.jpg"); bg2.height = _H; bg2.width = _W/2 + 120; bg2.x = _W - _W/3 ; bg2.y = _H/2;
			group:insert(bg2)	
			bgb:removeSelf()
			bgb = display.newImage("images/Tactics_Blank Button.png"); bgb.height = _H/10; bgb.width = _W/3; bgb.x = _W /8; bgb.y = _H/10 + 150;
			group:insert(bgb); group:insert( howtoplay )
			end }	
	
	group:insert( back )
	group:insert( credit )
	group:insert( howtoplay )

end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view
	if back and credit and howtoplay and bg and bgb and background then
		back:removeSelf()
		credit:removeSelf()
		howtoplay:removeSelf()
		bgb:removeSelf()
		background:removeSelf()
		back = nil 
		credit = nil 
		bg = nil 
		rank = ni
		credits = nil  
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene