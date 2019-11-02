import Vapor
import LawHierarchy

public func setupRepositories(services: inout Services) {
    services.register(LawRepositoryImpl.self)
}
