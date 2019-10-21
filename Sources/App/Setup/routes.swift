import Vapor
import Data
import OpenApi

/// Register your application's routes here.
public func routes(_ router: Router, _ container: Container) throws {
    // Route Groups
    let emptyRouteGroup = ""
    let v1RouteGroup: [PathComponentsRepresentable] =  ["api", "v1"]


    let controllers: [RouteCollection] = [
        ApiSpecController(group: emptyRouteGroup),
        ReDocController(group: emptyRouteGroup),
    ]

    try controllers.forEach { try router.register(collection: $0) }
}
