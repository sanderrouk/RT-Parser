import Vapor
import Data

public protocol LawService: Service {
    func findLaws() -> EventLoopFuture<[Law]>
    func updateLaws() -> EventLoopFuture<Void>
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

    public func updateLaws() -> EventLoopFuture<Void> {
        return lawUrlAndAbbreviationProvider.fetchLaws()
            .flatMap { [unowned self] laws in
                self.lawRepository.save(laws: laws).transform(to: ())
        }
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
