local Matrix = require "suna.lib.matrix"
local List = require "suna.lib.list"

---@class Molecula
---@field names string[]
---@field tags table<string, boolean>
---@field atoms Atom[]
---@field ligations Matrix
local Molecula = {}

function Molecula.new()
    local obj = setmetatable({}, { __index = Molecula })
    obj.names = {}
    obj.tags = {}
    obj.atoms = {}
    obj.ligations = Matrix.new()
    return obj
end

--- add name
---@param name string
function Molecula:add_name(name)
    List.insert(self.names, name)
end

--- returns main name (first)
---@return string
function Molecula:get_main_name()
    return self.names[1]
end

--- add tag
---@param tag string
function Molecula:add_tag(tag)
    self.tags[tag] = true
end

--- retorna tags como uma lista
---@return string[]
function Molecula:get_tags()
    return List.keys(self.tags)
end

--- add atom
---@param atom Atom
function Molecula:add_atom(atom)
    self.ligations:add_vector()
    List.insert(self.atoms, atom)
end

--- add ligation
---@param a integer
---@param b integer
---@param ligation Ligation
function Molecula:add_ligation(a, b, ligation)
    self.ligations:set(ligation, a, b)
end


---@class WalkThroughAtoms
---@field current_index number
---@field atom Atom
---@field parent_atom Atom?
---@field ligation Ligation?
---@field last_index number?

--- Walk through all atoms as a tree (from top to bottom)
--- import to say it is actually a graph
--- but it avoid cycles
---@param fn fun(data:WalkThroughAtoms): nil
---@param current_index number?
---@param current_ligation Ligation?
---@param already number[]?
---@param last_index number?
function Molecula:walk_through_atoms(fn, current_index, current_ligation, already, last_index)
    if current_index == nil then current_index = 1 end

    ----- avoid cycles system
    if already == nil then already = {} end

    if List.find(already, current_index)
        then return end

    table.insert(already, current_index)
    ----- 

    fn {
        ["current_index"] = current_index,
        ["atom"] = self.atoms[current_index],
        ["parent_atom"] = self.atoms[last_index],
        ["ligation"] = current_ligation,
        ["last_index"] = last_index
    }

    for next_index, next_ligation in ipairs(self.ligations:get_column(current_index)) do
        if next_ligation ~= self.ligations.nullValue then
            self:walk_through_atoms(fn, next_index, next_ligation, already, current_index)
        end
    end
end

return Molecula