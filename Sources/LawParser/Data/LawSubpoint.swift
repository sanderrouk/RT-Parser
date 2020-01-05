import Vapor

struct LawSubpoint: Content {
    let id: String
    let number: Int?
    let index: Int?
    let content: String
    let displayableNumber: String?
}
