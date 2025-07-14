local Molecula = require "models.molecula"
local Atomo = require "models.atomo"
require "funcao"

---[NOME string]
---@param molecula Molecula
---@param linha string
local function token_nome(molecula, linha)
    molecula:adiciona_nome(linha)
end

---[_TAG string]
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

local tokens = {
    ["NOME"] = token_nome,
    ["_TAG"] = token_tag,
    ["ATOM"] = token_atom,
}

local molecula = Molecula:new()

local file_name = "metano.sunaf"
local file = io.open(file_name, "r")

if file ~= nil then
    for line in file:lines() do
        for token, fn in pairs(tokens) do

            local line_token = string.sub(line, 1, 4)
            if line_token == token then
                local rest = string.sub(line, 6)
                fn(molecula, rest)
            end
        end
    end
    file:close()
else
    print("Arquivo não encontrado")
end

molecula:print()