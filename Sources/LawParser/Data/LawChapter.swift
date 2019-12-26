struct LawChapter: Codable {
    let id: String
    let number: Int
    let title: String
    let divisions: [LawDivision]
}
