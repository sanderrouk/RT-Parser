struct LawBody: Codable {
    let abbreviation: String
    let name: String
    let meta: LawMeta
    let parts: [LawPart]
}
