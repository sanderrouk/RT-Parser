import OpenApi

extension LawSubpoint: Documentable {
    fileprivate static let lawSubpoint = LawSubpoint(
        id: "sub1",
        number: 1,
        index: nil,
        content: "Law subpoint 1",
        displayableNumber: "1"
    )

    public static func defineDocumentation() {
        OpenApi.defineObject(object: lawSubpoint)
    }
}

extension LawSection: Documentable {
    fileprivate static let lawSection = LawSection(
        id: "sec2",
        number: 1,
        index: nil,
        content: "Law section 2",
        subpoints: [LawSubpoint.lawSubpoint],
        displayableNumber: "1"
    )

    public static func defineDocumentation() {
        OpenApi.defineObject(object: lawSection)
    }
}

extension LawParagraph: Documentable {
    fileprivate static let lawParagraph = LawParagraph(
        id: "para1",
        index: nil,
        number: 1,
        title: "Law Paragraph 1",
        sections: [LawSection.lawSection],
        content: nil,
        displayableNumber: "1"
    )

    public static func defineDocumentation() {
        OpenApi.defineObject(object: lawParagraph)
    }
}

extension LawChapter: Documentable {
    fileprivate static let lawChapter = LawChapter(
        id: "chapter1",
        number: 1,
        title: "Law Chapter 1",
        paragraphs: [LawParagraph.lawParagraph],
        displayableNumber: "1"
    )

    public static func defineDocumentation() {
        OpenApi.defineObject(object: lawChapter)
    }
}

extension LawMeta: Documentable {
    fileprivate static let lawMeta = LawMeta(
        passed: "passed",
        published: "published",
        inForceFrom: "inForceFrom",
        inForceUntil: nil,
        entryIntoForce: "entryIntoForce",
        abbreviation: "law",
        textType: "textType",
        actType: "actType",
        issuer: "issuer"
    )

    public static func defineDocumentation() {
        OpenApi.defineObject(object: lawMeta)
    }
}

extension LawBody: Documentable {
    fileprivate static let lawBody = LawBody(
        title: "Law 1",
        meta: LawMeta.lawMeta,
        chapters: [LawChapter.lawChapter]
    )

    public static func defineDocumentation() {
        OpenApi.defineObject(object: lawBody)
    }
}
