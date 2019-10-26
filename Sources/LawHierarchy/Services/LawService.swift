import Vapor
import Data

public protocol LawService: Service {
    func findLaws() -> EventLoopFuture<[Law]>
    func findCategoriesWithLaws() -> EventLoopFuture<[LawCategoryWithLaws]>
}

public final class LawServiceImpl: LawService {
    
    private let lawRepository: LawRepository
    private let lawCategoryRepository: LawCategoryRepository
    private let lawUrlAndAbbreviationProvider: LawUrlAndAbbreviationProvider
    private let hierarchyBuilder: LawHierarchyBuilder
    
    init(
        lawRepository: LawRepository,
        lawCategoryRepository: LawCategoryRepository,
        lawUrlAndAbbreviationProvider: LawUrlAndAbbreviationProvider,
        hierarchyBuilder: LawHierarchyBuilder
    ) {
        self.lawRepository = lawRepository
        self.lawCategoryRepository = lawCategoryRepository
        self.lawUrlAndAbbreviationProvider = lawUrlAndAbbreviationProvider
        self.hierarchyBuilder = hierarchyBuilder
    }
    
    public func findLaws() -> EventLoopFuture<[Law]> {
        return lawRepository.findAll().map { [unowned self] in
            self.hierarchyBuilder.buildHierarchy(for: $0)
            return $0
        }
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
        let lawUrlAndAbbreviationProvider = try container.make(LawUrlAndAbbreviationProvider.self)
        let hierarchyBuilder = try container.make(LawHierarchyBuilder.self)

        return .init(
            lawRepository: lawRepository,
            lawCategoryRepository: lawCategoryRepository,
            lawUrlAndAbbreviationProvider: lawUrlAndAbbreviationProvider,
            hierarchyBuilder: hierarchyBuilder
        )
    }
}
