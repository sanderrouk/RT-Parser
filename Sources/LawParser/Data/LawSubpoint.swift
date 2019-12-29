import Vapor

struct LawSubpoint: Codable {
    let id: String
    let number: Int?
    let index: String?
    let content: String
}
