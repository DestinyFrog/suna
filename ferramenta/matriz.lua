---@class Matriz
---@field private colunas table
local Matriz = {
    nullValue = 0
}
Matriz.__index = Matriz

--- construtor de matriz
---@param colunas_num number
---@return Matriz
function Matriz:new(colunas_num, linha_num)
    local obj = setmetatable({}, self)

    if colunas_num == nil then colunas_num = 0 end
    if linha_num == nil then linha_num = colunas_num end

    obj.colunas = {}
    for _ = 1, colunas_num do
        table.insert(obj.colunas, {})
    end

    for _ = 1, linha_num do
        for j = 1, colunas_num do
            table.insert(obj.colunas[j], self.nullValue)
        end
    end

    return obj
end

--- retorna o valor de uma posicao
---@param coluna number | Coordenada
---@param linha number?
---@return number
function Matriz:get(coluna, linha)
    local x = nil
    local y = nil

    if type(coluna) == "number" then
        x = coluna
        y = linha
    else
        x = coluna.x
        y = coluna.y
    end

    if x == nil or y == nil then
        return self.nullValue
    end
    return self.colunas[x][y]
end

--- define o valor de uma posicao
---@param valor any
---@param coluna number | Coordenada
---@param linha number?
function Matriz:set(valor, coluna, linha)
    local x = nil
    local y = nil

    if type(coluna) == "number" then
        x = coluna
        y = linha
    else
        x = coluna.x
        y = coluna.y
    end

    if x == nil or y == nil then
        return
    end

    self.colunas[x][y] = valor
end

--- pega coluna da matriz
---@param x number
---@return any[]
function Matriz:get_coluna(x)
    return self.colunas[x]
end

--- adiciona uma coluna na matriz
--- cada linha recebe o valor nullValue
function Matriz:add_coluna()
    table.insert(self.colunas, {})
    for i = 1, #self.colunas[1] do
        self.colunas[#self.colunas][i] = self.nullValue
    end
end

--- adiciona uma linha na matriz
--- cada coluna recebe o valor nullValue
function Matriz:add_linha()
    for i = 1, #self.colunas do
        table.insert(self.colunas[i], self.nullValue)
    end
end

--- adiciona uma linha e uma coluna na matriz
--- cada coluna recebe o valor nullValue
--- cada linha recebe o valor nullValue
function Matriz:add_vetor()
    self:add_coluna()
    self:add_linha()
end

--- roda uma função pelos elementos da matriz
---@param fn fun(a:number, b:number, valor:any)
function Matriz:andar(fn)
    for a, coluna in ipairs(self.colunas) do
        for b, value in ipairs(coluna) do
            if value ~= self.nullValue then
                fn(a, b, value)
            end
        end
    end
end

return Matriz