import Vapor
import Todo
import User

public func setupServices(services: inout Services, env: Environment) throws {
    services.register(TodoServiceImpl.self)
    services.register(UserServiceImpl.self)

    if env == .production {
        print("Injecting production services.")
    } else {
        print("Injecting development services.")
    }
}
