import Data
import LawHierarchy
import Vapor

public protocol LawParsingService: Service {
    func parseBy(abbreviation: String) -> EventLoopFuture<LawBody>
}

public final class LawParsingServiceImpl: LawParsingService {

    private let lawParser: LawParser
    private let lawService: LawService
    private let networkClient: NetworkClient

    init(
        lawParser: LawParser,
        lawService: LawService,
        networkClient: NetworkClient
    ) {
        self.lawParser = lawParser
        self.lawService = lawService
        self.networkClient = networkClient
    }

    public func parseBy(abbreviation: String) -> EventLoopFuture<LawBody> {
        let futureLaw = lawService.findLaw(by: abbreviation)
        let futureData = futureLaw.flatMap { [unowned self] law in
            self.networkClient.get("\(law.url).xml")
        }

        return futureData.map { [unowned self] data in
            do {
                return try self.lawParser.parse(rawXml: data)
            } catch {
                throw Abort(.internalServerError)
            }
        }
    }
}

extension LawParsingServiceImpl: ServiceType {
    public static var serviceSupports: [Any.Type] = [LawParsingService.self]

    public static func makeService(for container: Container) throws -> Self {
        let parser = LawParserImpl()
        let lawService = try container.make(LawService.self)
        let networkClient = try container.make(NetworkClient.self)
        return .init(
            lawParser: parser,
            lawService: lawService,
            networkClient: networkClient
        )
    }
}
