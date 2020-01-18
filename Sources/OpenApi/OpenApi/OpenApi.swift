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
            title: "Riigiteataja Parser API",
            version: "0.1.0",
            description: "Riigiteataja parser (RT-Parser) is a simple API which can be used as an intermediary between your app or service and the Estonian legislative portal, Riigiteatja. What RT-Parser does is very simple. It takes the XML of a legislative act provided by Riigiteataja and converts it to JSON. The internal cache of the service is updated on 12 hour interwals. The project's GitHub and source code can be found here: https://github.com/sanderrouk/RT-Parser",
            contact: APIContact(
                name: "Rouk OÜ",
                email: nil,
                url: URL(string: "https://github.com/sanderrouk/RT-Parser")
            ),
            license: APILicense(
                name: "MIT",
                url: URL(string: "https://opensource.org/licenses/MIT")
            ),
            authorizations: [.anonymous]
        )
    }

    private static func build() -> OpenAPIDocument {
        return instance.built()
    }
}
