import Vapor

struct LawSubpoint: Codable {
    let id: String
    let number: Int?
    let content: String
}
