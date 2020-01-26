import Vapor
import Data

public protocol LawService: Service {
    func findLaws() -> EventLoopFuture<[Law]>
    func updateLaws() -> EventLoopFuture<[Law]>
    func findLaw(by abbreviation: String) -> EventLoopFuture<Law>
    func updateLawBodies(for laws: [Law]) -> EventLoopFuture<[Law]>
}

public final class LawServiceImpl: LawService {

    private let lawRepository: LawRepository
    private let lawUrlAndAbbreviationProvider: LawUrlAndAbbreviationProvider

    init(
        lawRepository: LawRepository,
        lawUrlAndAbbreviationProvider: LawUrlAndAbbreviationProvider
    ) {
        self.lawRepository = lawRepository
        self.lawUrlAndAbbreviationProvider = lawUrlAndAbbreviationProvider
    }
    
    public func findLaws() -> EventLoopFuture<[Law]> {
        return lawRepository.findAll()
    }

    public func updateLaws() -> EventLoopFuture<[Law]> {
        return lawUrlAndAbbreviationProvider.fetchLaws()
            .flatMap { [unowned self] laws in
                self.lawRepository.save(laws: laws)
        }
    }

    public func findLaw(by abbreviation: String) -> EventLoopFuture<Law> {
        return lawRepository.find(by: abbreviation)
            .map({
                guard let law = $0 else { throw Abort(.notFound) }
                return law
            })
    }

    public func updateLawBodies(for laws: [Law]) -> EventLoopFuture<[Law]> {
        return lawRepository.save(laws: laws)
    }
}

extension LawServiceImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [LawService.self]

    public static func makeService(for container: Container) throws -> Self {
        let lawRepository = try container.make(LawRepository.self)
        let lawUrlAndAbbreviationProvider = try container.make(LawUrlAndAbbreviationProvider.self)

        return .init(
            lawRepository: lawRepository,
            lawUrlAndAbbreviationProvider: lawUrlAndAbbreviationProvider
        )
    }
}
