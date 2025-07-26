
---@alias EletronsNumber
---| 'simple'
---| 'double'
---| 'triple'

---@alias LigationType
---| 'ionic'
---| 'covalent'
---| 'hydrogen_ligation'

---@class Ligation
---@field eletrons_number EletronsNumber
---@field type LigationType
---@field angle number?
local Ligation = {}

---@param eletrons_number EletronsNumber
---@param type LigationType
---@param angle number?
---@return Ligation
function Ligation:new(eletrons_number, type, angle)
    local obj = setmetatable({}, Ligation)
    obj.eletrons_number = eletrons_number or 'simple'
    obj.tipo = type or 'covalent'
    obj.angle = angle
    return obj
end

return Ligation