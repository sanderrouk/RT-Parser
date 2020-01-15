import Vapor

public struct LawSubpoint: Content, Equatable {

    let id: String
    let number: Int
    let index: Int?
    let content: String
    let displayableNumber: String

    public init(
        id: String,
        number: Int,
        index: Int?,
        content: String,
        displayableNumber: String
    ) {
        self.id = id
        self.number = number
        self.index = index
        self.content = content
        self.displayableNumber = displayableNumber
    }
}
