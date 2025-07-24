
---@class Coordinate
---@field x number
---@field y number
local Coordinate = {}

--- Constructor for Coordinate
---@param x number
---@param y number?
---@return Coordinate
function Coordinate:new(x, y)
    local obj = setmetatable({}, self)
    if y == nil then y = x end
    obj.x = x
    obj.y = y
    return obj
end

--- Constructor for Coordinate with zero default
---@return Coordinate
function Coordinate:zero()
    local obj = setmetatable({}, self)
    obj.x = 0
    obj.y = 0
    return obj
end

--- Constructor for polar coordinates
---@param angle number angle in radians
---@param radius number radius
---@return Coordinate
function Coordinate:polar(angle, radius)
    local obj = setmetatable({}, self)
    obj.x = radius * math.cos(angle)
    obj.y = radius * math.sin(angle)
    return obj
end

--- Set absolute coordinates
---@param x number
---@param y number
---@return Coordinate
function Coordinate:abs(x, y)
    self.x = math.abs(x)
    self.y = math.abs(y)
    return self
end

--- Sum two coordinates
---@param coord Coordinate
---@return Coordinate
function Coordinate:sum(coord)
    self.x = self.x + coord.x
    self.y = self.y + coord.y
    return self
end

--- Sum a list of coordinates by this coordinate 
---@param coords Coordinate[]
function Coordinate:sum_many(coords)
    for _, coord in pairs(coords) do
        coord:sum(self)
    end
end