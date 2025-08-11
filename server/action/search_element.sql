
select
    `atomic_number`,
    `oficial_name`,
    `atomic_radius`,
    `category`,
    `atomic_mass`,
    `eletronegativity`,
    `period`,
    `family`,
    `symbol`,
    `fase`,
    `xpos`,
    `ypos`,
    `layers`,
    `eletronic_configuration`,
    `oxidation_state`,
    `discovery`,
    `discovery_year`,
    `another_names`,
    `latin_name`,
    `name_meaning`
from `element`
where
    atomic_number = $1 or
    oficial_name like $2 or
    category like $2 or
    symbol like $2 or
    discovery like $2 or
    another_names like $2 or
    latin_name like $2