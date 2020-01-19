import Vapor

public struct LawBody: Content, Equatable {

    let title: String
    let meta: LawMeta
    let chapters: [LawChapter]?
    let chapterlessParagraphs: [LawParagraph]?

    public init(
        title: String,
        meta: LawMeta,
        chapters: [LawChapter]?,
        chapterlessParagraphs: [LawParagraph]?
    ) {
        self.title = title
        self.meta = meta
        self.chapters = chapters
        self.chapterlessParagraphs = chapterlessParagraphs
    }
}
