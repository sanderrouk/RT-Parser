import Vapor

public struct LawChapter: Content {
    let id: String
    let number: Int
    let title: String
    let paragraphs: [LawParagraph]
    let displayableNumber: String
}
