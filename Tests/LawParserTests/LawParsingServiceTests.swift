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

    var app: Application!
    fileprivate var lawService: LawServiceStub!
    fileprivate var lawParser: LawParserStub!
    fileprivate var networkingService: NetworkingServiceStub!

    var lawParsingService: LawParsingService!

    override func setUp() {
        try! Application.reset()
        app = try! Application.testable()
        lawService = LawServiceStub(application: app)
        lawParser = LawParserStub()
        networkingService = NetworkingServiceStub(application: app)
        lawParsingService = LawParsingServiceImpl(
            lawParser: lawParser,
            lawService: lawService,
            networkingService: networkingService
        )
    }

    override func tearDown() {
        lawService = nil
        lawParser = nil
        networkingService = nil
        lawParsingService = nil
        try? app.syncShutdownGracefully()
        app = nil
    }

    func testParseByAbbreviationFails_lawNotFound() {
        let future = lawParsingService.parseBy(abbreviation: "law")
        let expectation = self.expectation(description: "Awaiting for law fetch")
        future.catch {
            if let error = $0 as? AbortError {
                XCTAssertEqual(error.status, .notFound)
                expectation.fulfill()
            } else {
                XCTFail("Received incorrect failure")
            }
        }

        waitForExpectations(timeout: 10)
    }

    func testParseByAbbreviationFails_networkFetchFails() {
        let urlString = "https://someUrl"
        let url = URL(string: "\(urlString).xml")!
        lawService.law = Law(title: "Law", url: urlString, abbreviation: "abr", body: nil)

        let future = lawParsingService.parseBy(abbreviation: "law")
        let expectation = self.expectation(description: "Awaiting for fail")
        future.catch {
            if let error = $0 as? AbortError {
                XCTAssertEqual(error.status, .serviceUnavailable)
                expectation.fulfill()
                XCTAssertEqual(url, self.networkingService.url?.convertToURL())
            } else {
                XCTFail("Received incorrect failure")
            }
        }

        waitForExpectations(timeout: 10)
    }

    func testParseByAbbreviationFails_lawParsingFails() {
        let urlString = "https://someUrl"
        let url = URL(string: "\(urlString).xml")!
        lawService.law = Law(title: "Law", url: urlString, abbreviation: "abr", body: nil)
        let data = "StringData".data(using: .utf8)!
        networkingService.response = data

        let future = lawParsingService.parseBy(abbreviation: "law")
        let expectation = self.expectation(description: "Awaiting for fail")
        future.catch {
            if let error = $0 as? AbortError {
                XCTAssertEqual(error.status, .internalServerError)
                expectation.fulfill()
                XCTAssertEqual(url, self.networkingService.url?.convertToURL())
                XCTAssertEqual(data, self.lawParser.data)
            } else {
                XCTFail("Received incorrect failure")
            }
        }

        waitForExpectations(timeout: 10)
    }

    func testParseByAbbreviationSucceeds() {
        let urlString = "https://someUrl"
        let url = URL(string: "\(urlString).xml")!
        lawService.law = Law(title: "Law", url: urlString, abbreviation: "abr", body: nil)

        let data = "StringData".data(using: .utf8)!
        networkingService.response = data

        lawParser.lawBody = lawBody

        let future = lawParsingService.parseBy(abbreviation: "law")
        let expectation = self.expectation(description: "Awaiting for success")

        _ = future.do({
            XCTAssertEqual(url, self.networkingService.url?.convertToURL())
            XCTAssertEqual(data, self.lawParser.data)
            XCTAssertEqual($0, lawBody)
            expectation.fulfill()
        })

        waitForExpectations(timeout: 10)
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

    private weak var application: Application!

    init(application: Application) {
        self.application = application
    }

    func findLaws() -> EventLoopFuture<[Law]> {
        return application.eventLoop.newSucceededFuture(result: laws ?? [])
    }

    func updateLaws() -> EventLoopFuture<Void> {
        updatedCount += 1
        return application.eventLoop.newSucceededFuture(result: ())
    }

    func findLaw(by abbreviation: String) -> EventLoopFuture<Law> {
        if law == nil {
            return application.eventLoop.newFailedFuture(error: Abort(.notFound))
        }
        return application.eventLoop.newSucceededFuture(result: law!)
    }
}

private final class NetworkingServiceStub: NetworkingService {

    var url: URLRepresentable?
    var response: Data?

    private weak var application: Application!

    init(application: Application) {
        self.application = application
    }

    func get(_ urlRepresentable: URLRepresentable) -> EventLoopFuture<Data> {
        url = urlRepresentable
        if let response = response {
            return application.eventLoop.newSucceededFuture(result: response)
        }

        return application.eventLoop.newFailedFuture(error: Abort(.serviceUnavailable))
    }
}
