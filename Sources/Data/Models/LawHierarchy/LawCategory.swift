import FluentSQLite

public final class LawCategory: SQLiteModel {

    public var id: Int?
    public var title: String

    public init(id: Int?, title: String) {
        self.id = id
        self.title = title
    }

    var laws: Children<LawCategory, Law> {
        return children(\.lawCategoryId)
    }
}

extension LawCategory: Migration {
    public static func prepare(on conn: SQLiteConnection) -> Future<Void> {
        return SQLiteDatabase.create(LawCategory.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.title)
            builder.reference(from: \.id, to: \Law.lawCategoryId)
        }
    }
}
