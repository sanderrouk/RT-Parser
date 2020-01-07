import Vapor

public struct LawChapter: Content {

    let id: String
    let number: Int
    let title: String
    let paragraphs: [LawParagraph]
    let displayableNumber: String

    public init(
        id: String,
        number: Int,
        title: String,
        paragraphs: [LawParagraph],
        displayableNumber: String
    ) {
        self.id = id
        self.number = number
        self.title = title
        self.paragraphs = paragraphs
        self.displayableNumber = displayableNumber
    }
}
