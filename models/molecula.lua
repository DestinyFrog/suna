local Matrix = require "lib.matrix"

---@class Molecula
---@field names string[]
---@field tags table<string, boolean>
---@field atoms Atom[]
---@field ligations Matrix
local Molecula = {}

function Molecula:new()
    local obj = setmetatable({}, Molecula)
    obj.names = {}
    obj.tags = {}
    obj.atoms = {}
    obj.ligations = Matrix:new()
    return obj
end

--- add name
---@param name string
function Molecula:add_name(name)
    table.insert(self.names, name)
end

--- returns main name (first)
---@return string
function Molecula:get_main_name()
    return self.names[1]
end



return Molecula