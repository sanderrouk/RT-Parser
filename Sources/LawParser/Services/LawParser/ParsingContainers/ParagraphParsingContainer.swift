import Data

struct ParagraphParsingContainer {
    var id = ""
    var index: Int?
    var number: Int?
    var title: String?
    var sections = [LawSection]()
    var content: String?
    var displayableNumber: String?
}
