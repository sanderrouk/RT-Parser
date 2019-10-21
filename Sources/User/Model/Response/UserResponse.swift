import Vapor
import OpenApi

/// Public representation of user data.
public struct UserResponse: Content {
    /// User's unique identifier.
    /// Not optional since we only return users that exist in the DB.
    public var id: Int

    /// User's full name.
    public var name: String

    /// User's email address.
    public var email: String
}

extension UserResponse: Documentable {
    public static func defineDocumentation() {
        OpenApi.defineObject(object:
            UserResponse(
                id: 1,
                name: "John Smith",
                email: "john@example.com"
            )
        )
    }
}
