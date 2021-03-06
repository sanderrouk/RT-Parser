import Data
import Foundation
import Kanna
import Vapor

public protocol LawUrlAndAbbreviationProvider: Service {
    func fetchLaws() -> EventLoopFuture<[Law]>
}

public final class LawUrlAndAbbreviationProviderImpl: LawUrlAndAbbreviationProvider {

    private let rtSourceUrl = "https://www.riigiteataja.ee/lyhendid.html"
    private let networkClient: NetworkClient

    internal init(client: NetworkClient) {
        self.networkClient = client
    }

    public func fetchLaws() -> EventLoopFuture<[Law]> {
        return networkClient.get(rtSourceUrl).map { [unowned self] data in
            try self.parseHtmlToLaws(rawHtml: data)
        }
    }

    private func parseHtmlToLaws(rawHtml: Data) throws -> [Law] {
        guard let html = try? HTML(html: rawHtml, encoding: String.Encoding.utf8) else {
            throw Abort(.internalServerError)
        }

        return html.css("tbody > tr").compactMap { row -> Law? in
            var tempLaw = TempLaw()

            row.css("td > a").enumerated().forEach { index, link in
                if index == 0 {
                    tempLaw.name = link.text
                    tempLaw.link = "https://www.riigiteataja.ee/" + (link["href"] ?? "")
                } else {
                    tempLaw.abbreviation = link.text
                }
            }

            guard let name = tempLaw.name,
                let url = tempLaw.link,
                let abbreviation = tempLaw.abbreviation else { return nil }

            return Law(
                title: name,
                url: url,
                abbreviation: abbreviation,
                body: nil
            )
        }
    }
}

extension LawUrlAndAbbreviationProviderImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [LawUrlAndAbbreviationProvider.self]

    public static func makeService(for container: Container) throws -> Self {
        let client = try container.make(NetworkClient.self)
        return .init(client: client)
    }
}

private struct TempLaw {
    var name: String?
    var link: String?
    var abbreviation: String?

    init() {
        name = nil
        link = nil
        abbreviation = nil
    }
}
