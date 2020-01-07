import Data
import Vapor

public final class LawParserController: RouteCollection {

    private let lawParsingService: LawParsingService
    private let group: [PathComponentsRepresentable]

    public init(
        lawParsingService: LawParsingService,
        group: PathComponentsRepresentable...
    ) {
        self.lawParsingService = lawParsingService
        self.group = group
    }

    public func boot(router: Router) throws {
        let routeGroup = router.grouped(group)
        routeGroup.get(["/parse-law", String.parameter], use: parseLaw)
    }

    public func parseLaw(_ request: Request) throws -> EventLoopFuture<LawBody> {
        let abbreviation = try request.parameters.next(String.self)
        return lawParsingService.parseBy(abbreviation: abbreviation)
    }
}
