import Data

struct ChapterParsingContainer {
    var id = ""
    var number: Int?
    var title = ""
    var paragraphs = [LawParagraph]()
    var displayableNumber: String?
}
