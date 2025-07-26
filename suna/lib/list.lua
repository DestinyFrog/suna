
local List = {}

--- filter a list based on a function that takes
--- the element and its index as arguments.
--- Returns a new list containing only the elements
--- for which the function returned true.
---@param list any[]
---@param fn fun(element:any, index:number): boolean
---@return any[]
function List.filter(list, fn)
    local new_list = {}
    for index, element in pairs(list) do
        if fn(element, index) then
            table.insert(new_list, element)
        end
    end
    return new_list
end

--- returns keys of the array
---@param list any[]
---@return any[]
function List.keys(list)
    local new_list = {}
    for key, _ in pairs(list) do
        table.insert(new_list, key)
    end
    return new_list
end

--- filter a list based on a function that takes
--- the element and its index as arguments.
--- Returns a new list containing only the elements
--- for which the function returned true.
---@param list any[]
---@param value any
---@return boolean
function List.find(list, value)
    for _, element in pairs(list) do
        if element == value then
            return true
        end
    end
    return false
end

function List.print(list)
    print "["
    for key, value in pairs(list) do
        local line = string.format("\t(%s|%s): %s|type(%s)", key, type(key), value, type(value))
        print(line)
    end
    print "]"
end

return setmetatable( List, { __index = table } )