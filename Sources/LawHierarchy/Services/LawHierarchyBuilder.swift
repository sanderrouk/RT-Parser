import Foundation
import Data
import Vapor

public protocol LawHierarchyBuilder: Service {
    func buildHierarchy(for laws: [Law]) throws -> EventLoopFuture<[Law]>
}

public final class LawHierarchyBuilderImpl: LawHierarchyBuilder {

    private let lawRepository: LawRepository
    private let categoryRepository: LawCategoryRepository
    private let lawUrlAndAbbreviationProvider: LawUrlAndAbbreviationProvider

    internal init(
        lawRepository: LawRepository,
        categoryRepository: LawCategoryRepository,
        lawUrlAndAbbreviationProvider: LawUrlAndAbbreviationProvider
    ) {
        self.lawRepository = lawRepository
        self.categoryRepository = categoryRepository
        self.lawUrlAndAbbreviationProvider = lawUrlAndAbbreviationProvider
    }

    public func buildHierarchy(for laws: [Law]) throws -> EventLoopFuture<[Law]> {
        let parser = CategoryHierarchyParser()
        let xml = HierarchyAssets.rawHierarchyXml
        try parser.parse(rawXml: xml)
        let categories = storeOrFetch(categories: parser.categories)
            .flatMap { [unowned self] _ in
                // There seems to be a bug in the SQLite driver that causes id's returned by a storing to be a mismatch by 1
                self.categoryRepository.findAll()
        }
        let laws = lawUrlAndAbbreviationProvider.fetchLaws()
        return flatMap(categories, laws) { [unowned self] categories, laws in
            let lawsWithCategoryIds = self.combine(
                laws,
                with: categories,
                using: parser.hierarchy
            )

            return self.lawRepository.save(laws: lawsWithCategoryIds)
        }
    }

    private func storeOrFetch(categories: [LawCategory]) -> EventLoopFuture<[LawCategory]> {
        let futureCount = categoryRepository.count()
        return futureCount.flatMap { [unowned self] count in
            if count == 0 {
                return self.categoryRepository.save(categories: categories)
            } else {
                return self.categoryRepository.findAll()
            }
        }
    }

    private func combine(
        _ laws: [Law],
        with categories: [LawCategory],
        using hierarchy: [String: [String]]
    ) -> [Law] {
        var modifiedLaws = [Law]()
        categories.forEach { category in
            guard let lawNames = hierarchy[category.title], let categoryId = category.id else { return }
            let lawsWithCategories = self.add(categoryId: categoryId, to: laws, includedIn: lawNames)
            modifiedLaws.append(contentsOf: lawsWithCategories)
        }

        return modifiedLaws
    }

    private func add(
        categoryId: Int,
        to laws: [Law],
        includedIn lawNames: [String]
    ) -> [Law] {
        return lawNames.compactMap { lawName in
            guard let law = laws.first(where: { $0.title == lawName }) else { return nil }
            law.lawCategoryId = categoryId
            return law
        }
    }
}

extension LawHierarchyBuilderImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [LawHierarchyBuilder.self]

    public static func makeService(for container: Container) throws -> Self {
        let lawRepository = try container.make(LawRepository.self)
        let categoryRepository = try container.make(LawCategoryRepository.self)
        let lawUrlAndAbbreviationProvider = try container.make(LawUrlAndAbbreviationProvider.self)


        return .init(
            lawRepository: lawRepository,
            categoryRepository: categoryRepository,
            lawUrlAndAbbreviationProvider: lawUrlAndAbbreviationProvider
        )
    }
}
