import Data
import LawHierarchy
import Vapor

public protocol LawParsingService: Service {
    func parseBy(abbreviation: String) -> EventLoopFuture<LawBody>
}

public final class LawParsingServiceImpl: LawParsingService {

    private let lawParser: LawParser
    private let lawService: LawService
    private let client: Client

    init(
        lawParser: LawParser,
        lawService: LawService,
        client: Client
    ) {
        self.lawParser = lawParser
        self.lawService = lawService
        self.client = client
    }

    private func fetchXml(from url: String) -> EventLoopFuture<Data> {
        return client.get("\(url).xml").map { response in
            guard let data = response.http.body.data else { throw Abort(.serviceUnavailable) }
            return data
        }
    }

    public func parseBy(abbreviation: String) -> EventLoopFuture<LawBody> {
        let futureLaw = lawService.findLaw(by: abbreviation)
        let futureData = futureLaw.flatMap { [unowned self] law in
            self.fetchXml(from: law.url)
        }

        return futureData.map { [unowned self] data in
            do {
                return try self.lawParser.parse(rawXml: data)
            } catch let error {
                throw Abort(.internalServerError)
            }
        }
    }
}

extension LawParsingServiceImpl: ServiceType {
    public static var serviceSupports: [Any.Type] = [LawParsingService.self]

    public static func makeService(for container: Container) throws -> Self {
        let parser = LawParser()
        let lawService = try container.make(LawService.self)
        let client = try container.make(Client.self)
        return .init(lawParser: parser, lawService: lawService, client: client)
    }
}
