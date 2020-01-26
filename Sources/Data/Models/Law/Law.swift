import FluentSQLite
import OpenApi
import Vapor

public final class Law: SQLiteStringModel, Content {

    public var id: String?
    public var title: String
    public var url: String
    public var abbreviation: String
    public var body: Data?

    public init(
        title: String,
        url: String,
        abbreviation: String,
        body: Data?
    ) {
        self.id = abbreviation
        self.title = title
        self.url = url
        self.abbreviation = abbreviation
        self.body = body
    }
}

extension Law: Migration {
    public static func prepare(on conn: SQLiteConnection) -> Future<Void> {
        return SQLiteDatabase.create(Law.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.title, type: .text)
            builder.field(for: \.url, type: .text)
            builder.field(for: \.abbreviation, type: .text, .unique())
            builder.field(for: \.body, type: .blob)
        }
    }
}

extension Law: Equatable {
    public static func == (lhs: Law, rhs: Law) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.url == rhs.url
            && lhs.abbreviation == rhs.abbreviation
            && lhs.body == rhs.body
    }
}

extension Law: Documentable {
    public static func defineDocumentation() {
        OpenApi.defineObject(object:
            Law(
                title: "Advokatuuriseadus",
                url: "https://www.riigiteataja.ee/akt/119032019051",
                abbreviation: "AdvS",
                body: nil
            )
        )
    }
}
