local Matriz = require "ferramenta.matriz"

---@class Molecula
---@field nomes string[]
---@field tags table<string, boolean>
---@field atomos Atomo[]
---@field ligacoes Matriz
local Molecula = {}

Molecula.__index = Molecula
function Molecula:new()
    local obj = setmetatable({}, Molecula)

    obj.nomes = {}
    obj.tags = {}
    obj.atomos = {}
    obj.ligacoes = Matriz:new(0)

    return obj
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
    self.ligacoes:add_vetor()
    table.insert(self.atomos, atomo)
end

---adiciona ligacao
---@param p1 integer
---@param p2 integer
---@param ligacao Ligacao
function Molecula:adiciona_ligacao(p1, p2, ligacao)
    self.ligacoes:set(ligacao, p1, p2)
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

    print("\nATOMOS")
    for _, atomo in pairs(self.atomos) do
        print("+ atomo " .. atomo.simbolo .. " " .. atomo.carga)
    end

    print("\nLIGACOES")

    local linha = "  "
    for i, _ in ipairs(self.ligacoes) do
        linha = linha .. " " .. self.atomos[i].simbolo
    end
    print(linha)

    for x, coluna in ipairs(self.ligacoes) do
        local s = self.atomos[x].simbolo .. "|"
        for y, ligacao in ipairs(coluna) do
            s = s .. " " .. (ligacao == 0 and " " or "+")
        end
        print(s .. "|")
    end
end

---@class CaminhadaAtomos
---@field indice_atual number
---@field atomo Atomo
---@field pai Atomo?
---@field ligacao Ligacao?
---@field indice_anterior number?

---Anda por todos os atomos como uma arvore (do topo para a base)
---@param fn fun(data:CaminhadaAtomos): nil
---@param indice_atual number?
---@param ligacao Ligacao?
---@param ja_passou number[]?
---@param indice_anterior number?
function Molecula:andar_atomos(fn, indice_atual, ligacao, ja_passou, indice_anterior)
    if indice_atual == nil then indice_atual = 1 end
    if ja_passou == nil then ja_passou = {} end

    for _, indice_ja_visto in ipairs(ja_passou) do
        if indice_ja_visto == indice_atual then return end
    end

    local atomo = self.atomos[indice_atual]
    table.insert(ja_passou, indice_atual)

    fn {
        ["indice_atual"] = indice_atual,
        ["atomo"] = atomo,
        ["pai"] = self.atomos[indice_anterior],
        ["ligacao"] = ligacao,
        ["indice_anterior"] = indice_anterior
    }

    for proximo_indice, proxima_ligacao in ipairs(self.ligacoes:get_coluna(indice_atual)) do
        if proxima_ligacao ~= self.ligacoes.nullValue then
            self:andar_atomos(fn, proximo_indice, proxima_ligacao, ja_passou, indice_atual)
        end
    end
end

return Molecula