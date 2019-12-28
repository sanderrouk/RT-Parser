import Vapor

public struct LawParagraph: Content {
    let id: String
    let index: String?
    let number: Int
    let title: String
    let sections: [LawSection]
}
