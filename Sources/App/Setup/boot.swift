import TimerJobs
import Vapor

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    if app.environment != .testing {
        try runTimerJobs(in: app)
    }
}

private func runTimerJobs(in app: Application) throws {
    let timerJobService = try app.make(TimerJobService.self)
    let dataSyncJob = try app.make(DataSyncJob.self)

    timerJobService.startJob(
        onEventLoop: app.eventLoop,
        interval: .hours(12),
        task: dataSyncJob.job
    )
}
