import Vapor
import OpenApi

// MARK: Content

/// Represents data required to create a new todo.
public struct CreateTodoRequest: Content {
    /// Todo title.
    var title: String
}

extension CreateTodoRequest: Documentable {
    public static func defineDocumentation() {
        OpenApi.defineObject(object:
            CreateTodoRequest(title: "Todo Title")
        )
    }
}

