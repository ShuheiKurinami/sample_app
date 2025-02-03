package http

import (
	"github.com/gin-gonic/gin"
	"sample_app/backend/internal/delivery/controller"
)

func RegisterRoutes(r *gin.Engine, ctrl *controller.UserController) {
	group := r.Group("/users")
	{
		group.POST("", ctrl.CreateUser)
		group.PUT("/:id", ctrl.UpdateUser)
		group.DELETE("/:id", ctrl.DeleteUser)
		group.GET("", ctrl.ListUsers)
	}
}
