import OpenApi
import Data
import LawHierarchy
import LawParser

public func document() {
    let objects: [Documentable.Type] = [
        Law.self,
        LawSubpoint.self,
        LawSection.self,
        LawParagraph.self,
        LawChapter.self,
        LawMeta.self,
        LawBody.self
    ]

    let controllers: [Documentable.Type] = [
        LawController.self,
        LawParserController.self
    ]

    (objects + controllers).forEach { $0.defineDocumentation() }
}
