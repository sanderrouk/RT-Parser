import Vapor
import Data
import FluentSQLite

public protocol LawCategoryRepository: Service {

    func findAll() -> EventLoopFuture<[LawCategory]>
    func findAllWithLaws() -> EventLoopFuture<[LawCategoryWithLaws]>
}

final class LawCategoryRepositoryImpl: LawCategoryRepository {

    private let databaseConnection: SQLiteDatabase.ConnectionPool

    required init(databaseConnection:  SQLiteDatabase.ConnectionPool) {
        self.databaseConnection = databaseConnection
    }

    func findAll() -> EventLoopFuture<[LawCategory]> {
        return databaseConnection.withConnection { LawCategory.query(on: $0).all() }
    }

    func findAllWithLaws() -> EventLoopFuture<[LawCategoryWithLaws]> {
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
}

extension LawCategoryRepositoryImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [LawCategoryRepository.self]

    static func makeService(for container: Container) throws -> Self {
        let connectionPool = try container.connectionPool(to: .sqlite)
        return .init(databaseConnection: connectionPool)
    }
}
