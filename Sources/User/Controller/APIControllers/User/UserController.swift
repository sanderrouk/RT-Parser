import Vapor
import Data
import Crypto

public final class UserController: RouteCollection {

    private let userService: UserService
    private let group: [PathComponentsRepresentable]

    public init(userService: UserService, group: PathComponentsRepresentable...) {
        self.userService = userService
        self.group = group
    }

    public func boot(router: Router) throws {
        let groupRouter = router.grouped(group)
        let authRouter = router
            .grouped(group)
            .grouped(User.basicAuthMiddleware(using: BCryptDigest()))

        authRouter.post("login", use: login)
        groupRouter.post("users", use: create)
        groupRouter.get("users", use: getAllUsersWithTodos)
    }

    public func login(_ request: Request) throws -> Future<UserToken> {
        let user = try request.requireAuthenticated(User.self)
        return try userService.login(user: user)
    }

    public func create(_ req: Request) throws -> Future<UserResponse> {
        return try req.content.decode(CreateUserRequest.self).flatMap { [userService] user -> Future<User> in
            // verify that passwords match
            guard user.password == user.verifyPassword else {
                throw Abort(.badRequest, reason: "Password and verification must match.")
            }

            // save new user
            return try userService.create(user: user)
            }.map { user in
                // map to public user response (omits password hash)
                return try UserResponse(id: user.requireID(), name: user.name, email: user.email)
        }
    }

    public func getAllUsersWithTodos(_ request: Request) throws -> Future<[UserWithTodos]> {
        return userService.getAllUsersWithTodos()
    }
}
