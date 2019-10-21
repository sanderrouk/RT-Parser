import Authentication
import FluentSQLite
import Vapor

/// A registered user, capable of owning todo items.
public final class User: SQLiteModel {
    /// User's unique identifier.
    /// Can be `nil` if the user has not been saved yet.
    public var id: Int?

    /// User's full name.
    public var name: String

    /// User's email address.
    public var email: String

    /// BCrypt hash of the user's password.
    public var passwordHash: String

    /// Creates a new `User`.
    public init(id: Int? = nil, name: String, email: String, passwordHash: String) {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
    }
}

/// Allows users to be verified by basic / password auth middleware.
extension User: PasswordAuthenticatable {
    /// See `PasswordAuthenticatable`.
    public static var usernameKey: WritableKeyPath<User, String> {
        return \.email
    }

    /// See `PasswordAuthenticatable`.
    public static var passwordKey: WritableKeyPath<User, String> {
        return \.passwordHash
    }
}

/// Allows users to be verified by bearer / token auth middleware.
extension User: TokenAuthenticatable {
    /// See `TokenAuthenticatable`.
    public typealias TokenType = UserToken
}

/// Allows `User` to be used as a Fluent migration.
extension User: Migration {
    /// See `Migration`.
    public static func prepare(on conn: SQLiteConnection) -> Future<Void> {
        return SQLiteDatabase.create(User.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.name)
            builder.field(for: \.email)
            builder.field(for: \.passwordHash)
            builder.unique(on: \.email)
        }
    }
}

/// Allows `User` to be encoded to and decoded from HTTP messages.
extension User: Content { }

/// Allows `User` to be used as a dynamic parameter in route definitions.
extension User: Parameter { }
