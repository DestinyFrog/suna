
---@class Coordinate
---@field x number
---@field y number
local Coordinate = {}
Coordinate.__index = Coordinate

--- Constructor for Coordinate
---@param x number
---@param y number?
---@return Coordinate
function Coordinate.new(x, y)
    local obj = setmetatable({}, Coordinate)
    if y == nil then y = x end
    obj.x = x
    obj.y = y
    return obj
end

--- Constructor for Coordinate with zero default
---@return Coordinate
function Coordinate.zero()
    local obj = setmetatable({}, Coordinate)
    obj.x = 0
    obj.y = 0
    return obj
end

--- Constructor for polar coordinates
---@param angle number angle in radians
---@param radius number radius
---@return Coordinate
function Coordinate.polar(angle, radius)
    local obj = setmetatable({}, Coordinate)
    obj.x = radius * math.cos(angle)
    obj.y = radius * math.sin(angle)
    return obj
end

--- Set absolute coordinates
---@param x number | Coordinate
---@param y number?
---@return Coordinate
function Coordinate.abs(x, y)
    local obj = setmetatable({}, Coordinate)
    if y == nil then
        obj.x = math.abs(x.x)
        obj.y = math.abs(x.y)
    else
        obj.x = math.abs(x)
        obj.y = math.abs(y)
    end
    return obj
end

--- Sum two coordinates
---@param coord Coordinate
---@return Coordinate
function Coordinate:sum(coord)
    self.x = self.x + coord.x
    self.y = self.y + coord.y
    return self
end

--- Get a minimun value of many coordinates
---@param coords Coordinate[]
---@return Coordinate
function Coordinate.min(coords)
    local min = Coordinate.new(math.maxinteger)
    for _, coord in pairs(coords) do
        if coord.x < min.x then min.x = coord.x end
        if coord.y < min.y then min.y = coord.y end
    end
    return min
end

--- Sum a list of coordinates by a coordinate 
---@param coords Coordinate[]
---@param coord_to_sum Coordinate
function Coordinate.sum_many(coords, coord_to_sum)
    for _, coord in pairs(coords) do
        coord:sum(coord_to_sum)
    end
end

--- calculate angle between two coordinates
---@param a_coord Coordinate
---@param b_coord Coordinate
---@return number
function Coordinate.angle_between_two_points(a_coord, b_coord)
    local delta_x = b_coord.x - a_coord.x
    local delta_y = b_coord.y - a_coord.y
    local angle = math.atan(delta_y, delta_x)
    return angle
end

return Coordinate