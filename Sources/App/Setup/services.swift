import Vapor
import LawHierarchy

public func setupServices(services: inout Services, env: Environment) throws {
    services.register(LawServiceImpl.self)
}
