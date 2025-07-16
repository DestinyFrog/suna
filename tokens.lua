local Atomo = require "modelo.atomo"
local Ligacao = require "modelo.ligacao"
require "funcao"

---[NOME string]
---@param molecula Molecula
---@param linha string
local function token_nome(molecula, linha)
    molecula:adiciona_nome(linha)
end

---[STAG string]
---@param molecula Molecula
---@param linha string
local function token_tag(molecula, linha)
    molecula:adiciona_tag(linha)
end

---[ATOM string number]
---@param molecula Molecula
---@param linha string
local function token_atom(molecula, linha)
    local simbolo, str_carga = table.unpack(DividirString(linha))
    local carga = tonumber(str_carga)

    local atomo = Atomo:new(simbolo, carga)
    molecula:adiciona_atomo(atomo)
end

---[LIGA nome qtd_eletrons tipo_ligacao]
---@param molecula Molecula
---@param linha string
local function token_liga(molecula, linha)
    local p1, p2, qtd_eletrons, tipo_ligacao, angulo_str = table.unpack(DividirString(linha))

    local atom1 = tonumber(p1)
    local atom2 = tonumber(p2)
    local angulo = angulo_str and tonumber(angulo_str) or nil

    local ligacao = Ligacao:new(qtd_eletrons, tipo_ligacao, angulo)

    if atom1 and atom2 then
        molecula:adiciona_ligacao(atom1, atom2, ligacao)
    end
end

local Tokens = {
    ["NOME"] = token_nome,
    ["STAG"] = token_tag,
    ["ATOM"] = token_atom,
    ["LIGA"] = token_liga,
}

function Tokens.tokenizar(molecula, line)
    local line_token = string.sub(line, 1, 4)
    local fn = Tokens[line_token]
    if fn ~= nil then
        local rest = string.sub(line, 6)
        fn(molecula, rest)
    end
end

return Tokens