import Vapor
import Data

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
        routeGroup.get("/parse-law", use: parseLaw)
    }

    public func parseLaw(request: Request) throws -> EventLoopFuture<[LawSection]> {
        return lawParsingService.parseBy(abbrevation: "TODO")
    }
}

