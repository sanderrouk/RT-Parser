import Vapor

public struct LawBody: Content, Equatable {

    let title: String
    let meta: LawMeta
    let chapters: [LawChapter]

    public init(
        title: String,
        meta: LawMeta,
        chapters: [LawChapter]
    ) {
        self.title = title
        self.meta = meta
        self.chapters = chapters
    }
}
