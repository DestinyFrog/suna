
---@class Coordenada
---@field x number
---@field y number
local Coordenada = {}
Coordenada.__index = Coordenada

---constructor de coordenada
---@param x number
---@param y number?
---@return Coordenada
function Coordenada:new(x, y)
    local obj = setmetatable({}, Coordenada)

    if y == nil then y = x end
    obj.x = x
    obj.y = y

    return obj
end

---constructor de coordenada com padrao zero
---@return Coordenada
function Coordenada:zero()
    local obj = setmetatable({}, Coordenada)
    obj.x = 0
    obj.y = 0
    return obj
end

---constructor de coordenadas polares
---@param ang number angulo em radianos
---@param r number raio
---@return Coordenada
function Coordenada:polar(ang, r)
    local obj = setmetatable({}, Coordenada)
    obj.x = r * math.cos(ang)
    obj.y = r * math.sin(ang)
    return obj
end

---constructor de coordenada com padrao absoluto
---@param x number
---@param y number
---@return Coordenada
function Coordenada:abs(x, y)
    local obj = setmetatable({}, Coordenada)
    obj.x = math.abs(x)
    obj.y = math.abs(y)
    return obj
end

---calcula o valor minimo entre varias coordenadas
---@param coordenadas Coordenada[]
---@return Coordenada
function Coordenada.min(coordenadas)
    local min = Coordenada:new(math.maxinteger)

    for _, coordenada in pairs(coordenadas) do
        if coordenada.x < min.x then min.x = coordenada.x end
        if coordenada.y < min.y then min.y = coordenada.y end
    end

    return min
end

---calcula o valor minimo entre varias coordenadas
---@param coordenadas Coordenada[]
---@param fn fun(indice: number, coordenada: Coordenada): boolean
---@return Coordenada[]
function Coordenada.filter(coordenadas, fn)
    local nova_coordenadas = {}

    for indice, coordenada in pairs(coordenadas) do
        if fn(indice, coordenada) then
            table.insert(nova_coordenadas, coordenada)
        end
    end

    return nova_coordenadas
end

---soma uma coordenada com outra
---@param coord Coordenada
function Coordenada:soma(coord)
    self.x = self.x + coord.x
    self.y = self.y + coord.y
end

---soma uma varias coordenadas por uma unica
---@param coords Coordenada[]
---@param soma_coord Coordenada
function Coordenada:somar_por(coords, soma_coord)
    for _, coord in pairs(coords) do
        coord:soma(soma_coord)
    end
end

return Coordenada