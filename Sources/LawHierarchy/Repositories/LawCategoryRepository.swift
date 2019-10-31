import Vapor
import Data
import FluentSQLite

public protocol LawCategoryRepository: Service {
    func findAll() -> EventLoopFuture<[LawCategory]>
    func findAllWithLaws() -> EventLoopFuture<[LawCategoryWithLaws]>
    func count() -> EventLoopFuture<Int>
    func save(categories: [LawCategory]) -> EventLoopFuture<[LawCategory]>
}

public final class LawCategoryRepositoryImpl: LawCategoryRepository {

    private let databaseConnection: SQLiteDatabase.ConnectionPool

    required init(databaseConnection:  SQLiteDatabase.ConnectionPool) {
        self.databaseConnection = databaseConnection
    }

    public func findAll() -> EventLoopFuture<[LawCategory]> {
        return databaseConnection.withConnection { LawCategory.query(on: $0).all() }
    }

    public func findAllWithLaws() -> EventLoopFuture<[LawCategoryWithLaws]> {
        return databaseConnection.withConnection { connection in
            LawCategory
                .query(on: connection)
                .all()
                .flatMap { lawCategories in
                    return fetchChildren(
                        of: lawCategories,
                        via: \Law.lawCategoryId,
                        on: connection
                    ) { return LawCategoryWithLaws(lawCategory: $0, laws: $1) }
            }
        }
    }

    public func count() -> EventLoopFuture<Int> {
        return databaseConnection.withConnection { LawCategory.query(on: $0).count() }
    }

    public func save(categories: [LawCategory]) -> EventLoopFuture<[LawCategory]> {
        return databaseConnection.withConnection { connection in
            categories.map { $0.save(on: connection) }.flatten(on: connection)
        }
    }
}

extension LawCategoryRepositoryImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [LawCategoryRepository.self]

    public static func makeService(for container: Container) throws -> Self {
        let connectionPool = try container.connectionPool(to: .sqlite)
        return .init(databaseConnection: connectionPool)
    }
}
