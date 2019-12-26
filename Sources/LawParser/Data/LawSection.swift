struct LawSection: Codable {
    let id: String
    let number: Int?
    let content: String
    let subpoints: [LawSubpoint]
}
