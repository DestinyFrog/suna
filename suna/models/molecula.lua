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
function Molecula:get_hibridization(atom_index)
    local atom = self.atoms[atom_index]
    local sigma = 0
    local pi = 0
    local pares_nao_ligantes = 0

    -- Conta número de ligações sigma e pi
    for _, ligation in pairs(self.ligations:get_column(atom_index)) do
        if ligation == self.ligations.nullValue then goto continue end

        if ligation.eletrons_number == "simple" or ligation.eletrons_number == "single" then
            sigma = sigma + 1
        elseif ligation.eletrons_number == "double" then
            sigma = sigma + 1
            pi = pi + 1
        elseif ligation.eletrons_number == "triple" then
            sigma = sigma + 1
            pi = pi + 2
        end

        ::continue::
    end

    -- Define pares de elétrons não-ligantes por tipo de átomo
    local pares_por_elemento = {
        ["O"] = 2,
        ["N"] = 1,
        ["F"] = 3,
        ["Cl"] = 3,
        ["Br"] = 3,
        ["I"] = 3,
        ["S"] = 2,
        ["P"] = 1,
    }

    local simbolo = atom.symbol or atom.symbol or "C"
    pares_nao_ligantes = pares_por_elemento[simbolo] or 0

    -- Total de domínios ao redor do átomo
    local dominios = sigma + pares_nao_ligantes

    if dominios == 2 then
        return "sp"
    elseif dominios == 3 then
        return "sp2"
    elseif dominios == 4 then
        return "sp3"
    elseif dominios == 5 then
        return "sp3d"
    elseif dominios == 6 then
        return "sp3d2"
    else
        return "indefinido"
    end
end
local distribuicoes_angular = {
    sp = { angulos = { 0, 180 }, geometria = "linear" },
    sp2 = { angulos = { 0, 120, 240 }, geometria = "trigonal_planar" },
    sp3 = { angulos = { 0, 109.5, 219, 328.5 }, geometria = "tetraedrica" },
    sp3d = { angulos = { 0, 90, 180, 270, 120 }, geometria = "bipiramidal_trigonal" },
    sp3d2 = { angulos = { 0, 90, 180, 270, 45, 135 }, geometria = "octaedrica" }
}

---@param molecula Molecula
---@param atom_index integer
---@param angulo_referencia number? -- ângulo da ligação vinda do átomo anterior (antipodal)
function Molecula:atribuir_angulos(atom_index, angulo_referencia)
    if atom_index == nil then atom_index = 1 end
    if angulo_referencia == nil then angulo_referencia = 0 end

    local hibrido = self:get_hibridization(atom_index)
    local distrib = distribuicoes_angular[hibrido]
    if not distrib then return end

    local ligacoes = {}
    for i, lig in ipairs(self.ligations:get_column(atom_index)) do
        if lig ~= self.ligations.nullValue then
            table.insert(ligacoes, { destino = i, ligacao = lig })
        end
    end

    -- Ajusta a distribuição de ângulos ao número de ligações reais
    local angulos = distrib.angulos
    local n_ligacoes = #ligacoes
    if n_ligacoes ~= #angulos then
        angulos = {}
        local passo = 360 / n_ligacoes
        for i = 0, n_ligacoes - 1 do
            table.insert(angulos, i * passo)
        end
    end

    -- Ângulo de partida: antipodal ao ângulo anterior
    local base = angulo_referencia and (angulo_referencia + 180) % 360 or 0

    for i, info in ipairs(ligacoes) do
        local destino = info.destino
        local angulo = (base + angulos[i]) % 360
        local atom = self.atoms[destino]
        atom.angle = angulo -- salvar no átomo para futura renderização
    end
end

return Molecula