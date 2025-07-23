
local Coordenada = require "ferramenta.coordenada"
local Svg = require "ferramenta.svg"

local distancia_atomos = 21
local distancia_atomo_ligacao = 0

---@class CoordenadaOrganica
---@field x number
---@field y number
---@field hidrogenio_ligado_a_carbono boolean
local CoordenadaOrganica = {}
CoordenadaOrganica.__index = Coordenada

---constructor de coordenada com padrao zero
---@return CoordenadaOrganica
function CoordenadaOrganica:zero()
    local obj = setmetatable({}, CoordenadaOrganica)
    obj.__index = Coordenada
    obj.x = 0
    obj.y = 0
    return obj
end

---@type CoordenadaOrganica[]
local coordenadas = {}

---Trata cada atomo
---@param data CaminhadaAtomos
local function calcular_posicao_atomo(data)
    ---@type Coordenada
    local coord = CoordenadaOrganica:zero()

    if data.ligacao ~= nil then
        local radiano = GrausParaRadianos(data.ligacao.angulo)
        coord = Coordenada:polar(radiano, distancia_atomos)

        local c = coordenadas[data.indice_anterior]
        coord:soma(c)
    end

    coord.hidrogenio_ligado_a_carbono = data.atomo.simbolo == "H" and data.pai.simbolo == "C"

    coordenadas[data.indice_atual] = coord
end

MOLECULA:andar_atomos(calcular_posicao_atomo)

local min = Coordenada.min(coordenadas)
local c = Coordenada:abs(min.x, min.y)
Coordenada:somar_por(coordenadas, c)

local svg = Svg:new()

for indice, coord in pairs(coordenadas) do
    if coord.hidrogenio_ligado_a_carbono
        or MOLECULA.atomos[indice].simbolo == "C"
        then goto continue end

    local atomo = MOLECULA.atomos[indice]
    svg:texto(atomo.simbolo, coord)
    ::continue::
end

for a, colunas in ipairs(MOLECULA.ligacoes) do
    for b, ligacao in ipairs(colunas) do
        if ligacao == 0 then goto continue end

        local angulos_ligacoes = {
            { 0, 0 }
        }

        if ligacao.qtd_eletrons == 'dupla' then
            angulos_ligacoes = {
                { 1, 90 },
                { 1, 270 }
            }
        end

        if ligacao.qtd_eletrons == 'tripla' then
            angulos_ligacoes = {
                { 2, 90 },
                { 0, 0 },
                { 2, 270 }
            }
        end

        if coordenadas[a].hidrogenio_ligado_a_carbono or coordenadas[b].hidrogenio_ligado_a_carbono
            then goto continue end

        for i = #angulos_ligacoes, 1, -1 do
            local orbita = angulos_ligacoes[i][1]
            local angulo_ligacao = GrausParaRadianos(angulos_ligacoes[i][2])

            local angulo = CalcularAngulo(coordenadas[a], coordenadas[b])
            local angulo_antipodal = angulo + math.pi

            local acoord = Coordenada:polar(angulo, distancia_atomo_ligacao)
            acoord:soma(coordenadas[a])
            local orbita_a = Coordenada:polar(angulo + angulo_ligacao, orbita)
            orbita_a:soma(acoord)

            local bcoord = Coordenada:polar(angulo_antipodal, distancia_atomo_ligacao)
            bcoord:soma(coordenadas[b])
            local orbita_b = Coordenada:polar(angulo_antipodal - angulo_ligacao, orbita)
            orbita_b:soma(bcoord)

            svg:linha(orbita_a, orbita_b)
        end

        ::continue::
    end
end

SAIDA = svg:construir()