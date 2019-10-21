import Vapor
import OpenApi

// MARK: Content

/// Data required to create a user.
public struct CreateUserRequest: Content {
    /// User's full name.
    public var name: String

    /// User's email address.
    public var email: String

    /// User's desired password.
    public var password: String

    /// User's password repeated to ensure they typed it correctly.
    public var verifyPassword: String
}

extension CreateUserRequest: Documentable {
    public static func defineDocumentation() {
        OpenApi.defineObject(object:
            CreateUserRequest(
                name: "John Smith",
                email: "john@example.com",
                password: "Password123",
                verifyPassword: "Password123"
            )
        )
    }
}
