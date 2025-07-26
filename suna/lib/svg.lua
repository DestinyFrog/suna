require "suna.configuration"

---@class Svg
---@field content string
---@field min_x number
---@field min_y number
---@field max_x number
---@field max_y number
local Svg = {}
Svg.__index = Svg

function Svg.new()
    local obj = setmetatable({}, Svg)

    obj.content = ""
    obj.min_x = 0
    obj.min_y = 0
    obj.max_x = 0
    obj.max_y = 0

    return obj
end

--- Calculate minimun and max position in each decision
---@private
---@param coord Coordinate
function Svg:measure_size(coord)
    if self.min_x < coord.x then self.min_x = coord.x end
    if self.min_y < coord.y then self.min_y = coord.y end
    if self.max_x < coord.x then self.max_x = coord.x end
    if self.max_y < coord.y then self.max_y = coord.y end
end

--- Draw a line based in two coordinates
---@param a Coordinate
---@param b Coordinate
---@param className string?
function Svg:line(a, b, className)
    self:measure_size(a)
    self:measure_size(b)

    if className == nil then className = 'svg-ligation' end

    local line = '<line class="%s" x1="%g" y1="%g" x2="%g" y2="%g"></line>'
    self.content = self.content .. string.format(line, className, a.x, a.y, b.x, b.y)
end

--- Draw a circle centered in a coordinate
---@param coord Coordinate
---@param r number
function Svg:circle(coord, r)
    self:measure_size(coord)
    local line = '<circle class="svg-eletrons" cx="%g" cy="%g" r="%g"></circle>'
    self.content = self.content .. string.format(line, coord.x, coord.y, r)
end

--- Draw a text in a coordinate
---@param str string
---@param coord Coordinate
function Svg:text(str, coord)
    self:measure_size(coord)
    local line = '<text class="svg-element svg-element-%s" x="%g" y="%g">%s</text>'
    self.content = self.content .. string.format(line, str, coord.x, coord.y, str)
end

--- Draw a subtext in a coordinate
---@param str string
---@param coord Coordinate
function Svg:subtext(str, coord)
    self:measure_size(coord)
    local line = '<circle class="svg-element-charge-border" cx="%g" cy="%g"/><text class="svg-element-charge" x="%g" y="%g">%s</text>'
    self.content = self.content .. string.format(line, coord.x, coord.y, coord.x, coord.y, str)
end

--- load configurated template css file
---@return string
function Svg:load_css()
    local css_file = io.open(SUNA_CSS, "r")
    if css_file == nil then
        print("template 'suna.css' not found")
        os.exit(1)
    end

    local css = css_file:read("*a")
    io.close(css_file)

    return css
end

--- load configurated template svg template file
---@return string
function Svg:load_svg()
local svg_template_file = io.open(SUNA_TEMP_SVG, "r")
    if svg_template_file == nil then
        print("template 'suna.temp.svg' not found")
        os.exit(1)
    end

    local svg_template = svg_template_file:read("*a")
    io.close(svg_template_file)

    return svg_template
end

--- build the code svg
--- associating to configurated templates
---@return string
function Svg:build()
    local css = self:load_css()
    local svg_template = self:load_svg()

    local start_x = -SVG_BORDER
    local start_y = -SVG_BORDER
    local end_x = self.max_x + SVG_BORDER * 2
    local end_y = self.max_y + SVG_BORDER * 2

    local svg = string.format(svg_template, start_x, start_y, end_x, end_y, css, self.content)
    return svg
end

return Svg