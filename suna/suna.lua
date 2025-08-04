require "os"
local Molecula = require "suna.models.molecula"
local Tokens = require "suna.tokens"
local Params = require "suna.params"

MOLECULA = Molecula.new()
OUTPUT = nil

local input_file = io.open(Params.input_file_name, "r")
if input_file == nil then
    print "input file not found"
    os.exit(1)
end

for line in input_file:lines() do
    Tokens.tokenize(MOLECULA, line)
end
input_file:close()

require(Params.plugin)

if Params.print_output == true then
    print(OUTPUT)
else
    local output_file = io.open(Params.output_file_name, "w")
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
end