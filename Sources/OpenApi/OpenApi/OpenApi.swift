import Swiftgger
import Foundation
import Vapor

public final class OpenApi {

    public typealias defineAction = APIAction
    public typealias request = APIRequest
    public typealias response = APIResponse
    public typealias parameter = APIParameter
    public typealias dataType = APIDataType
    public typealias location = APILocation

    private static let instance = initializeApiBuilder()

    public static func defineObject(object: Any) {
        _ = instance.add([APIObject(object: object)])
    }

    public static func defineController(name: String, description: String, externalDocs: APILink? = nil, actions: [APIAction] = []) {
        _ = instance.add(APIController(name: name, description: description, externalDocs: externalDocs, actions: actions))
    }

    internal static func serializedApiSpec() throws -> String {
        let data = try JSONEncoder().encode(build())
        guard let serializedData = String(data: data, encoding: .utf8) else { throw Abort(.internalServerError) }
        return serializedData
    }

    private static func initializeApiBuilder() -> OpenAPIBuilder {
        return OpenAPIBuilder(
            title: "Example API",
            version: "1.0.0",
            description: "This is an open api for the Example service.",
            contact: APIContact(name: "Sander Rõuk", email: "sander@rouk.io", url: URL(string: "https://rouk.io")),
            license: APILicense(name: "MIT", url: URL(string: "https://opensource.org/licenses/MIT")),
            authorizations: [
                .basic(description: "Basic auth is used for the `Login` endpoint."),
                .jwt(description: "Get the bearer token using `Login` endpoint. The Token is not a JWT like the docs state, that is a bug.")
            ]
        )
    }

    private static func build() -> OpenAPIDocument {
        return instance.built()
    }
}
