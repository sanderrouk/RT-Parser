import Vapor

public final class ReDocController: RouteCollection {

    private let group: [PathComponentsRepresentable]

    public init(group: PathComponentsRepresentable...) {
        self.group = group
    }

    public func boot(router: Router) throws {
        let routeGroup = router.grouped(group)
        routeGroup.get("docs", use: documentation)
    }

    public func documentation(request: Request) throws -> Future<Response> {
        let dirs: DirectoryConfig = try request.make()
        return try request.streamFile(at: dirs.workDir + "Public/ReDoc.html")
    }
}
