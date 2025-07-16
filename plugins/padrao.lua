
local distancia_atomos = 30
local atomos_com_posicao = {}

---Trata cada atomo
---@param data CaminhadaAtomos
local function calcular_posicao_atomo(data)
    local x = 0
    local y = 0
    if data.ligacao ~= nil then
        local angulo = data.ligacao.angulo
        x = atomos_com_posicao[data.indice_anterior].x + distancia_atomos * math.cos(GrausParaRadianos(angulo))
        y = atomos_com_posicao[data.indice_anterior].y + distancia_atomos * math.sin(GrausParaRadianos(angulo))
    end

    local atomo_com_posicao = {
        ["atomo"] = data.atomo,
        ["x"] = x,
        ["y"] = y
    }

    atomos_com_posicao[data.indice_atual] = atomo_com_posicao
end

MOLECULA:andar_atomos(calcular_posicao_atomo)

local min_x = 0
local min_y = 0
for _, atomo in pairs(atomos_com_posicao) do
    if atomo.x < min_x then min_x = atomo.x end
    if atomo.y < min_y then min_y = atomo.y end
end

local Svg = require "ferramenta.svg"
local svg = Svg:new()

for _, atomo in pairs(atomos_com_posicao) do
    svg:text(atomo.atomo.simbolo,
        math.abs(min_x) + atomo.x,
        math.abs(min_y) + atomo.y)
end

SAIDA = svg:build()