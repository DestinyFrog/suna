local Atom = require "suna.models.atom"
local Ligation = require "suna.models.ligation"
local String = require "suna.lib.string"

--- [NAME string]
---@param molecula Molecula
---@param line string
local function token_name(molecula, line)
    molecula:add_name(line)
end

--- [STAG string]
---@param molecula Molecula
---@param line string
local function token_tag(molecula, line)
    molecula:add_tag(line)
end

--- [ATOM symbol:string charge:number]
---@param molecula Molecula
---@param line string
local function token_atom(molecula, line)
    local params = String.split(line)

    local symbol = params[1]
    local charge = tonumber(params[2])

    local atom = Atom:new(symbol, charge)
    molecula:add_atom(atom)
end

--- [LIGA name:string eletrons_number:string tipo_ligacao:string]
---@param molecula Molecula
---@param line string
local function token_liga(molecula, line)
    local params = String.split(line)

    local atom1 = tonumber(params[1])
    local atom2 = tonumber(params[2])
    local eletrons_number = params[3]
    local ligation_type = params[4]
    local angle = params[5] and tonumber(params[5]) or nil

    local ligation = Ligation:new(eletrons_number, ligation_type, angle)
    if atom1 and atom2 then
        molecula:add_ligation(atom1, atom2, ligation)
    end
end

local Tokens = {
    ["NAME"] = token_name,
    ["STAG"] = token_tag,
    ["ATOM"] = token_atom,
    ["LIGA"] = token_liga,
}

--- Tokenize one line of code
---@params molecula Molecula
---@param line string
function Tokens.tokenize(molecula, line)
    local line_token = string.sub(line, 1, 4)
    local fn = Tokens[line_token]
    if fn ~= nil then
        local rest = string.sub(line, 6)
        fn(molecula, rest)
    end
end

return Tokens