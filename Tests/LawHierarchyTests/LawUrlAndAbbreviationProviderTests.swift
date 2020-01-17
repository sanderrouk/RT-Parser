import Data
import Testing
import Vapor
import XCTest
@testable import LawHierarchy

final class LawUrlAndAbbreviationProviderTests: XCTestCase {
    static let allTests = [
        ("testFetchFails_failsToCommunicateWithRiigiteataja", testFetchFails_failsToCommunicateWithRiigiteataja),
        ("testFetchFails_failsToParseHtml", testFetchFails_failsToParseHtml),
        ("testFetchesLaws_successWithZeroInResponse", testFetchesLaws_successWithZeroInResponse),
        ("testFetchesLaws_successWithFourInResponse", testFetchesLaws_successWithFourInResponse)
    ]

    fileprivate var networkClient: NetworkClientStub!
    var urlAndAbbreviationProvider: LawUrlAndAbbreviationProvider!

    override func setUp() {
        networkClient = NetworkClientStub()
        urlAndAbbreviationProvider = LawUrlAndAbbreviationProviderImpl(client: networkClient)
    }

    func testFetchFails_failsToCommunicateWithRiigiteataja() {
        let future = urlAndAbbreviationProvider.fetchLaws()
        XCTAssertThrowsAbortError(withStatus: .serviceUnavailable, try future.wait())
    }

    func testFetchFails_failsToParseHtml() {
        networkClient.response = Data()

        let future = urlAndAbbreviationProvider.fetchLaws()
        XCTAssertThrowsAbortError(withStatus: .internalServerError, try future.wait())
    }

    func testFetchesLaws_successWithZeroInResponse() {
        networkClient.response = RTAbbreviationListStubs.listWithZeroLaws
        let future = urlAndAbbreviationProvider.fetchLaws()
        XCTAssertNoThrow(try future.wait())

        let laws = try! future.wait()
        XCTAssertTrue(laws.isEmpty)
    }

    func testFetchesLaws_successWithFourInResponse() {
        networkClient.response = RTAbbreviationListStubs.listWithFourLaws
        let future = urlAndAbbreviationProvider.fetchLaws()
        XCTAssertNoThrow(try future.wait())

        let laws = try! future.wait()
        XCTAssertEqual(laws.count, 4)

        XCTAssertEqual(law, laws[0])
        XCTAssertEqual(law2, laws[1])
        XCTAssertEqual(law3, laws[2])
        XCTAssertEqual(law4, laws[3])
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

