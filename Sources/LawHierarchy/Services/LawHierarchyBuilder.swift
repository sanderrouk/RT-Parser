import Foundation
import Data
import Vapor

public protocol LawHierarchyBuilder: Service {
    func buildHierarchy(for laws: [Law])
}

public final class LawHierarchyBuilderImpl: LawHierarchyBuilder {

    private let lawRepository: LawRepository
    private let categoryRepository: LawCategoryRepository

    internal init(lawRepository: LawRepository, categoryRepository: LawCategoryRepository) {
        self.lawRepository = lawRepository
        self.categoryRepository = categoryRepository
    }

    public func buildHierarchy(for laws: [Law]) {
        let parser = CategoryHierarchyParser()
        let xml = HierarchyAssets.rawHierarchyXml
        try? parser.parse(rawXml: xml)
        print(parser.categories)
        print(parser.hierarchy)
    }
}

extension LawHierarchyBuilderImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [LawHierarchyBuilder.self]

    public static func makeService(for container: Container) throws -> Self {
        let lawRepository = try container.make(LawRepository.self)
        let categoryRepository = try container.make(LawCategoryRepository.self)

        return .init(
            lawRepository: lawRepository,
            categoryRepository: categoryRepository
        )
    }
}
