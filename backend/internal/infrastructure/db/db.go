package db

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"
)

type DBNodes struct {
	Nodes map[string]*sql.DB
}

func NewDBNodes() *DBNodes {
	return &DBNodes{Nodes: make(map[string]*sql.DB)}
}

func (d *DBNodes) AddNode(name, dsn string) error {
	db, err := sql.Open("postgres", dsn)
	if err != nil {
		return fmt.Errorf("node %s: %w", name, err)
	}
	if err := db.Ping(); err != nil {
		return fmt.Errorf("node %s ping: %w", name, err)
	}
	d.Nodes[name] = db
	return nil
}
