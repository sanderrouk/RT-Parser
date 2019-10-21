import OpenApi
import Data
import Todo
import User

public func document() {
    let objects: [Documentable.Type] = [
        User.self,
        Todo.self,
        CreateTodoRequest.self,
        UserResponse.self,
        CreateUserRequest.self,
        UserToken.self,
        UserWithTodos.self
    ]

    let controllers: [Documentable.Type] = [
        TodoController.self,
        UserController.self
    ]

    (objects + controllers).forEach { $0.defineDocumentation() }
}
