import FluentSQLite
import Vapor

public final class Law: SQLiteModel, Content {

    public var id: Int?
    public var title: String
    public var url: String
    public var abbreviation: String
    public var lawCategoryId: Int

    public init(id: Int?, title: String, url: String, abbreviation: String, lawCategoryId: Int) {
        self.id = id
        self.title = title
        self.url = url
        self.abbreviation = abbreviation
        self.lawCategoryId = lawCategoryId
    }
}

extension Law: Migration {
    public static func prepare(on conn: SQLiteConnection) -> Future<Void> {
        return SQLiteDatabase.create(Law.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.title, type: .text, .unique())
            builder.field(for: \.url, type: .text, .unique())
            builder.field(for: \.abbreviation, type: .text, .unique())
            builder.field(for: \.lawCategoryId)

            builder.reference(from: \.lawCategoryId, to: \LawCategory.id)
        }
    }
}
