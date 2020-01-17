import Data
import Testing
import Vapor
import XCTest
@testable import LawHierarchy

final class LawServiceTests: XCTestCase {
    static let allTests = [
        ("testFindLaws_failsIfRepositoryFails", testFindLaws_failsIfRepositoryFails),
        ("testFindLaws", testFindLaws),
        ("testUpdateLaws_failsWhenProviderFails", testUpdateLaws_failsWhenProviderFails),
        ("testUpdateLaws_failsWhenRepositoryFails", testUpdateLaws_failsWhenRepositoryFails),
        ("testUpdateLaws", testUpdateLaws),
        ("testFindByAbbreviation_failsIfRepositoryFails", testFindByAbbreviation_failsIfRepositoryFails),
        ("testFindByAbbreviation_failsIfRepositoryReturnsNil", testFindByAbbreviation_failsIfRepositoryReturnsNil),
        ("testFindByAbbreviation", testFindByAbbreviation)
    ]

    fileprivate var repository: LawRepositoryStub!
    fileprivate var provider: LawUrlAndAbbreviationProviderStub!
    var lawService: LawService!

    override func setUp() {
        repository = LawRepositoryStub()
        provider = LawUrlAndAbbreviationProviderStub()
        lawService = LawServiceImpl(
            lawRepository: repository,
            lawUrlAndAbbreviationProvider: provider
        )
    }

    func testFindLaws_failsIfRepositoryFails() {
        repository.error = Abort(.preconditionFailed)
        let future = lawService.findLaws()
        XCTAssertThrowsAbortError(withStatus: .preconditionFailed, try future.wait())
    }

    func testFindLaws() {
        let repositoryLaws = [law, law2, law3, law4]
        repository.laws = repositoryLaws
        let future = lawService.findLaws()
        XCTAssertNoThrow(try future.wait())
        let returnedLaws = try! future.wait()
        XCTAssertEqual(returnedLaws, repositoryLaws)
    }

    func testUpdateLaws_failsWhenProviderFails() {
        provider.error = Abort(.preconditionFailed)
        let future = lawService.updateLaws()
        XCTAssertThrowsAbortError(withStatus: .preconditionFailed, try future.wait())
    }

    func testUpdateLaws_failsWhenRepositoryFails() {
        let providerLaws = [law, law2]
        provider.laws = providerLaws
        repository.error = Abort(.expectationFailed)
        let future = lawService.updateLaws()
        XCTAssertThrowsAbortError(withStatus: .expectationFailed, try future.wait())
        XCTAssertEqual(repository.savedLaws, providerLaws)
    }

    func testUpdateLaws() {
        let providerLaws = [law, law4, law2]
        provider.laws = providerLaws
        let future = lawService.updateLaws()
        XCTAssertNoThrow(try future.wait())
        XCTAssertEqual(repository.savedLaws, providerLaws)
    }

    func testFindByAbbreviation_failsIfRepositoryFails() {
        repository.error = Abort(.preconditionFailed)
        let abbreviation = "Abbreviation text"
        let future = lawService.findLaw(by: abbreviation)
        XCTAssertThrowsAbortError(withStatus: .preconditionFailed, try future.wait())
        XCTAssertEqual(abbreviation, repository.abbreviation)
    }

    func testFindByAbbreviation_failsIfRepositoryReturnsNil() {
        let abbreviation = "Abbreviation text"
        let future = lawService.findLaw(by: abbreviation)
        XCTAssertThrowsAbortError(withStatus: .notFound, try future.wait())
        XCTAssertEqual(abbreviation, repository.abbreviation)
    }

    func testFindByAbbreviation() {
        repository.law = law
        let abbreviation = "Abbreviation text"
        let future = lawService.findLaw(by: abbreviation)
        XCTAssertNoThrow(try future.wait())
        let returnedLaw = try! future.wait()
        XCTAssertEqual(abbreviation, repository.abbreviation)
        XCTAssertEqual(returnedLaw, law)
    }
}

private class LawRepositoryStub: LawRepository {

    var law: Law?
    var laws: [Law]!
    var savedLaws: [Law]!
    var abbreviation: String!
    var error: Error?

    private var eventLoop = EmbeddedEventLoop()

    func find(by abbreviation: String) -> EventLoopFuture<Law?> {
        self.abbreviation = abbreviation

        if let error = error {
              return eventLoop.newFailedFuture(error: error)
        }

        return eventLoop.newSucceededFuture(result: law)
    }

    func findAll() -> EventLoopFuture<[Law]> {
        if let error = error {
            return eventLoop.newFailedFuture(error: error)
        }

        return eventLoop.newSucceededFuture(result: laws)
    }

    func save(laws: [Law]) -> EventLoopFuture<[Law]> {
        self.savedLaws = laws
        if let error = error {
            return eventLoop.newFailedFuture(error: error)
        }

        return eventLoop.newSucceededFuture(result: laws)
    }
}

private class LawUrlAndAbbreviationProviderStub: LawUrlAndAbbreviationProvider {

    var laws: [Law]!
    var error: Error?

    private var eventLoop = EmbeddedEventLoop()

    func fetchLaws() -> EventLoopFuture<[Law]> {
        if let error = error {
              return eventLoop.newFailedFuture(error: error)
        }
        return eventLoop.newSucceededFuture(result: laws)
    }
}

