import Vapor

public struct LawParagraph: Content {
    let id: String
    let index: Int?
    let number: Int
    let title: String
    let sections: [LawSection]?
    let content: String?
    let displayableNumber: String
}
