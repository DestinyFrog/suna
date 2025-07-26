local Coordinate = require "suna.lib.coordinate"
local Svg = require "suna.lib.svg"
local Math = require "suna.lib.math"

local atoms_distance = 21
local atom_ligation_distance = 8

---@type Coordinate[]
local coordinates = {}

--- Treat each atom
---@param data WalkThroughAtoms
local function calc_atom_position(data)
    local coord = Coordinate.zero()

    if data.ligation ~= nil then
        local radiano = Math.degreesToRadians(data.ligation.angle)
        coord = Coordinate.polar(radiano, atoms_distance)

        local c = coordinates[data.last_index]
        coord:sum(c)
    end

    coordinates[data.current_index] = coord
end

MOLECULA:walk_through_atoms(calc_atom_position)

local min = Coordinate.min(coordinates)
local c = Coordinate.abs(min)
Coordinate.sum_many(coordinates, c)

local svg = Svg.new()

for index, coord in pairs(coordinates) do
    local atom = MOLECULA.atoms[index]
    svg:text(atom.symbol, coord)
end

local ligation_angles = {
    ["simple"] = {
        { 0, 0 }
    },
    ["double"] = {
        { 1, 90 },
        { 1, 270 }
    },
    ["triple"] = {
        { 2, 90 },
        { 0, 0 },
        { 2, 270 }
    }
}

--- draw each ligation
---@param a number
---@param b number
---@param ligation Ligation
local function draw_ligations(a, b, ligation)
    local ligation_angle = ligation_angles[ligation.eletrons_number or "simple"]

    for i = #ligation_angle, 1, -1 do
        local orbit = ligation_angle[i][1]
        local angle_orbit = Math.degreesToRadians(ligation_angle[i][2])

        local angle = Coordinate.angle_between_two_points(coordinates[a], coordinates[b])
        local antipodal_angle = angle + math.pi

        local acoord = Coordinate.polar(angle, atom_ligation_distance)
        acoord:sum(coordinates[a])
        local orbit_a = Coordinate.polar(angle + angle_orbit, orbit)
        orbit_a:sum(acoord)

        local bcoord = Coordinate.polar(antipodal_angle, atom_ligation_distance)
        bcoord:sum(coordinates[b])
        local orbit_b = Coordinate.polar(antipodal_angle - angle_orbit, orbit)
        orbit_b:sum(bcoord)

        svg:line(orbit_a, orbit_b)
    end
end

MOLECULA.ligations:walk(draw_ligations)
OUTPUT = svg:build()
