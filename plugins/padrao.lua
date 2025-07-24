local Coordenada = require "ferramenta.coordenada"
local Svg = require "ferramenta.svg"

local distancia_atomos = 21
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

local angulos_ligacoes = {
    ["simples"] = {
        { 0, 0 }
    },
    ["dupla"] = {
        { 1, 90 },
        { 1, 270 }
    },
    ["tripla"] = {
        { 2, 90 },
        { 0, 0 },
        { 2, 270 }
    }
}

--- desenha cada ligação
---@param a number
---@param b number
---@param ligacao Ligacao
local function desenhar_ligacoes(a, b, ligacao)
    local angulo_ligacao = angulos_ligacoes[ligacao.qtd_eletrons or "simples"]

    for i = #angulo_ligacao, 1, -1 do
        local orbita = angulo_ligacao[i][1]
        local angulo_orbita = GrausParaRadianos(angulo_ligacao[i][2])

        local angulo = CalcularAngulo(coordenadas[a], coordenadas[b])
        local angulo_antipodal = angulo + math.pi

        local acoord = Coordenada:polar(angulo, distancia_atomo_ligacao)
        acoord:soma(coordenadas[a])
        local orbita_a = Coordenada:polar(angulo + angulo_orbita, orbita)
        orbita_a:soma(acoord)

        local bcoord = Coordenada:polar(angulo_antipodal, distancia_atomo_ligacao)
        bcoord:soma(coordenadas[b])
        local orbita_b = Coordenada:polar(angulo_antipodal - angulo_orbita, orbita)
        orbita_b:soma(bcoord)

        svg:linha(orbita_a, orbita_b)
    end
end

MOLECULA.ligacoes:andar(desenhar_ligacoes)
SAIDA = svg:construir()
