require "os"
local Molecula = require "suna.models.molecula"
local Tokens = require "suna.tokens"
local Plugins = require "suna.plugins.plugins"

local input_file_name = arg[1] or nil
local output_file_name = "out.svg"
local plugin_name = "standard"

if input_file_name == nil then
    print "input file not found"
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
        plugin = arg[i + 1]
    end
end

MOLECULA = Molecula.new()
OUTPUT = nil

local input_file = io.open(input_file_name, "r")

if input_file == nil then
    print "input file not found"
    os.exit(1)
end

for line in input_file:lines() do
    Tokens.tokenize(MOLECULA, line)
end
input_file:close()

local plugin = Plugins[plugin_name]
if plugin == nil then
    print("plugin " .. plugin_name .. " not found")
    os.exit(1)
end
require(plugin)

local output_file = io.open(output_file_name, "w")
if output_file == nil then
    print "output file not found"
    os.exit(1)
end

if OUTPUT == nil then
    print "output content not found. possibly plugin error"
    os.exit(1)
end

output_file:write(OUTPUT)
output_file:close()