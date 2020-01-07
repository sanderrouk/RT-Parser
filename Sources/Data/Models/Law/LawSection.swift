import Vapor

public struct LawSection: Content {

    let id: String
    let number: Int?
    let index: Int?
    let content: String
    let subpoints: [LawSubpoint]?
    let displayableNumber: String?

    public init(
        id: String,
        number: Int?,
        index: Int?,
        content: String,
        subpoints: [LawSubpoint]?,
        displayableNumber: String?
    ) {
        self.id = id
        self.number = number
        self.index = index
        self.content = content
        self.subpoints = subpoints
        self.displayableNumber = displayableNumber
    }
}
