
local distancia_atomos = 30
local distancia_atomo_ligacao = 8

---@class AtomosComPosicaoOrganica
---@field atomo Atomo
---@field x number
---@field y number
---@field hidrogenio_ligado_a_carbono boolean

---@type AtomosComPosicaoOrganica[]
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
        ["y"] = y,
        ["hidrogenio_ligado_a_carbono"] = data.atomo.simbolo == "H" and data.pai.simbolo == "C"
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

local cx = math.abs(min_x)
local cy = math.abs(min_y)

local Svg = require "ferramenta.svg"
local svg = Svg:new()

for _, atomo in pairs(atomos_com_posicao) do
    if atomo.atomo.simbolo ~= "C" and atomo.hidrogenio_ligado_a_carbono == false then
        svg:text(atomo.atomo.simbolo,
            cx + atomo.x,
            cy + atomo.y)
    end

end

for a, colunas in ipairs(MOLECULA.ligacoes) do
    for b, ligacao in ipairs(colunas) do
        if ligacao ~= 0 then
            if atomos_com_posicao[b].hidrogenio_ligado_a_carbono then
                goto continue
            end

            local angulo = CalcularAngulo(atomos_com_posicao[a].x, atomos_com_posicao[a].y, atomos_com_posicao[b].x, atomos_com_posicao[b].y)
            local angulo_antipodal = angulo + math.pi

            local distancia = distancia_atomo_ligacao
            if atomos_com_posicao[a].atomo.simbolo == "C"
                then distancia = 0 end

            local ax_com_distancia = distancia * math.cos(angulo)
            local ay_com_distancia = distancia * math.sin(angulo)
            local ax = cx + atomos_com_posicao[a].x + ax_com_distancia
            local ay = cy + atomos_com_posicao[a].y + ay_com_distancia

            distancia = distancia_atomo_ligacao
            if atomos_com_posicao[b].atomo.simbolo == "C"
                then distancia = 0 end

            local bx_com_distancia = distancia * math.cos(angulo_antipodal)
            local by_com_distancia = distancia * math.sin(angulo_antipodal)
            local bx = cx + atomos_com_posicao[b].x + bx_com_distancia
            local by = cy + atomos_com_posicao[b].y + by_com_distancia

            svg:line(ax, ay, bx, by)
        end

        ::continue::
    end
end

SAIDA = svg:build()