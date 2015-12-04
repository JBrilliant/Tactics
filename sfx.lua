local gamestate = require( "gamestate" )
local sfx = {
}  --create the main Sound Effects (sfx) table.
return sfx

-- sfx.bgmusic = audio.loadSound( "bgmusic.mp3" )

-- sfx.play = function( handle, options )

--    if ( gamestate.settings and gamestate.settings.soundOn == false ) then
--       --your settings dictate NOT to play this sound
--       return false
--    end

--    --otherwise, one of three things is true:
--    --1. myData.settings is nil. You haven't set up control, so play the sound.
--    --2. myData.settings.soundOn is nil. You have settings, but not a soundOn flag.
--    --   So, play the sound since you haven't set up control.
--    --3. soundOn is true, which means you want to play the sound. So, play it!
--    audio.play( handle, options )

-- end

-- return sfx