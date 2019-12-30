import Vapor

public protocol LawParsingService: Service {
    func parseBy(abbrevation: String) -> EventLoopFuture<LawBody>
}

public final class LawParsingServiceImpl: LawParsingService {

    private let lawParser: LawParser
    private let eventLoop: EventLoop

    init(lawParser: LawParser, eventLoop: EventLoop) {
        self.lawParser = lawParser
        self.eventLoop = eventLoop
    }

    public func parseBy(abbrevation: String) -> EventLoopFuture<LawBody> {
        let data = TempData.rawXml
        let promise = eventLoop.newPromise(LawBody.self)
        do {
            let sections = try lawParser.parse(rawXml: data)
            promise.succeed(result: sections)
        } catch {
            promise.fail(error: error)
        }

        return promise.futureResult
    }
}

extension LawParsingServiceImpl: ServiceType {
    public static var serviceSupports: [Any.Type] = [LawParsingService.self]

    public static func makeService(for container: Container) throws -> Self {
        let parser = LawParser()
        return .init(lawParser: parser, eventLoop: container.eventLoop)
    }
}
