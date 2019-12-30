import Vapor

public struct LawBody: Content {
    let title: String
    let meta: LawMeta
    let chapters: [LawChapter]
}
