import Vapor

public func setupServices(services: inout Services, env: Environment) throws {

    if env == .production {
        print("Injecting production services.")
    } else {
        print("Injecting development services.")
    }
}
