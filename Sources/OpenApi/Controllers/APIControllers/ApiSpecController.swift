import Vapor

public final class ApiSpecController: RouteCollection {

    private let group: [PathComponentsRepresentable]

    public init(group: PathComponentsRepresentable...) {
        self.group = group
    }

    public func boot(router: Router) throws {
        let routeGroup = router.grouped(group)
        routeGroup.get("/api-spec", use: apiSpec)
    }

    public func apiSpec(request: Request) throws -> String {
        return try OpenApi.serializedApiSpec()
    }
}

