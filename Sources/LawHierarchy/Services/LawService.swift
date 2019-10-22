import Vapor
import Data

public protocol LawService: Service {
    func findLaws() -> EventLoopFuture<[Law]>
    func findCategoriesWithLaws() -> EventLoopFuture<[LawCategoryWithLaws]>
}

public final class LawServiceImpl: LawService {
    
    private let lawRepository: LawRepository
    private let lawCategoryRepository: LawCategoryRepository
    
    init(lawRepository: LawRepository, lawCategoryRepository: LawCategoryRepository) {
        self.lawRepository = lawRepository
        self.lawCategoryRepository = lawCategoryRepository
    }
    
    public func findLaws() -> EventLoopFuture<[Law]> {
        return lawRepository.findAll()
    }
    
    public func findCategoriesWithLaws() -> EventLoopFuture<[LawCategoryWithLaws]> {
        return lawCategoryRepository.findAllWithLaws()
    }
}

extension LawServiceImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [LawService.self]

    public static func makeService(for container: Container) throws -> Self {
        let lawRepository = try container.make(LawRepository.self)
        let lawCategoryRepository = try container.make(LawCategoryRepository.self)

        return .init(lawRepository: lawRepository, lawCategoryRepository: lawCategoryRepository)
    }
}
