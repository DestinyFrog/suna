require "os"
local Plugins = require "suna.plugins.plugins"

local input_file_name = arg[1] or nil
local output_file_name = "out.svg"
local plugin_name = "standard"
local print_output = true

if input_file_name == nil then
    print "input file not informed"
    os.exit(1)
end

for i = 1, #arg do
    if arg[i] == '-s' then
        if i >= #arg then
            print "output file not informed"
            os.exit(1)
        end
        output_file_name = arg[i + 1]
    end

    if arg[i] == '-p' then
        if i >= #arg then
            print "plugin not informed"
            os.exit(1)
        end
        plugin_name = arg[i + 1]
    end

    if arg[i] == '-o' then
        print_output = false
    end
end

local plugin = Plugins[plugin_name]
if plugin == nil then
    print("plugin " .. plugin_name .. " not found")
    os.exit(1)
end

return {
    ["input_file_name"] = input_file_name,
    ["output_file_name"] = output_file_name,
    ["plugin"] = plugin,
    ["print_output"] = print_output,
}