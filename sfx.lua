local gamestate = require( "gamestate" )
local loadsave = require( "loadsave" )
gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)

local sfx = {}

sfx.bgmusic = audio.loadSound("audio/bgmusic.wav")	
sfx.click = audio.loadSound("audio/click.wav")						--32														
sfx.choices = audio.loadSound("audio/choices.wav")					--31									
sfx.congratulations = audio.loadSound("audio/congratulations.wav")	--30
sfx.correct_answer = audio.loadSound("audio/correct_answer.wav")  	--29
sfx.end_levelfail = audio.loadSound("audio/end_levelfail.wav")		--28
sfx.drumroll = audio.loadSound("audio/drumroll.wav")				--27
sfx.fail = audio.loadSound("audio/fail button.wav")					--26
sfx.tada = audio.loadSound("audio/tadaa.wav")						--25
sfx.try_again = audio.loadSound("audio/try_again.wav")				--24										-- 1	
sfx.level1s1 = audio.loadSound("audio/english/girl/level1/level1-1.wav")	-- 2
sfx.level1s2 = audio.loadSound("audio/english/girl/level1/level1-2.wav")	-- 3
sfx.level1s3 = audio.loadSound("audio/english/girl/level1/level1-3.wav")	-- 4
sfx.level1s4 = audio.loadSound("audio/english/girl/level1/level1-4.wav")	-- 5
sfx.level1s5 = audio.loadSound("audio/english/girl/level1/level1-5.wav")	-- 6
sfx.level1s6 = audio.loadSound("audio/english/girl/level1/level1-6.wav")	-- 7
sfx.level1s7 = audio.loadSound("audio/english/girl/level1/level1-7.wav")	-- 8

sfx.level2s1 = audio.loadSound("audio/english/girl/level2/level2-1.wav")	-- 9
sfx.level2s2 = audio.loadSound("audio/english/girl/level2/level2-2.wav")	-- 10
sfx.level2s3 = audio.loadSound("audio/english/girl/level2/level2-3.wav")	-- 11
sfx.level2s4 = audio.loadSound("audio/english/girl/level2/level2-4.wav")	-- 12
sfx.level2s5 = audio.loadSound("audio/english/girl/level2/level2-5.wav")	-- 13

sfx.level3s1 = audio.loadSound("audio/english/girl/level3/level3-1.wav")	-- 14
sfx.level3s2 = audio.loadSound("audio/english/girl/level3/level3-2.wav")	-- 15
sfx.level3s3 = audio.loadSound("audio/english/girl/level3/level3-3.wav")	-- 16
sfx.level3s4 = audio.loadSound("audio/english/girl/level3/level3-4.wav")	-- 17
sfx.level3s5 = audio.loadSound("audio/english/girl/level3/level3-5.wav")	-- 18

sfx.level4s1 = audio.loadSound("audio/english/boy/level4/level4-1.wav")		-- 19
sfx.level4s2 = audio.loadSound("audio/english/boy/level4/level4-2.wav")		-- 20
sfx.level4s3 = audio.loadSound("audio/english/boy/level4/level4-3.wav")		-- 21
sfx.level4s4 = audio.loadSound("audio/english/boy/level4/level4-4.wav")		-- 22
sfx.level4s5 = audio.loadSound("audio/english/boy/level4/level4-5.wav")		-- 23

sfx.level4s1G = audio.loadSound("audio/english/girl/level4/level4-1.wav")	-- 24
sfx.level4s2G = audio.loadSound("audio/english/girl/level4/level4-2.wav")	-- 25
sfx.level4s3G = audio.loadSound("audio/english/girl/level4/level4-3.wav")	-- 26
sfx.level4s4G = audio.loadSound("audio/english/girl/level4/level4-4.wav")	-- 27
sfx.level4s5G = audio.loadSound("audio/english/girl/level4/level4-5.wav")	-- 28

sfx.level5s1 = audio.loadSound("audio/english/girl/level5/level5-1.wav")	-- 29
sfx.level5s2 = audio.loadSound("audio/english/girl/level5/level5-2.wav")	-- 30
sfx.level5s3 = audio.loadSound("audio/english/girl/level5/level5-3.wav")	-- 31
sfx.level5s4 = audio.loadSound("audio/english/girl/level5/level5-4.wav")	-- 32
-- tagalog
sfx.level1s1t = audio.loadSound("audio/tagalog/girl/level1/level1-1.wav")	-- 2
sfx.level1s2t = audio.loadSound("audio/tagalog/girl/level1/level1-2.wav")	-- 3
sfx.level1s3t = audio.loadSound("audio/tagalog/girl/level1/level1-3.wav")	-- 4
sfx.level1s4t = audio.loadSound("audio/tagalog/girl/level1/level1-4.wav")	-- 5
sfx.level1s5t = audio.loadSound("audio/tagalog/girl/level1/level1-5.wav")	-- 6
sfx.level1s6t = audio.loadSound("audio/tagalog/girl/level1/level1-6.wav")	-- 7
sfx.level1s7t = audio.loadSound("audio/tagalog/girl/level1/level1-7.wav")	-- 8

sfx.level2s1t = audio.loadSound("audio/tagalog/girl/level2/level2-1.wav")	-- 9
sfx.level2s2t = audio.loadSound("audio/tagalog/girl/level2/level2-2.wav")	-- 10
sfx.level2s3t = audio.loadSound("audio/tagalog/girl/level2/level2-3.wav")	-- 11
sfx.level2s4t = audio.loadSound("audio/tagalog/girl/level2/level2-4.wav")	-- 12
sfx.level2s5t = audio.loadSound("audio/tagalog/girl/level2/level2-5.wav")	-- 13

