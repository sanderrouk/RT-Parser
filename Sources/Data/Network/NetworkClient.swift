import Vapor

public protocol NetworkClient: Service {
    func get(_ urlRepresentable: URLRepresentable) -> EventLoopFuture<Data>
}

public final class NetworkClientImplementation: NetworkClient {

    private let client: Client

    init(client: Client) {
        self.client = client
    }

    public func get(_ urlRepresentable: URLRepresentable) -> EventLoopFuture<Data> {
        return client.get(urlRepresentable)
            .map({ response in
                guard let data = response.http.body.data else { throw Abort(.serviceUnavailable) }
                return data
            })
    }
}

extension NetworkClientImplementation: ServiceType {
    public static var serviceSupports: [Any.Type] = [NetworkClient.self]

    public static func makeService(for container: Container) throws -> Self {
        let client = try container.make(Client.self)
        return .init(client: client)
    }
}
