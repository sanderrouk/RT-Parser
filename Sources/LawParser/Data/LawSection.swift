import Vapor

public struct LawSection: Content {
    let id: String
    let number: Int?
    let index: String?
    let content: String
    let subpoints: [LawSubpoint]?
}
