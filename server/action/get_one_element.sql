
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
where `element`.`atomic_number` = $1