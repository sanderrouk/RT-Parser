import Vapor

public protocol TimerJob: Service {
    func job(_ task: RepeatedTask) -> EventLoopFuture<Void>
}
