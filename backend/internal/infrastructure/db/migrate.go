package db

import "database/sql"

func MigrateCommonTables(db *sql.DB) error {
	query := `
	CREATE TABLE IF NOT EXISTS client_classes (
		id SERIAL PRIMARY KEY,
		name VARCHAR(50) NOT NULL,
		description TEXT
	);
	`
	_, err := db.Exec(query)
	return err
}

func MigrateNodeTables(db *sql.DB) error {
	query := `
	CREATE TABLE IF NOT EXISTS users (
		id SERIAL PRIMARY KEY,
		name VARCHAR(100),
		email VARCHAR(100),
		created_at TIMESTAMP,
		updated_at TIMESTAMP
	);
	`
	_, err := db.Exec(query)
	return err
}
