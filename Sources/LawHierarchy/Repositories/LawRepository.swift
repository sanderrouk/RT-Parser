import Vapor
import Data
import FluentSQLite

public protocol LawRepository: Service {
    func findAll() -> EventLoopFuture<[Law]>
}

public final class LawRepositoryImpl: LawRepository {

    private let databaseConnection: SQLiteDatabase.ConnectionPool

    required init(databaseConnection:  SQLiteDatabase.ConnectionPool) {
        self.databaseConnection = databaseConnection
    }

    public func findAll() -> EventLoopFuture<[Law]> {
        return databaseConnection.withConnection { Law.query(on: $0).all() }
    }
}

extension LawRepositoryImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [LawRepository.self]

    public static func makeService(for container: Container) throws -> Self {
        let connectionPool = try container.connectionPool(to: .sqlite)
        return .init(databaseConnection: connectionPool)
    }
}

