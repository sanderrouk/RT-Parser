import Vapor
import FluentSQLite
import Data

public protocol UserTokenRepository: Service {
    func createOrUpdate(token: UserToken) -> Future<UserToken>
}

public class UserTokenRepositoryImpl: UserTokenRepository {
    private let databaseConnection: SQLiteDatabase.ConnectionPool

    required init(databaseConnection:  SQLiteDatabase.ConnectionPool) {
        self.databaseConnection = databaseConnection
    }

    public func createOrUpdate(token: UserToken) -> EventLoopFuture<UserToken> {
        return databaseConnection.withConnection { connection in
            return token.save(on: connection)
        }
    }
}

extension UserTokenRepositoryImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [UserTokenRepository.self]

    public static func makeService(for worker: Container) throws -> Self {
        let connectionPool = try worker.connectionPool(to: .sqlite)
        return .init(databaseConnection: connectionPool)
    }
}
