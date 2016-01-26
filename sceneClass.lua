--sceneClass
local S = {}

S.sheetOptions = {
	width = 576,
	height = 320,
	numframes = 12
}

function S.getSO()
   return S.sheetOptions
end

S.sequence = {
	 {
        name = "normalRun",
        start = 1,
        count = 9,
        time = 20000,
        loopCount = 1,
        loopDirection = "forward"
    }
}

function S.getSeq()
   return S.sequence
end