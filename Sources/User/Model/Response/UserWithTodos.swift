import Vapor
import Data
import OpenApi

/// In order to illustrate N+1 solution
public struct UserWithTodos: Content {
    public var id: Int
    public var name: String
    public var email: String
    public var todos: [Todo]
}

extension UserWithTodos: Documentable {
    public static func defineDocumentation() {
        OpenApi.defineObject(object:
            UserWithTodos(
                id: 1,
                name: "John Smith",
                email: "john@example.com",
                todos: [
                    Todo(id: 1, title: "Water Flowers", userID: 1),
                    Todo(id: 2, title: "Drink Milk", userID: 1)
                ]
            )
        )
    }
}
