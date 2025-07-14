
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
local Ligacao = {}
Ligacao.__index = Ligacao

---construtor de ligaçao
---@param qtd_eletrons QuantidadeEletrons?
---@param tipo TipoLigacao?
---@return Ligacao
function Ligacao:new(qtd_eletrons, tipo)
    local self = setmetatable({}, Ligacao)

    self.qtd_eletrons = qtd_eletrons or 'simples'
    self.tipo = tipo or 'covalente'

    return self
end

return Ligacao