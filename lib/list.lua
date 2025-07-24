
Table = {}
Table.__index = table

--- filter a list based on a function that takes
--- the element and its index as arguments.
--- Returns a new list containing only the elements
--- for which the function returned true.
---@param list any[]
---@param fn fun(element:any, index:number): boolean
---@return any[]
function Table.filter(list, fn)
    local new_list = {}
    for index, element in pairs(list) do
        if fn(element, index) then
            table.insert(new_list, element)
        end
    end
    return new_list
end

return Table