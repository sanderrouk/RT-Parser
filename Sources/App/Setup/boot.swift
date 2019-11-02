import LawHierarchy
import TimerJobs
import Vapor

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    let lawService = try app.make(LawService.self)
    let timerJobService = try app.make(TimerJobService.self)

    timerJobService.startJob(onEventLoop: app.eventLoop, interval: .hours(12)) { _ in
        lawService.updateLaws()
    }
}
