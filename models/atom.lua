
---@class Atom
---@field symbol string
---@field carga number
local Atom = {}

---@param symbol string
---@param charge number?
function Atom:new(symbol, charge)
    local obj = setmetatable({}, Atom)
    obj.symbol = symbol
    obj.carga = charge or 0
    return obj
end

return Atom