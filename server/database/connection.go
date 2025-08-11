package database

import (
	"database/sql"
	"fmt"
	"os"

	_ "github.com/mattn/go-sqlite3"
)

func GetConnection() (*sql.DB, error) {
	db, err := sql.Open("sqlite3", "../suna.db")
	if err != nil {
		return nil, err
	}
	return db, nil
}

func RunQuery(operation func(*sql.Rows) error, queryName string, params ...any) error {
	conn, err := GetConnection()
	if err != nil {
		return err
	}
	defer conn.Close()

	queryFile := fmt.Sprintf("./action/%s.sql", queryName)

	sql, err := os.ReadFile(queryFile)
	if err != nil {
		return err
	}

	sql_str := string(sql)
	rows, err := conn.Query(sql_str, params...)
	if err != nil {
		return err
	}

	if err := operation(rows); err != nil {
		return err
	}

	rows.Close()
	return nil
}
