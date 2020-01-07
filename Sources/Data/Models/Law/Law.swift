import FluentSQLite
import Vapor

public final class Law: SQLiteStringModel, Content {

    public var id: String?
    public var title: String
    public var url: String
    public var abbreviation: String
    public var body: LawBody?

    public init(
        title: String,
        url: String,
        abbreviation: String,
        body: LawBody?
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
        }
    }
}
