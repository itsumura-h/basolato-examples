# framework
import basolato
# controller
# import app/controllers/welcome_controller
import app/controllers/sign_controller
import app/controllers/post_controller
# middleware
import app/middlewares/auth_middleware

var routes = newRoutes()
routes.middleware(".*", auth_middleware.checkCsrfTokenMiddleware)
routes.middleware(
  "^(?!.*(signin|signup|delete-account)).*$",
  auth_middleware.chrckAuthTokenMiddleware
)

routes.get("/signup", sign_controller.signUpPage)
routes.post("/signup", sign_controller.signUp)

routes.get("/signin", sign_controller.signInPage)
routes.post("/signin", sign_controller.signIn)
routes.post("/signout", sign_controller.signOut)

routes.get("/delete-account", sign_controller.deleteAccountPage)
routes.post("/delete-account", sign_controller.deleteAccount)

routes.get("/", post_controller.index)
routes.post("/", post_controller.store)
routes.post("/change-status/{id:int}", post_controller.changeStatus)
routes.post("/delete/{id:int}", post_controller.destroy)
routes.get("/{id:int}", post_controller.show)
routes.post("/{id:int}", post_controller.update)

serve(routes)
