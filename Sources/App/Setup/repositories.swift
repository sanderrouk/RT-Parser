import Vapor
import Todo
import User

public func setupRepositories(services: inout Services) {
    services.register(TodoRepositoryImpl.self)
    services.register(UserTokenRepositoryImpl.self)
    services.register(UserRepositoryImpl.self)
}
