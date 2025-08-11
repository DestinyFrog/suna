package routes

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"

	config "suna/v2/config"
	database "suna/v2/database"
	models "suna/v2/models"
)

func GetAllElements(w http.ResponseWriter, r *http.Request) {
	elements := []models.Element{}

	scanRows := func(rows *sql.Rows) error {
		for rows.Next() {
			var element models.Element
			err := element.Scan(rows)
			if err != nil {
				return err
			}
			elements = append(elements, element)
		}
		return nil
	}

	err := database.RunQuery(scanRows, "get_all_element")
	if err != nil {
		config.Write(w, err)
		return
	}

	jsonData, err := json.Marshal(elements)
	if err != nil {
		config.Write(w, err)
		return
	}

	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

	w.Header().Set("Content-Type", "application/json")
	fmt.Fprintf(w, "%s", string(jsonData))
}

func GetOneElementById(w http.ResponseWriter, r *http.Request) {
	atomic_number := r.URL.Query().Get("atomic_number")

	element := models.Element{}

	scanRows := func(rows *sql.Rows) error {
		rows.Next()
		err := element.Scan(rows)
		if err != nil {
			return err
		}
		return nil
	}

	err := database.RunQuery(scanRows, "get_one_element", atomic_number)
	if err != nil {
		config.Write(w, err)
		return
	}

	jsonData, err := json.Marshal(element)
	if err != nil {
		config.Write(w, err)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	fmt.Fprintf(w, "%s", string(jsonData))
}

func SearchOneElement(w http.ResponseWriter, r *http.Request) {
	term := r.URL.Query().Get("term")

	elements := []models.Element{}

	scanRows := func(rows *sql.Rows) error {
		for rows.Next() {
			var element models.Element
			err := element.Scan(rows)
			if err != nil {
				return err
			}
			elements = append(elements, element)
		}
		return nil
	}

	err := database.RunQuery(scanRows, "search_element", term, fmt.Sprintf("%%%s%%", term))
	if err != nil {
		config.Write(w, err)
		return
	}

	jsonData, err := json.Marshal(elements)
	if err != nil {
		config.Write(w, err)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	fmt.Fprintf(w, "%s", string(jsonData))
}
