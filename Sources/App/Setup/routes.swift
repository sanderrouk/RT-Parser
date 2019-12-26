import Vapor
import Data
import OpenApi
import LawHierarchy
import LawParser

/// Register your application's routes here.
public func routes(_ router: Router, _ container: Container) throws {
    // Route Groups
    let emptyRouteGroup = ""
    let v1RouteGroup: [PathComponentsRepresentable] =  ["api", "v1"]

    // Law Hierarchy
    let lawService = try container.make(LawService.self)
    let lawController = LawController(lawService: lawService, group: v1RouteGroup)

    // Law Parser
    let lawParserController = LawParserController(group: v1RouteGroup)

    let controllers: [RouteCollection] = [
        ApiSpecController(group: emptyRouteGroup),
        ReDocController(group: emptyRouteGroup),
        lawController,
        lawParserController
    ]

    try controllers.forEach { try router.register(collection: $0) }
}
