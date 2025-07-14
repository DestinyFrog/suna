
---@class InterfaceLigacao
---@field ligacao Ligacao
---@field de Atomo?
---@field para Atomo?
local InterfaceLigacao = {}
InterfaceLigacao.__index = InterfaceLigacao

---construtor de uma nova interface de ligacao
---@param ligacao Ligacao
function InterfaceLigacao:new(ligacao)
    local self = setmetatable({}, InterfaceLigacao)

    self.ligacao = ligacao

    return self
end

return InterfaceLigacao