import Vapor
import Data

public final class LawController: RouteCollection {
    
    private let lawService: LawService
    private let group: [PathComponentsRepresentable]

    public init(lawService: LawService, group: PathComponentsRepresentable...) {
        self.lawService = lawService
        self.group = group
    }
    
    public func boot(router: Router) throws {
        let routeGroup = router.grouped(group)
        routeGroup.get("/laws", use: findLaws)
        routeGroup.get("/categories-with-laws", use: findCategoriesWithLaws)

    }
    
    public func findLaws(request: Request) throws -> EventLoopFuture<[Law]> {
        return lawService.findLaws().map {
            if $0.isEmpty {
                throw Abort(.noContent)
            }
            
            return $0
        }
    }
    
    public func findCategoriesWithLaws(request: Request) throws -> EventLoopFuture<[LawCategoryWithLaws]> {
        return lawService.findCategoriesWithLaws().map {
            if $0.isEmpty {
                throw Abort(.noContent)
            }
            
            return $0
        }
    }
}
