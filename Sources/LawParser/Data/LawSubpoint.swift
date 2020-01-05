import Vapor

struct LawSubpoint: Content {
    let id: String
    let number: Int?
    let index: String?
    let content: String
}
