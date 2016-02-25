--default settings
local M = {}

	M.maxLevels = 5
	M.gameSettings = {}
	M.gameSettings.character = " "
	M.gameSettings.musicOn = true
	M.gameSettings.soundOn = true
	M.gameSettings.lang = "english"
	M.gameSettings.currentLevel = 1
	M.gameSettings.unlockedLevels = 1
	M.gameSettings.unlockedAchieve = 0
	M.gameSettings.levels = {}

	for i=1, M.maxLevels do
		M.gameSettings.levels[i] = {}
		M.gameSettings.levels[i].stars = 0  
		M.gameSettings.levels[i].score = 0
		M.gameSettings.levels[i].energy = 3
	end


return M