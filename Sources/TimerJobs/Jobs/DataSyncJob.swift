import Data
import LawHierarchy
import LawParser
import Vapor

public final class DataSyncJob: TimerJob {

    private let lawService: LawService
    private let lawParsingService: LawParsingService
    private let eventLoop: EventLoop

    init(
        lawService: LawService,
        lawParsingService: LawParsingService,
        eventLoop: EventLoop
    ) {
        self.lawService = lawService
        self.lawParsingService = lawParsingService
        self.eventLoop = eventLoop
    }

    public func job(_ task: RepeatedTask) -> EventLoopFuture<Void> {
        return lawService.updateLaws()
            .flatMap(fetchBodies)
            .flatMap(lawService.updateLawBodies)
            .transform(to: ())
    }

    private func fetchBodies(for laws: [Law]) -> EventLoopFuture<[Law]> {
        let encoder = JSONEncoder()
        return laws.map { law in
            return lawParsingService.parseBy(abbreviation: law.abbreviation)
                .map({ lawBody -> Law in
                    guard let data = try? encoder.encode(lawBody) else { return law }
                    law.body = data
                    return law
                })
        }.flatten(on: eventLoop)
    }
}

extension DataSyncJob: ServiceType {
    public static var serviceSupports: [Any.Type] = [DataSyncJob.self]

    public static func makeService(for container: Container) throws -> DataSyncJob {
        let lawService = try container.make(LawService.self)
        let lawParsingService = try container.make(LawParsingService.self)

        return .init(
            lawService: lawService,
            lawParsingService: lawParsingService,
            eventLoop: container.eventLoop
        )
    }
}
