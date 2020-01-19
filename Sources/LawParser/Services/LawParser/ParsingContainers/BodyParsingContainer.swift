import Data

struct BodyParsingContainer {
    var title: String?
    var meta: LawMeta?
    var chapters = [LawChapter]()
    var chapterlessParagraphs = [LawParagraph]()
}
