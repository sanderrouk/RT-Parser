import Vapor
import Data

public final class LawParserController: RouteCollection {

    private let group: [PathComponentsRepresentable]

    public init(group: PathComponentsRepresentable...) {
        self.group = group
    }

    public func boot(router: Router) throws {
        let routeGroup = router.grouped(group)
        routeGroup.get("/parse-law", use: parseLaw)
    }

    public func parseLaw(request: Request) throws -> EventLoopFuture<String> {
        let future = request.eventLoop.newPromise(of: String.self)
        future.succeed(result: "Hello")
        return future.futureResult
    }
}

