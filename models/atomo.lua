
---@class Atomo
---@field simbolo string
---@field carga number
local Atomo = {}
Atomo.__index = Atomo

---construtor de atomos
---@param simbolo string
---@param carga number?
function Atomo:new(simbolo, carga)
    local self = setmetatable({}, Atomo)

    self.simbolo = simbolo
    self.carga = carga or 0

    return self
end

return Atomo