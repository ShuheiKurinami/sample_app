package usecase

import (
	"sample_app/backend/internal/domain"
	"sample_app/backend/internal/repository"
)

type UserUsecase struct {
	repo repository.UserRepository
}

func NewUserUsecase(r repository.UserRepository) *UserUsecase {
	return &UserUsecase{repo: r}
}

func (u *UserUsecase) CreateUser(user domain.User) (domain.User, error) {
	return u.repo.Create(user)
}

func (u *UserUsecase) UpdateUser(user domain.User) (domain.User, error) {
	return u.repo.Update(user)
}

func (u *UserUsecase) DeleteUser(id int) error {
	return u.repo.Delete(id)
}

func (u *UserUsecase) ListUsers() ([]domain.User, error) {
	return u.repo.List()
}
