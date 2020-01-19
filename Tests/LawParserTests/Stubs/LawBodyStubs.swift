@testable import Data

let lawSubpoint = LawSubpoint(
    id: "sub1",
    number: 1,
    index: nil,
    content: "Law subpoint 1",
    displayableNumber: "1"
)

let lawSection = LawSection(
    id: "sec1",
    number: nil,
    index: nil,
    content: "Law section 1",
    subpoints: nil,
    displayableNumber: nil
)

let lawSection2 = LawSection(
    id: "sec2",
    number: 1,
    index: nil,
    content: "Law section 2",
    subpoints: [lawSubpoint],
    displayableNumber: "1"
)

let lawParagraph = LawParagraph(
    id: "para1",
    index: nil,
    number: 1,
    title: "Law Paragraph 1",
    sections: [lawSection],
    content: nil,
    displayableNumber: "1"
)

let lawParagraph2 = LawParagraph(
    id: "para2",
    index: nil,
    number: 2,
    title: "Law Paragraph 2",
    sections: [lawSection2],
    content: nil,
    displayableNumber: "2"
)

let lawChapter = LawChapter(
    id: "chapter1",
    number: 1,
    title: "Law Chapter 1",
    paragraphs: [lawParagraph],
    displayableNumber: "1"
)

let lawChapter2 = LawChapter(
    id: "chapter2",
    number: 2,
    title: "Law Chapter 2",
    paragraphs: [lawParagraph2],
    displayableNumber: "2"
)

let lawMeta = LawMeta(
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

let lawBody = LawBody(
    title: "Law 1",
    meta: lawMeta,
    chapters: [lawChapter, lawChapter2],
    chapterlessParagraphs: nil
)

let lawBodyWithChapterlessParagraphs = LawBody(
    title: "Law 1",
    meta: lawMeta,
    chapters: [lawChapter, lawChapter2],
    chapterlessParagraphs: [lawParagraph, lawParagraph2]
)
