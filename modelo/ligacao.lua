
---@alias QuantidadeEletrons
---| 'simples'
---| 'dupla'
---| 'tripla'

---@alias TipoLigacao
---| 'ionica'
---| 'covalente'
---| 'ligacao_de_hidrogenio'

---@class Ligacao
---@field qtd_eletrons QuantidadeEletrons
---@field tipo TipoLigacao
---@field angulo number?
local Ligacao = {}
Ligacao.__index = Ligacao

---construtor de ligaçao
---@param qtd_eletrons QuantidadeEletrons?
---@param tipo TipoLigacao?
---@param angulo number?
---@return Ligacao
function Ligacao:new(qtd_eletrons, tipo, angulo)
    local self = setmetatable({}, Ligacao)

    self.qtd_eletrons = qtd_eletrons or 'simples'
    self.tipo = tipo or 'covalente'
    self.angulo = angulo

    return self
end

return Ligacao