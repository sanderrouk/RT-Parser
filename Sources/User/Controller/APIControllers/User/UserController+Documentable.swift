import Data
import OpenApi

extension UserController: Documentable {
    public static func defineDocumentation() {
        let login =
            OpenApi.defineAction(
                method: .post,
                route: "/api/v1/login",
                summary: "Get Bearer Token",
                description: "Login to get bearer token.",
                responses: [
                    OpenApi.response(
                        code: "200",
                        description: "Logged in successfully.",
                        object: UserToken.self
                    )
                ],
                authorization: true
        )

        let create =
            OpenApi.defineAction(
                method: .post,
                route: "/api/v1/users",
                summary: "Create User",
                description: "Create a User",
                request:
                OpenApi.request(
                    object: User.self,
                    description: "Create user request.",
                    contentType: "application/json"
                ),
                responses: [
                    OpenApi.response(
                        code: "200",
                        description: "User created successfully.",
                        object: UserResponse.self
                    )
                ],
                authorization: false
        )

        let getAllUsersWithTodos =
            OpenApi.defineAction(
                method: .get,
                route: "/api/v1/users",
                summary: "Get all Users with Todos",
                description: "Returns all Users and the corresponding Todos for the Users",
                responses: [
                    OpenApi.response(
                        code: "200",
                        description: "Successfully returned all Users with Todos",
                        array:  UserWithTodos.self
                    )
                ],
                authorization: false
        )

        OpenApi.defineController(
            name: "User Controller",
            description: "Authenticate and create users",
            actions: [login, create, getAllUsersWithTodos])
    }
}
