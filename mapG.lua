local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
local loadsave = require("loadsave")
local gamestate = require("gamestate")

local starVertices = { 0,-8,1.763,-2.427,7.608,-2.472,2.853,0.927,4.702,6.472,0.0,3.0,-4.702,6.472,-2.853,0.927,-7.608,-2.472,-1.763,-2.427 }

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "level1" then
			storyboard.gotoScene( "level1question1G", "fade", 200 )
		elseif button == "level2" then
			-- storyboard.gotoScene( "level1question1G", "fade", 200 )
		elseif button == "level3" then
			-- storyboard.gotoScene( "level1question1G", "fade", 200 )
		elseif button == "level4" then
			-- storyboard.gotoScene( "level1question1G", "fade", 200 )
		elseif button == "level5" then
			-- storyboard.gotoScene( "level1question1G", "fade", 200 )
		elseif button == "level6" then
			-- storyboard.gotoScene( "level1question1G", "fade", 200 )
		elseif button == "level7" then
			-- storyboard.gotoScene( "level1question1G", "fade", 200 )
		elseif button == "level8" then
			-- storyboard.gotoScene( "level1question1G", "fade", 200 )
		elseif button == "level9" then
			-- storyboard.gotoScene( "level1question1G", "fade", 200 )
		elseif button == "level10" then
			-- storyboard.gotoScene( "level1question1G", "fade", 200 )
		elseif button == "back" then
			storyboard.gotoScene( "character", "fade", 200 )
		end
end

local function handleLevelSelect( event )
    if ( "ended" == event.phase ) then
        -- 'event.target' is the button and '.id' is a number indicating which level to go to.  
        -- The 'game' scene will use this setting to determine which level to load.
        -- This could be done via passed parameters as well.
        gamestate.gameSettings.currentLevel = event.target.id

        -- Purge the game scene so we have a fresh start
        storyboard.removeScene( "level1scene1G", false )

        -- Go to the game scene
        storyboard.gotoScene( "level1scene1G", "fade", 200 )
    end
end

function scene:createScene( event )
	local group = self.view
	
	local bg = display.newImage("images/map.png");
	bg.height = _H; bg.width = _W + _W/4;
	bg.x = _W/2; bg.y = _H/2;
	
	group:insert( bg )
	
	
	local back = widget.newButton {
		defaultFile = "images/back.png", overFile ="images/back.png",
		id = "back", x = _W/30, y = _H/10, height =  _H/9 + 17, width = _W/9 + 18 ,
		onRelease = buttonOnRelease }	
	group:insert( back )

	
	local level = {}

	

 	for i=1, gamestate.maxLevels do 
 			level[i] = widget.newButton	{
			defaultFile = "images/level_candies_active.png", overFile ="images/level_candies_active.png",
			height = _W/15,	width = _W/15 ,  --strokeColor =  1, 0, 0 ),
			onEvent = handleLevelSelect	}
 		if i==1 then
 			level[i].x = _W/2 + _W/6  + 19; level[i].y = _H/2 + _H/4 + 21; id = tostring( i )
 		elseif i==2 then
			level[i].x = _W/2 + _W/3 - 8;	level[i].y =  _H/2 + _H/4; id = tostring( i )
 		elseif i==3 then
 			level[i].x = _W/2 + _W/3 - 8;	level[i].y = _H/2 + 20; id = tostring( i )
 		elseif i==4 then
 			level[i].x = _W/2 + _W/3 - 8; level[i].y = _H/2 - 40; id = tostring( i )
 		elseif i==5 then
 			level[i].x = _W/2 + _H/4 + 14;	level[i].y = _H/2 - 43; id = tostring( i )
 		elseif i==6 then
 			level[i].x = _W/2 + 18;	level[i].y = _H/2 - 43; id = tostring( i )
 		elseif i==7 then
 			level[i].x = _W/2 -_W/8;	level[i].y = _H/2 - 43; id = tostring( i )
 		elseif i==8 then
 			level[i].x = _W/2 - _W/3 + 27 ;level[i].y = _H/2 - 43; id = tostring( i )
 		elseif i==9 then
 			level[i].x = _W/2 - _W/3 + 27; level[i].y = _H/2 - _H/4 - 10; id = tostring( i )
 		elseif i==10 then
 			level[i].x = _W/2 - _W/3 + 27; level[i].y = _H/15; id = tostring( i )
 		end	

		if ( gamestate.gameSettings.unlockedLevels == nil ) then
            gamestate.gameSettings.unlockedLevels = 1
        end
        if ( i <= gamestate.gameSettings.unlockedLevels ) then
			level[i]:setEnabled( true )
        else 
            level[i]:setEnabled( false ) 
            level[i].defaultFile = "images/level_candies_inactive.png"
            level[i].alpha = 0.5
        end   
		group:insert( level[i] )

        local star = {} 
        if ( gamestate.gameSettings.levels[i] and gamestate.gameSettings.levels[i].stars and gamestate.gameSettings.levels[i].stars > 0 ) then
            for j = 1, gamestate.gameSettings.levels[i].stars do
                star[j] = display.newPolygon( 0, 0, starVertices )
                star[j]:setFillColor( 1, 0.9, 0 )
                star[j].strokeWidth = 1
                star[j]:setStrokeColor( 1, 0.9, 0 )
                star[j].x = level[i].x + (j * 16) - 32
                star[j].y = level[i].y + 22
                group:insert( star[j] )
            end
        end
		
 	end

	local function animate(event)
		for i=1, gamestate.maxLevels do 
		level[i].rotation = level[i].rotation + 3
		end
	end
	Runtime:addEventListener("enterFrame",animate);

	
	
--	level1.self = "self";
	
	-- function enterFrame( e )

	-- 	for i,v in ipairs( e.target.self ) do
	-- 		v.rotation = v.rotation + v.dr
	-- 	end
	-- en
	-- Runtime:addEventListener( "enterFrame", level1 )

		
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene