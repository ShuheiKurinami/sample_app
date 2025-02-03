package repository

import "sample_app/backend/internal/domain"

type UserRepository interface {
	Create(user domain.User) (domain.User, error)
	Update(user domain.User) (domain.User, error)
	Delete(id int) error
	List() ([]domain.User, error)
}
