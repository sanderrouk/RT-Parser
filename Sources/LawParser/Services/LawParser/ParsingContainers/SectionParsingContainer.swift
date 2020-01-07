import Data

struct SectionParsingContainer {
    var id = ""
    var number: Int?
    var index: Int?
    var content = ""
    var subpoints = [LawSubpoint]()
    var displayableNumber: String?
}
