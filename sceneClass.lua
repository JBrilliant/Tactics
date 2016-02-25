local widget = require("widget")
local score = require("score")
local storyboard = require( "storyboard" )

local S = {}


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