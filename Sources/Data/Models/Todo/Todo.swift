import FluentSQLite
import Vapor

/// A single entry of a todo list.
public final class Todo: SQLiteModel {
    /// The unique identifier for this `Todo`.
    public var id: Int?

    /// A title describing what this `Todo` entails.
    public var title: String

    /// Reference to user that owns this TODO.
    public var userID: User.ID

    /// Creates a new `Todo`.
    public init(id: Int? = nil, title: String, userID: User.ID) {
        self.id = id
        self.title = title
        self.userID = userID
    }
}

extension Todo {
    /// Fluent relation to user that owns this todo.
    public var user: Parent<Todo, User> {
        return parent(\.userID)
    }
}

/// Allows `Todo` to be used as a Fluent migration.
extension Todo: Migration {
    public static func prepare(on conn: SQLiteConnection) -> Future<Void> {
        return SQLiteDatabase.create(Todo.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.title)
            builder.field(for: \.userID)
            builder.reference(from: \.userID, to: \User.id)
        }
    }
}

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension Todo: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Todo: Parameter { }
