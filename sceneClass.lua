local widget = require("widget")
local score = require("score")
local storyboard = require( "storyboard" )
-- local scene = storyboard.newScene()

--sceneClass
local S = {}

function buttonOnRelease(event, scene)
	local button = event.target.id
		if button == "back" then
			storyboard.gotoScene( storyboard.getPrevious(), "fade", 200 )
		elseif button == "nextB" then
			storyboard.purgeScene( "level1scene1G", false )
			storyboard.gotoScene( scene, "fade", 200 )
		end
end

function S.dispBack()
	local back = widget.newButton {
		defaultFile = "images/back2.png", overFile ="images/back2.png",
		id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 ,
		onRelease = buttonOnRelease }	
	return back
end



function S.getSO(numframes)
   S.sheetOptions = { width = 576, height = 320, numframes = 12 }
   return S.sheetOptions
end 


function S.getSeq(count, time)
	S.sequence = { { name = "normalRun", start = 1, count = 9, time = 20000, loopCount = 1, loopDirection = "forward" } }
   return S.sequence
end

local nextScene = " "
function S.switchscene(nextScene)
	storyboard.purgeScene( storyboard.getCurrentSceneName(), false )
	storyboard.gotoScene( nextScene, "fade", 200 )
end

math.randomseed(os.time()) -- Make sure to seed the random number generator.

function S.shuffle(t)
  local n = #t

  while n >= 2 do
    -- n is now the last pertinent index
    local k = math.random(n) -- 1 <= k <= n
    -- Quick swap
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end

  return t
end
return S