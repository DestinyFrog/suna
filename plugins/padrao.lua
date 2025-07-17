
local Coordenada = require "ferramenta.coordenada"
local Svg = require "ferramenta.svg"

local distancia_atomos = 30
local distancia_atomo_ligacao = 8

---@type Coordenada[]
local coordenadas = {}

---Trata cada atomo
---@param data CaminhadaAtomos
local function calcular_posicao_atomo(data)
    local coord = Coordenada:zero()

    if data.ligacao ~= nil then
        local radiano = GrausParaRadianos(data.ligacao.angulo)
        coord = Coordenada:polar(radiano, distancia_atomos)

        local c = coordenadas[data.indice_anterior]
        coord:soma(c)
    end

    coordenadas[data.indice_atual] = coord
end

MOLECULA:andar_atomos(calcular_posicao_atomo)

local min = Coordenada.min(coordenadas)
local c = Coordenada:abs(min.x, min.y)
Coordenada:somar_por(coordenadas, c)

local svg = Svg:new()

for indice, coord in pairs(coordenadas) do
    local atomo = MOLECULA.atomos[indice]
    svg:texto(atomo.simbolo, coord)
end

for a, colunas in ipairs(MOLECULA.ligacoes) do
    for b, ligacao in ipairs(colunas) do
        if ligacao == 0 then goto continue end

        local angulo = CalcularAngulo(coordenadas[a], coordenadas[b])

        local acoord = Coordenada:polar(angulo, distancia_atomo_ligacao)
        acoord:soma(coordenadas[a])

        local angulo_antipodal = angulo + math.pi
        local bcoord = Coordenada:polar(angulo_antipodal, distancia_atomo_ligacao)
        bcoord:soma(coordenadas[b])

        svg:linha(acoord, bcoord)
        ::continue::
    end
end

SAIDA = svg:build()