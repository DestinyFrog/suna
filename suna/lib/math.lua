
local Math = {}

--- receives angle in degrees and return in radians
---@param degrees number
function Math.degreesToRadians(degrees)
    return degrees * (math.pi / 180)
end

return setmetatable( Math, { __index = math } )