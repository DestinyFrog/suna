
function DividirString(texto, separador)
    separador = separador or " "
    local resultado = {}
    local padrao = string.format("([^%s]+)", separador)

    for parte in string.gmatch(texto, padrao) do
        table.insert(resultado, parte)
    end

    return resultado
end

function GrausParaRadianos(graus)
    return graus * (math.pi / 180)
end

---calculo angulo baseado em duas coordenadas
---@param a_coord Coordenada
---@param b_coord Coordenada
---@return number
function CalcularAngulo(a_coord, b_coord)
    local deltaX = b_coord.x - a_coord.x
    local deltaY = b_coord.y - a_coord.y
    local angulo = math.atan(deltaY, deltaX)
    return angulo
end
