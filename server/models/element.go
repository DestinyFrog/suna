package models

import (
	"database/sql"
	"encoding/json"
)

type Element struct {
	Atomic_number           int      `json:"atomic_number"`
	Oficial_name            string   `json:"oficial_name"`
	Atomic_radius           *float32 `json:"atomic_radius"`
	Category                string   `json:"category"`
	Atomic_mass             float32  `json:"atomic_mass"`
	Eletronegativity        *float32 `json:"eletronegativity"`
	Period                  int      `json:"period"`
	Family                  int      `json:"family"`
	Symbol                  string   `json:"symbol"`
	Fase                    string   `json:"fase"`
	Xpos                    int      `json:"xpos"`
	Ypos                    int      `json:"ypos"`
	Layers                  []int    `json:"layers"`
	Eletronic_configuration string   `json:"eletronic_configuration"`
	Oxidation_state         []int    `json:"oxidation_state"`
	Discovery               []string `json:"discovery"`
	Discovery_year          *int     `json:"discovery_year"`
	Another_names           []string `json:"another_names"`
	Latin_name              *string  `json:"latin_name"`
	Name_meaning            *string  `json:"name_meaning"`
}

func (e *Element) Scan(rows *sql.Rows) error {
	var layer_str,
		oxidation_state_str,
		discovery_str,
		another_names_str []byte

	err := rows.Scan(&e.Atomic_number, &e.Oficial_name, &e.Atomic_radius, &e.Category, &e.Atomic_mass, &e.Eletronegativity, &e.Period, &e.Family, &e.Symbol, &e.Fase, &e.Xpos, &e.Ypos, &layer_str, &e.Eletronic_configuration, &oxidation_state_str, &discovery_str, &e.Discovery_year, &another_names_str, &e.Latin_name, &e.Name_meaning)
	if err != nil {
		return err
	}

	if err := json.Unmarshal(layer_str, &e.Layers); err != nil {
		return err
	}

	if err := json.Unmarshal(oxidation_state_str, &e.Oxidation_state); err != nil {
		return err
	}

	if err := json.Unmarshal(discovery_str, &e.Discovery); err != nil {
		return err
	}

	if err := json.Unmarshal(another_names_str, &e.Another_names); err != nil {
		return err
	}

	return nil
}
