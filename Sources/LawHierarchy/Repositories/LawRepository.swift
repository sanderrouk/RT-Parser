import Vapor
import Data
import FluentSQLite

public protocol LawRepository: Service {
    func find(by abbreviation: String) -> EventLoopFuture<Law?>
    func findAll() -> EventLoopFuture<[Law]>
    func save(laws: [Law]) -> EventLoopFuture<[Law]>
}

public final class LawRepositoryImpl: LawRepository {

    private let databaseConnection: SQLiteDatabase.ConnectionPool

    required init(databaseConnection:  SQLiteDatabase.ConnectionPool) {
        self.databaseConnection = databaseConnection
    }

    public func find(by abbreviation: String) -> EventLoopFuture<Law?> {
        return databaseConnection.withConnection {
            Law.query(on: $0).filter(\.abbreviation == abbreviation).first()
        }
    }

    public func findAll() -> EventLoopFuture<[Law]> {
        return databaseConnection.withConnection { Law.query(on: $0).all() }
    }

    public func save(laws: [Law]) -> EventLoopFuture<[Law]> {
        return databaseConnection.withConnection { connection in
            laws.map { self.createOrUpdate($0, connection: connection) }.flatten(on: connection)
        }
    }

    private func createOrUpdate<T: _SQLiteModel>(_ model: T, connection: SQLiteConnection) -> EventLoopFuture<T> {
        return model.create(on: connection)
            .catchFlatMap { _ in model.update(on: connection) }
    }
}

extension LawRepositoryImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [LawRepository.self]

    public static func makeService(for container: Container) throws -> Self {
        let connectionPool = try container.connectionPool(to: .sqlite)
        return .init(databaseConnection: connectionPool)
    }
}

