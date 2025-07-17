require "os"
local Molecula = require "modelo.molecula"
local Tokens = require "tokens"

MOLECULA = Molecula:new()

local arquivo_entrada_nome = "exemplos/benzeno.bin.suna"
local arquivo_entrada = io.open(arquivo_entrada_nome, "r")

if arquivo_entrada == nil then
    print "arquivo de entrada não encontrado"
    os.exit(1)
end

for line in arquivo_entrada:lines() do
    Tokens.tokenizar(MOLECULA, line)
end
arquivo_entrada:close()

print(MOLECULA:print())

require "plugins.padrao"

local arquivo_saida = io.open("out.svg", "w")
if arquivo_saida == nil then
    print "arquivo de saída não encontrado"
    os.exit(1)
end

arquivo_saida:write(SAIDA)
arquivo_saida:close()