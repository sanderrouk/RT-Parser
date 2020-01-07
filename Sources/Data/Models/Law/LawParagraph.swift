import Vapor

public struct LawParagraph: Content {

    let id: String
    let index: Int?
    let number: Int
    let title: String
    let sections: [LawSection]?
    let content: String?
    let displayableNumber: String

    public init(
        id: String,
        index: Int?,
        number: Int,
        title: String,
        sections: [LawSection]?,
        content: String?,
        displayableNumber: String
    ) {
        self.id = id
        self.index = index
        self.number = number
        self.title = title
        self.sections = sections
        self.content = content
        self.displayableNumber = displayableNumber
    }
}