sfx.level3s1t = audio.loadSound("audio/tagalog/girl/level3/level3-1.wav")	-- 14
sfx.level3s2t = audio.loadSound("audio/tagalog/girl/level3/level3-2.wav")	-- 15
sfx.level3s3t = audio.loadSound("audio/tagalog/girl/level3/level3-3.wav")	-- 16
sfx.level3s4t = audio.loadSound("audio/tagalog/girl/level3/level3-4.wav")	-- 17
sfx.level3s5t = audio.loadSound("audio/tagalog/girl/level3/level3-5.wav")	-- 18

sfx.level4s1t = audio.loadSound("audio/tagalog/boy/level4/level4-1.wav")		-- 19
sfx.level4s2t = audio.loadSound("audio/tagalog/boy/level4/level4-2.wav")		-- 20
sfx.level4s3t = audio.loadSound("audio/tagalog/boy/level4/level4-3.wav")		-- 21
sfx.level4s4t = audio.loadSound("audio/tagalog/boy/level4/level4-4.wav")		-- 22
sfx.level4s5t = audio.loadSound("audio/tagalog/boy/level4/level4-5.wav")		-- 23

sfx.level4s1Gt = audio.loadSound("audio/tagalog/girl/level4/level4-1.wav")	-- 24
sfx.level4s2Gt = audio.loadSound("audio/tagalog/girl/level4/level4-2.wav")	-- 25
sfx.level4s3Gt = audio.loadSound("audio/tagalog/girl/level4/level4-3.wav")	-- 26
sfx.level4s4Gt = audio.loadSound("audio/tagalog/girl/level4/level4-4.wav")	-- 27
sfx.level4s5Gt = audio.loadSound("audio/tagalog/girl/level4/level4-5.wav")	-- 28

sfx.level5s1t = audio.loadSound("audio/tagalog/girl/level5/level5-1.wav")	-- 29
sfx.level5s2t = audio.loadSound("audio/tagalog/girl/level5/level5-2.wav")	-- 30
sfx.level5s3t = audio.loadSound("audio/tagalog/girl/level5/level5-3.wav")	-- 31
sfx.level5s4t = audio.loadSound("audio/tagalog/girl/level5/level5-4.wav")	-- 32
--bicol
sfx.level1s1g = audio.loadSound("audio/bicol/girl/level1/level1-1.wav")	-- 2
sfx.level1s2g = audio.loadSound("audio/bicol/girl/level1/level1-2.wav")	-- 3
sfx.level1s3g = audio.loadSound("audio/bicol/girl/level1/level1-3.wav")	-- 4
sfx.level1s4g = audio.loadSound("audio/bicol/girl/level1/level1-4.wav")	-- 5
sfx.level1s5g = audio.loadSound("audio/bicol/girl/level1/level1-5.wav")	-- 6
sfx.level1s6g = audio.loadSound("audio/bicol/girl/level1/level1-6.wav")	-- 7
sfx.level1s7g = audio.loadSound("audio/bicol/girl/level1/level1-7.wav")	-- 8g

sfx.level2s1g = audio.loadSound("audio/bicol/girl/level2/level2-1.wav")	-- 9
sfx.level2s2g = audio.loadSound("audio/bicol/girl/level2/level2-2.wav")	-- 10
sfx.level2s3g = audio.loadSound("audio/bicol/girl/level2/level2-3.wav")	-- 11
sfx.level2s4g = audio.loadSound("audio/bicol/girl/level2/level2-4.wav")	-- 12
sfx.level2s5g = audio.loadSound("audio/bicol/girl/level2/level2-5.wav")	-- 13

sfx.level3s1g = audio.loadSound("audio/bicol/girl/level3/level3-1.wav")	-- 14
sfx.level3s2g = audio.loadSound("audio/bicol/girl/level3/level3-2.wav")	-- 15
sfx.level3s3g = audio.loadSound("audio/bicol/girl/level3/level3-3.wav")	-- 16
sfx.level3s4g = audio.loadSound("audio/bicol/girl/level3/level3-4.wav")	-- 17
sfx.level3s5g = audio.loadSound("audio/bicol/girl/level3/level3-5.wav")	-- 18

sfx.level4s1g = audio.loadSound("audio/bicol/boy/level4/level4-1.wav")		-- 19
sfx.level4s2g = audio.loadSound("audio/bicol/boy/level4/level4-2.wav")		-- 20
sfx.level4s3g = audio.loadSound("audio/bicol/boy/level4/level4-3.wav")		-- 21
sfx.level4s4g = audio.loadSound("audio/bicol/boy/level4/level4-4.wav")		-- 22
sfx.level4s5g = audio.loadSound("audio/bicol/boy/level4/level4-5.wav")		-- 23

sfx.level4s1Gg = audio.loadSound("audio/bicol/girl/level4/level4-1.wav")	-- 24
sfx.level4s2Gg = audio.loadSound("audio/bicol/girl/level4/level4-2.wav")	-- 25
sfx.level4s3Gg = audio.loadSound("audio/bicol/girl/level4/level4-3.wav")	-- 26
sfx.level4s4Gg = audio.loadSound("audio/bicol/girl/level4/level4-4.wav")	-- 27
sfx.level4s5Gg = audio.loadSound("audio/bicol/girl/level4/level4-5.wav")	-- 28

sfx.level5s1g = audio.loadSound("audio/bicol/girl/level5/level5-1.wav")	-- 29
sfx.level5s2g = audio.loadSound("audio/bicol/girl/level5/level5-2.wav")	-- 30
sfx.level5s3g = audio.loadSound("audio/bicol/girl/level5/level5-3.wav")	-- 31
sfx.level5s4g = audio.loadSound("audio/bicol/girl/level5/level5-4.wav")	-- 32
function sfx.loadsfx()
	return sfx
end							

return sfx

