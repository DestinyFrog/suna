
---@class Matrix
---@field private cols table
local Matrix = { nullValue = 0 }
Matrix.__index = Matrix

--- Matrix constructor
---@param num_cols number?
---@param num_rows number?
---@return Matrix
function Matrix.new(num_cols, num_rows)
    local obj = setmetatable({}, Matrix)

    if num_cols == nil then num_cols = 0 end
    if num_rows == nil then num_rows = num_cols end

    obj.cols = {}

    for _ = 1, num_cols do
        table.insert(obj.cols, {})
    end

    for _ = 1, num_rows do
        for j = 1, num_rows do
            table.insert(obj.cols[j], Matrix.nullValue)
        end
    end

    return obj
end

--- get the value at a specific position
--- @param col number | {x: number, y: number}
--- @return any
function Matrix:get(col, row)
    local x, y

    if type(col) == "number" then
        x = col
        y = row
    else
        x = col.x
        y = col.y
    end

    if x == nil or y == nil then
        return self.nullValue
    end

    return self.cols[x][y]
end

--- set the value at a specific position
---@param value any
---@param col number
---@param row number
function Matrix:set(value, col, row)
    self.cols[col][row] = value
end

--- get a column from the matrix by index
--- @param x number
--- @return any[]
function Matrix:get_column(x)
    return self.cols[x]
end

--- add a new column to the matrix
--- each row receives the nullValue
function Matrix:add_column()
    table.insert(self.cols, {})
    for i = 1, #self.cols[1] do
        self.cols[#self.cols][i] = self.nullValue
    end
end

--- add a new line to the matrix
--- each column receives the nullValue
function Matrix:add_line()
    for i = 1, #self.cols do
        table.insert(self.cols[i], self.nullValue)
    end
end

--- add a column and a row to the matrix
--- each element receives the nullValue
function Matrix:add_vector()
    self:add_column()
    self:add_line()
end

--- run a function over the elements of the matrix
---@param fn fun(a:number, b:number, value:any)
function Matrix:walk(fn)
    for a, coluna in ipairs(self.cols) do
        for b, value in ipairs(coluna) do
            if value ~= self.nullValue then
                fn(a, b, value)
            end
        end
    end
end

return Matrix