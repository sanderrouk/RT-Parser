public struct LawCategoryWithLaws: Codable {

    public var id: Int?
    public var title: String
    public var laws: [Law]

    public init(lawCategory: LawCategory, laws: [Law]) {
        self.id = lawCategory.id
        self.title = lawCategory.title
        self.laws = laws
    }
}
