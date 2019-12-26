import Vapor

public protocol LawParsingService: Service {
    func parseBy(abbrevation: String) -> EventLoopFuture<[LawSubpoint]>
}

public final class LawParsingServiceImpl: LawParsingService {

    private let lawParser: LawParser
    private let eventLoop: EventLoop

    init(lawParser: LawParser, eventLoop: EventLoop) {
        self.lawParser = lawParser
        self.eventLoop = eventLoop
    }

    public func parseBy(abbrevation: String) -> EventLoopFuture<[LawSubpoint]> {
        let data = TempData.rawXml
        let promise = eventLoop.newPromise([LawSubpoint].self)
        do {
            let subpoints = try lawParser.parse(rawXml: data)
            promise.succeed(result: subpoints)
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
