package main

import (
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	httpDelivery "sample_app/backend/internal/delivery/http"
	"sample_app/backend/internal/delivery/controller"
	"sample_app/backend/internal/infrastructure/db"
	"sample_app/backend/internal/repository"
	"sample_app/backend/internal/usecase"
)

func main() {
	// .envの読み込み
	if err := godotenv.Load(); err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}

	nodes := db.NewDBNodes()
	if err := nodes.AddNode("node1", os.Getenv("NODE1_DSN")); err != nil {
		log.Fatalf("node1 error: %v", err)
	}
	if err := nodes.AddNode("node2", os.Getenv("NODE2_DSN")); err != nil {
		log.Fatalf("node2 error: %v", err)
	}

	// 例としてnode1を使用
	userRepo := repository.NewPostgresUserRepository(nodes.Nodes["node1"])
	userUC := usecase.NewUserUsecase(userRepo)
	userCtrl := controller.NewUserController(userUC)

	r := gin.Default()
	httpDelivery.RegisterRoutes(r, userCtrl)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	r.Run(":" + port)
}
