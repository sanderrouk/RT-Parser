struct LawPart: Codable {
    let id: String
    let number: Int
    let chapters: [LawChapter]
}
