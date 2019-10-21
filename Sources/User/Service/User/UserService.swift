import Vapor
import Data
import Crypto

public protocol UserService: Service {
    func login(user: User) throws -> Future<UserToken>
    func create(user: CreateUserRequest) throws -> Future<User>
    func getAllUsersWithTodos() -> Future<[UserWithTodos]>
}

public class UserServiceImpl: UserService {

    private let userRepository: UserRepository
    private let userTokenRepository: UserTokenRepository

    required init(userRepository: UserRepository, userTokenRepository: UserTokenRepository) {
        self.userRepository = userRepository
        self.userTokenRepository = userTokenRepository
    }

    public func login(user: User) throws -> EventLoopFuture<UserToken> {
        let token = try UserToken.create(userID: user.requireID())
        return userTokenRepository.createOrUpdate(token: token)
    }

    public func create(user userRequest: CreateUserRequest) throws -> EventLoopFuture<User> {
        let hash = try BCrypt.hash(userRequest.password)
        let user = User(id: nil, name: userRequest.name, email: userRequest.email, passwordHash: hash)
        return userRepository.createOrUpdate(user: user)
    }

    public func getAllUsersWithTodos() -> EventLoopFuture<[UserWithTodos]> {
        return userRepository.getAllUsersWithTodos()
    }
}

extension UserServiceImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [UserService.self]

    public static func makeService(for container: Container) throws -> Self {
        let userRepository = try container.make(UserRepository.self)
        let tokenRepository = try container.make(UserTokenRepository.self)
        return .init(userRepository: userRepository, userTokenRepository: tokenRepository)
    }
}
