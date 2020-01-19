import XCTest
import LawHierarchy
import Vapor
@testable import Testing
@testable import LawParser
@testable import Data

final class LawParsingServiceTests: XCTestCase {
    static let allTests = [
        ("testParseByAbbreviationFails_lawNotFound", testParseByAbbreviationFails_lawNotFound),
        ("testParseByAbbreviationFails_networkFetchFails", testParseByAbbreviationFails_networkFetchFails),
        ("testParseByAbbreviationFails_lawParsingFails", testParseByAbbreviationFails_lawParsingFails),
        ("testParseByAbbreviationSucceeds", testParseByAbbreviationSucceeds)
    ]

    fileprivate var lawService: LawServiceStub!
    fileprivate var lawParser: LawParserStub!
    fileprivate var networkClient: NetworkClientStub!

    var lawParsingService: LawParsingService!

    override func setUp() {
        lawService = LawServiceStub()
        lawParser = LawParserStub()
        networkClient = NetworkClientStub()
        lawParsingService = LawParsingServiceImpl(
            lawParser: lawParser,
            lawService: lawService,
            networkClient: networkClient
        )
    }

    override func tearDown() {
        lawService = nil
        lawParser = nil
        networkClient = nil
        lawParsingService = nil
    }

    func testParseByAbbreviationFails_lawNotFound() {
        let future = lawParsingService.parseBy(abbreviation: "law")
        XCTAssertThrowsAbortError(withStatus: .notFound, try future.wait())
    }

    func testParseByAbbreviationFails_networkFetchFails() {
        let urlString = "https://someUrl"
        let url = URL(string: "\(urlString).xml")!
        lawService.law = Law(title: "Law", url: urlString, abbreviation: "abr", body: nil)

        let future = lawParsingService.parseBy(abbreviation: "law")
        XCTAssertThrowsAbortError(withStatus: .serviceUnavailable, try future.wait())
        XCTAssertEqual(url, networkClient.url?.convertToURL())
    }

    func testParseByAbbreviationFails_lawParsingFails() {
        let urlString = "https://someUrl"
        let url = URL(string: "\(urlString).xml")!
        lawService.law = Law(title: "Law", url: urlString, abbreviation: "abr", body: nil)
        let data = "StringData".data(using: .utf8)!
        networkClient.response = data

        let future = lawParsingService.parseBy(abbreviation: "law")
        XCTAssertThrowsAbortError(withStatus: .internalServerError, try future.wait())
        XCTAssertEqual(url, networkClient.url?.convertToURL())
    }

    func testParseByAbbreviationSucceeds() {
        let urlString = "https://someUrl"
        let url = URL(string: "\(urlString).xml")!
        lawService.law = Law(title: "Law", url: urlString, abbreviation: "abr", body: nil)
        let data = "StringData".data(using: .utf8)!
        networkClient.response = data
        lawParser.lawBody = lawBody

        let future = lawParsingService.parseBy(abbreviation: "law")
        XCTAssertNoThrow(try future.wait())
        let body = try! future.wait()

        XCTAssertEqual(url, self.networkClient.url?.convertToURL())
        XCTAssertEqual(data, self.lawParser.data)
        XCTAssertEqual(body, lawBody)
    }
}

private final class LawParserStub: LawParser {

    var lawBody: LawBody!
    var data: Data!

    func parse(rawXml: Data) throws -> LawBody {
        data = rawXml
        guard lawBody != nil else { throw Abort(.continue) }
        return lawBody
    }
}

private final class LawServiceStub: LawService {

    var laws: [Law]?
    var law: Law?
    var updatedCount = 0

    private let eventLoop = EmbeddedEventLoop()

    func findLaws() -> EventLoopFuture<[Law]> {
        return eventLoop.newSucceededFuture(result: laws ?? [])
    }

    func updateLaws() -> EventLoopFuture<Void> {
        updatedCount += 1
        return eventLoop.newSucceededFuture(result: ())
    }

    func findLaw(by abbreviation: String) -> EventLoopFuture<Law> {
        if law == nil {
            return eventLoop.newFailedFuture(error: Abort(.notFound))
        }
        return eventLoop.newSucceededFuture(result: law!)
    }
}

private final class NetworkClientStub: NetworkClient {

    var url: URLRepresentable?
    var response: Data?

    private let eventLoop = EmbeddedEventLoop()

    func get(_ urlRepresentable: URLRepresentable) -> EventLoopFuture<Data> {
        url = urlRepresentable
        if let response = response {
            return eventLoop.newSucceededFuture(result: response)
        }

        return eventLoop.newFailedFuture(error: Abort(.serviceUnavailable))
    }
}
