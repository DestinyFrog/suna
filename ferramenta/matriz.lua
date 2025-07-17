
---@class Matriz
---@field colunas any[][]
---@field private colunas_num number
local Matriz = {}
Matriz.__self = Matriz

---construtor de matriz
---@param colunas_num number?
---@param linhas_num number?
function Matriz:new(colunas_num, linhas_num)
    local obj = setmetatable({}, Matriz)

    if colunas_num == nil then colunas_num = 0 end
    if linhas_num == nil then linhas_num = 0 end

    obj.colunas_num = colunas_num

    local colunas = {}
    for  _ = 1, colunas_num do
        table.insert(colunas, {})
    end

    for _, coluna in ipairs(colunas) do
        for _ = 1, linhas_num do
            table.insert(coluna, nil)
        end
    end

    obj.colunas = colunas

    return obj
end

function Matriz:adiciona_vetor()
    self:adiciona_coluna()
    self:adiciona_linha()
end

function Matriz:adiciona_coluna()
    local coluna = {}

    for _ = 1, self.colunas_num do
        table.insert(coluna, {})
    end

    table.insert(self.colunas, coluna)
    self.colunas_num = #self.colunas
end

function Matriz:adiciona_linha()
    for _, coluna in ipairs(self.colunas) do
        table.insert(coluna, {})
    end
end

---define um valor na matriz
---@param x number
---@param y number
---@param valor any
function Matriz:set(x, y, valor)
    self.colunas[x][y] = valor
end

function Matriz:walk()

end

return Matriz