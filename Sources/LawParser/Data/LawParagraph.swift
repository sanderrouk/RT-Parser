struct LawParagraph: Codable {
    let id: String
    let index: Int
    let number: Int
    let title: String
    let sections: [LawSection]
}
