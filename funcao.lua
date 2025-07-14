
function DividirString(texto, separador)
    separador = separador or " "
    local resultado = {}
    local padrao = string.format("([^%s]+)", separador)

    for parte in string.gmatch(texto, padrao) do
        table.insert(resultado, parte)
    end

    return resultado
end
