
---@class Svg
---@field conteudo string
---@field min_x number
---@field min_y number
---@field max_x number
---@field max_y number
local Svg = {}
Svg.__index = Svg

function Svg:new()
    local obj = setmetatable({}, Svg)

    obj.conteudo = ""
    obj.min_x = 0
    obj.min_y = 0
    obj.max_x = 0
    obj.max_y = 0

    return obj
end

---Desenha uma linha entre ponto (ax, ay) e (bx, by) 
---@param a Coordenada
---@param b Coordenada
---@param nomeClasse string?
function Svg:linha(a, b, nomeClasse)
    self:checar_bordas(a.x, a.y)
    self:checar_bordas(b.x, b.y)

    if nomeClasse == nil then nomeClasse = 'svg-ligation' end

    local linha = '<line class="%s" x1="%g" y1="%g" x2="%g" y2="%g"></line>'
    self.conteudo = self.conteudo .. string.format(linha, nomeClasse, a.x, a.y, b.x, b.y)
end

---Desenha um circulo centrado empty (x, y) com raio (r)
---@param x number
---@param y number
---@param r number
function Svg:circle(x, y, r)
    self:checar_bordas(x, y)
    local linha = '<circle class="svg-eletrons" cx="%g" cy="%g" r="%g"></circle>'
    self.conteudo = self.conteudo .. string.format(linha, x, y, r)
end

---Desenha um texto (simbolo) em (x, y)
---@param simbolo string
---@param coord Coordenada
function Svg:texto(simbolo, coord)
    self:checar_bordas(coord.x, coord.y)
    local linha = '<text class="svg-element svg-element-%s" x="%g" y="%g">%s</text>'
    self.conteudo = self.conteudo .. string.format(linha, simbolo, coord.x, coord.y, simbolo)
end

---Desenha um subtexto (simbolo) em (x, y)
---@param simbolo string
---@param x number
---@param y number
function Svg:subtext(simbolo, x, y)
    self:checar_bordas(x, y)
    local linha = '<circle class="svg-element-charge-border" cx="%g" cy="%g"/><text class="svg-element-charge" x="%g" y="%g">%s</text>'
    self.conteudo = self.conteudo .. string.format(linha, x, y, x, y, simbolo)
end

---define posicao minima e maximo das bordas
---@param x number
---@param y number
function Svg:checar_bordas(x, y)
    if self.min_x < x then self.min_x = x end
    if self.min_y < y then self.min_y = y end
    if self.max_x < x then self.max_x = x end
    if self.max_y < y then self.max_y = y end
end

---constroe o codigo svg e associa a templates
---@return string
function Svg:build()
    require "configuration"

    local css_file = io.open(SUNA_CSS, "r")
    if css_file == nil then
        print("template 'suna.css' não encontrado")
        os.exit(1)
    end

    local css = css_file:read("*a")
    css = css:gsub("[\n|\t]","")
    io.close(css_file)

    local svg_template_file = io.open(SUNA_TEMP_SVG, "r")
    if svg_template_file == nil then
        print("template 'suna.temp.svg' não encontrado")
        os.exit(1)
    end

    local svg_template = svg_template_file:read("*a")
    io.close(svg_template_file)

    local start_x = -SVG_BORDER
    local start_y = -SVG_BORDER
    local end_x = self.max_x + SVG_BORDER * 2
    local end_y = self.max_y + SVG_BORDER * 2

    local svg = string.format(svg_template, start_x, start_y, end_x, end_y, css, self.conteudo)
    return svg
end

return Svg