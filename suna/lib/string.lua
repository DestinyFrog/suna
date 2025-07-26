
local String = {}

--- split a string based on a separator
---@param str string
---@param separator string?
function String.split(str, separator)
    separator = separator or " "
    local result = {}
    local pattern = string.format("([^%s]+)", separator)
    for substr in string.gmatch(str, pattern) do
        table.insert(result, substr)
    end
    return result
end

return setmetatable( String, { __index = string } )