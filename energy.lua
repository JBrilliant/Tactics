local M = {}  
M.energy = 3 
local customOptions = options or {} 
M.filename = customOptions.filename or "energyfile.txt"

-- function M.init( options )
--    local customOptions = options or {}
--    local opt = {}
--   M.filename = customOptions.filename or "energyfile.txt"

--    local prefix = ""
--    if ( opt.leadingZeros ) then 
--       prefix = "0"
--    end
--    M.format = "%" .. prefix .. opt.maxDigits .. "d"

--    M.scoreText = display.newText( string.format(M.format, 0), opt.x, opt.y, opt.font, opt.fontSize )
--    return M.scoreText
-- end

function M.set( value )
   M.energy = value
end

function M.get()
   return M.energy
end

function M.minus()
   M.energy = M.energy - 1
end

function M.save()
   local path = system.pathForFile( M.filename, system.DocumentsDirectory )
   local file = io.open(path, "w")
   if ( file ) then
      local contents = tostring( M.score )
      file:write( contents )
      io.close( file )
      return true
   else
      print( "Error: could not read ", M.filename, "." )
      return false
   end
end

function M.load()
   local path = system.pathForFile( M.filename, system.DocumentsDirectory )
   local contents = ""
   local file = io.open( path, "r" )
   if ( file ) then
      -- Read all contents of file into a string
      local contents = file:read( "*a" )
      local score = tonumber(contents);
      io.close( file )
      return score
   else
      print( "Error: could not read scores from ", M.filename, "." )
   end
   return nil
end

return M
