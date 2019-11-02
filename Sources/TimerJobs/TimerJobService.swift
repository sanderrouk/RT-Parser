import Vapor

public protocol TimerJobService: Service {
    @discardableResult
    func startJob(
        onEventLoop eventLoop: EventLoop,
        interval: TimeAmount,
        task: @escaping (RepeatedTask) -> EventLoopFuture<Void>
    ) -> RepeatedTask
}

public final class TimerJobServiceImpl: TimerJobService {

    @discardableResult
    public func startJob(
        onEventLoop eventLoop: EventLoop,
        interval: TimeAmount,
        task: @escaping (RepeatedTask) -> EventLoopFuture<Void>
    ) -> RepeatedTask {
        return startJob(
            onEventLoop: eventLoop,
            initialDelay: .seconds(0),
            interval: interval,
            task: task
        )
    }

    private func startJob(
        onEventLoop eventLoop: EventLoop,
        initialDelay: TimeAmount,
        interval: TimeAmount,
        task: @escaping (RepeatedTask) -> EventLoopFuture<Void>
    ) -> RepeatedTask {
        return eventLoop.scheduleRepeatedTask(
            initialDelay: initialDelay,
            delay: interval, task
        )
    }
}

extension TimerJobServiceImpl: ServiceType {
    public static var serviceSupports: [Any.Type] = [TimerJobService.self]

    public static func makeService(for container: Container) throws -> Self {
        return .init()
    }
}
