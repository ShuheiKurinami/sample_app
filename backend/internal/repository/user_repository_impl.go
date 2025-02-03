package repository

import (
	"database/sql"
	"errors"
	"sample_app/backend/internal/domain"
	"time"
)

type PostgresUserRepository struct {
	db *sql.DB
}

func NewPostgresUserRepository(db *sql.DB) *PostgresUserRepository {
	return &PostgresUserRepository{db: db}
}

func (r *PostgresUserRepository) Create(user domain.User) (domain.User, error) {
	now := time.Now()
	query := `INSERT INTO users (name, email, created_at, updated_at) VALUES ($1, $2, $3, $4) RETURNING id`
	err := r.db.QueryRow(query, user.Name, user.Email, now, now).Scan(&user.ID)
	if err != nil {
		return user, err
	}
	user.CreatedAt = now
	user.UpdatedAt = now
	return user, nil
}

func (r *PostgresUserRepository) Update(user domain.User) (domain.User, error) {
	now := time.Now()
	query := `UPDATE users SET name=$1, email=$2, updated_at=$3 WHERE id=$4`
	res, err := r.db.Exec(query, user.Name, user.Email, now, user.ID)
	if err != nil {
		return user, err
	}
	rows, err := res.RowsAffected()
	if err != nil || rows == 0 {
		return user, errors.New("user not found")
	}
	user.UpdatedAt = now
	return user, nil
}

func (r *PostgresUserRepository) Delete(id int) error {
	query := `DELETE FROM users WHERE id=$1`
	res, err := r.db.Exec(query, id)
	if err != nil {
		return err
	}
	rows, err := res.RowsAffected()
	if err != nil || rows == 0 {
		return errors.New("user not found")
	}
	return nil
}

func (r *PostgresUserRepository) List() ([]domain.User, error) {
	query := `SELECT id, name, email, created_at, updated_at FROM users`
	rows, err := r.db.Query(query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var users []domain.User
	for rows.Next() {
		var user domain.User
		if err := rows.Scan(&user.ID, &user.Name, &user.Email, &user.CreatedAt, &user.UpdatedAt); err != nil {
			return nil, err
		}
		users = append(users, user)
	}
	return users, nil
}
