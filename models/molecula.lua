local InterfaceLigacao = require "models.interface_ligacao"

---@class Molecula
---@field nomes string[]
---@field tags table<string, boolean>
---@field atomos Atomo[]
---@field ligacoes table<string, InterfaceLigacao>
local Molecula = {}

Molecula.__index = Molecula
function Molecula:new()
    local self = setmetatable({}, Molecula)

    self.nomes = {}
    self.tags = {}
    self.atomos = {}
    self.ligacoes = {}

    return self
end

---adiciona nome
---@param nome string
function Molecula:adiciona_nome(nome)
    table.insert(self.nomes, nome)
end

---retorna nomes principal (primeiro)
---@return string
function Molecula:pegar_nome_principal()
    return self.nomes[1]
end

---retorna nomes como uma lista
---@return string[]
function Molecula:pegar_nomes()
    return self.nomes
end

---adiciona tag
---@param tag string
function Molecula:adiciona_tag(tag)
    self.tags[tag] = true
end

---retorna tags como uma lista
---@return string[]
function Molecula:pegar_tags()
    local tags = {}
    for tag, _ in pairs(self.tags) do
        table.insert(tags, tag)
    end
    return tags
end

---adiciona atomo
---@param atomo Atomo
function Molecula:adiciona_atomo(atomo)
    table.insert(self.atomos, atomo)
end

---adiciona ligacao
---@param ligacao Ligacao
function Molecula:adiciona_ligacao(tag, ligacao)
    local interface_ligacao = InterfaceLigacao(ligacao)
    self.ligacoes[tag] = interface_ligacao
end

function Molecula:print()
    print("NOMES")
    for _, nome in ipairs(self.nomes) do
        print("+ nome " .. nome)
    end

    print("\nTAGS")
    for tag, _ in pairs(self.tags) do
        print("+ tag " .. tag)
    end

    print("\nATOMS")
    for _, atomo in pairs(self.atomos) do
        print("+ atomo " .. atomo.simbolo .. " " .. atomo.carga)
    end
end

return Molecula