import Vapor
import Data
import OpenApi
import LawHierarchy

/// Register your application's routes here.
public func routes(_ router: Router, _ container: Container) throws {
    // Route Groups
    let emptyRouteGroup = ""
    let v1RouteGroup: [PathComponentsRepresentable] =  ["api", "v1"]
    
    let lawService = try container.make(LawService.self)
    let lawController = LawController(lawService: lawService, group: v1RouteGroup)

    let controllers: [RouteCollection] = [
        ApiSpecController(group: emptyRouteGroup),
        ReDocController(group: emptyRouteGroup),
        lawController
    ]

    try controllers.forEach { try router.register(collection: $0) }
}
