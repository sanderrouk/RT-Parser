import XCTest
@testable import LawParser
@testable import Data

class LawParserTests: XCTestCase {
    static let allTests = [
        ("testParserParsesLawBody", testParserParsesLawBody),
        ("testParsingLawFails_missingTitleOrMissingMeta", testParsingLawFails_missingTitleOrMissingMeta),
        ("testParsesMetadata", testParsesMetadata),
        ("testParsesChapters", testParsesChapters),
        ("testParsesParagraphs", testParsesParagraphs),
        ("testParsesSections", testParsesSections),
        ("testParsesSubpoints", testParsesSubpoints)
    ]

    let parser = LawParser()

    func testParserParsesLawBody() {
        let law = Laws.artificialLawWithChaptersAndParagraphs
        XCTAssertNoThrow(try parser.parse(rawXml: law))
        let lawBody = try! parser.parse(rawXml: law)
        XCTAssertEqual(lawBody.chapters.count, 1)
        XCTAssertEqual(lawBody.title, "Pühade ja tähtpäevade seadus")
    }

    func testParsingLawFails_missingTitleOrMissingMeta() {
        XCTAssertThrowsError(try parser.parse(rawXml: Laws.lawWithoutTitle))
        XCTAssertThrowsError(try parser.parse(rawXml: Laws.lawWithoutMetaData))
    }

    func testParsesMetadata() {
        let lawWithMetaInForceUntilNil = Laws.artificialLawWithChaptersAndParagraphs
        XCTAssertNoThrow(try parser.parse(rawXml: lawWithMetaInForceUntilNil))
        let lawBody = try! parser.parse(rawXml: lawWithMetaInForceUntilNil)

        let meta = lawBody.meta
        XCTAssertEqual(meta.passed, "1998-01-27")
        XCTAssertEqual(meta.published, "2018-06-12+03:00")
        XCTAssertEqual(meta.inForceFrom, "2018-06-22")
        XCTAssertEqual(meta.inForceUntil, nil)
        XCTAssertEqual(meta.entryIntoForce, "1998-02-23")
        XCTAssertEqual(meta.abbreviation, "PTS")
        XCTAssertEqual(meta.textType, "terviktekst")
        XCTAssertEqual(meta.actType, "seadus")
        XCTAssertEqual(meta.issuer, "Riigikogu")

        let lawWithInForceUntilNotNil = Laws.shortLawWithInForceUntilInMeta
        XCTAssertNoThrow(try parser.parse(rawXml: lawWithInForceUntilNotNil))
        let lawBody2 = try! parser.parse(rawXml: lawWithInForceUntilNotNil)

        let meta2 = lawBody2.meta
        XCTAssertEqual(meta2.passed, "1998-01-27")
        XCTAssertEqual(meta2.published, "2018-06-12+03:00")
        XCTAssertEqual(meta2.inForceFrom, "2018-06-22")
        XCTAssertEqual(meta2.inForceUntil, "2019-01-01")
        XCTAssertEqual(meta2.entryIntoForce, "1998-02-23")
        XCTAssertEqual(meta2.abbreviation, "PTS")
        XCTAssertEqual(meta2.textType, "terviktekst")
        XCTAssertEqual(meta2.actType, "seadus")
        XCTAssertEqual(meta2.issuer, "Riigikogu")
    }

    func testParsesChapters() {
        let lawWithZeroChapters = try! parser.parse(rawXml: Laws.lawWithZeroChapters)
        XCTAssertEqual(lawWithZeroChapters.chapters.count, 0)

        let lawWithOneChapter = try! parser.parse(rawXml: Laws.artificialLawWithChaptersAndParagraphs)
        XCTAssertEqual(lawWithOneChapter.chapters.count, 1)

        XCTAssertEqual(lawWithOneChapter.chapters.first!.id, "ptk1")
        XCTAssertEqual(lawWithOneChapter.chapters.first!.number, 1)
        XCTAssertEqual(lawWithOneChapter.chapters.first!.title, "Esimene peatükk")
        XCTAssertEqual(lawWithOneChapter.chapters.first!.displayableNumber, "1")

        let lawWithTwoChapters = try! parser.parse(rawXml: Laws.lawWithTwoChapters)
        XCTAssertEqual(lawWithTwoChapters.chapters.count, 2)

        XCTAssertEqual(lawWithTwoChapters.chapters.first!.id, "ptk1")
        XCTAssertEqual(lawWithTwoChapters.chapters.first!.number, 1)
        XCTAssertEqual(lawWithTwoChapters.chapters.first!.title, "Esimene peatükk")
        XCTAssertEqual(lawWithTwoChapters.chapters.first!.displayableNumber, "1")

        XCTAssertEqual(lawWithTwoChapters.chapters[1].id, "ptk2")
        XCTAssertEqual(lawWithTwoChapters.chapters[1].number, 2)
        XCTAssertEqual(lawWithTwoChapters.chapters[1].title, "Teine peatükk")
        XCTAssertEqual(lawWithTwoChapters.chapters[1].displayableNumber, "2")
    }

    func testParsesParagraphs() {
        let lawWithZeroParagaphs = try! parser.parse(rawXml: Laws.lawWithTwoChapters)
        XCTAssertEqual(lawWithZeroParagaphs.chapters[0].paragraphs.count, 0)
        XCTAssertEqual(lawWithZeroParagaphs.chapters[1].paragraphs.count, 0)

        let lawWithOneParagraph = try! parser.parse(rawXml: Laws.lawWithOneParagraph)
        XCTAssertEqual(lawWithOneParagraph.chapters.first!.paragraphs.count, 1)

        let paragraph = lawWithOneParagraph.chapters.first!.paragraphs.first!
        XCTAssertEqual(paragraph.id, "para1")
        XCTAssertEqual(paragraph.index, nil)
        XCTAssertEqual(paragraph.number, 1)
        XCTAssertEqual(paragraph.title, "Paragrahv 1")
        XCTAssertEqual(paragraph.sections?.count, 1)
        XCTAssertEqual(paragraph.content, nil)
        XCTAssertEqual(paragraph.displayableNumber, "1")

        let lawWithSevenDifferentParagraphs = try! parser.parse(rawXml: Laws.artificialLawWithChaptersAndParagraphs)
        XCTAssertEqual(lawWithSevenDifferentParagraphs.chapters.first!.paragraphs.count, 7)

        let paragraphs = lawWithSevenDifferentParagraphs.chapters.first!.paragraphs

        let paragraph1 = paragraphs[0]
        XCTAssertEqual(paragraph1.id, "para1")
        XCTAssertEqual(paragraph1.index, nil)
        XCTAssertEqual(paragraph1.number, 1)
        XCTAssertEqual(paragraph1.title, "Rahvuspüha")
        XCTAssertEqual(paragraph1.sections?.count, 1)
        XCTAssertEqual(paragraph1.content, nil)
        XCTAssertEqual(paragraph1.displayableNumber, "1")

        // Paragraph with index
        let paragraph3b1 = paragraphs[3]
        XCTAssertEqual(paragraph3b1.id, "para3b1")
        XCTAssertEqual(paragraph3b1.index, 1)
        XCTAssertEqual(paragraph3b1.number, 3)
        XCTAssertEqual(paragraph3b1.title, "Üleriigiline lein")
        XCTAssertEqual(paragraph3b1.sections?.count, 2)
        XCTAssertEqual(paragraph3b1.content, nil)
        XCTAssertEqual(paragraph3b1.displayableNumber, "3¹")

        // Paragraph without title and 0 sections
        let paragraph5 = paragraphs[5]
        XCTAssertEqual(paragraph5.id, "para5")
        XCTAssertEqual(paragraph5.index, nil)
        XCTAssertEqual(paragraph5.number, 5)
        XCTAssertEqual(paragraph5.title, nil)
        XCTAssertEqual(paragraph5.sections?.count, nil)
        XCTAssertEqual(paragraph5.content, "[Käesolevast tekstist välja jäetud.]")
        XCTAssertEqual(paragraph5.displayableNumber, "5")
    }

    func testParsesSections() {
        let lawWithZeroSections = try! parser.parse(rawXml: Laws.lawWithOneParagraphAndZeroSections)
        let emptyParagraph = lawWithZeroSections.chapters[0].paragraphs[0]
        XCTAssertTrue(emptyParagraph.sections == nil)

        let lawWithAllSectionCases = try! parser.parse(rawXml: Laws.lawWithAllSectionCases)
        let paragraph = lawWithAllSectionCases.chapters[0].paragraphs[0]
        XCTAssertEqual(paragraph.sections?.count, 3)

        let section1 = paragraph.sections![0]
        XCTAssertEqual(section1.id, "para1lg1")
        XCTAssertEqual(section1.number, nil)
        XCTAssertEqual(section1.index, nil)
        XCTAssertEqual(section1.content, "Para 1 lõige 1 tekst")
        XCTAssertTrue(section1.subpoints == nil)
        XCTAssertEqual(section1.displayableNumber, nil)

        let section2 = paragraph.sections![1]
        XCTAssertEqual(section2.id, "para1lg2")
        XCTAssertEqual(section2.number, nil)
        XCTAssertEqual(section2.index, nil)
        XCTAssertEqual(section2.content, "Para 1 lõige 2 tekst")
        XCTAssertEqual(section2.subpoints?.count, 1)
        XCTAssertEqual(section2.displayableNumber, nil)

        let section3 = paragraph.sections![2]
        XCTAssertEqual(section3.id, "para1lg3")
        XCTAssertEqual(section3.number, 2)
        XCTAssertEqual(section3.index, 1)
        XCTAssertEqual(section3.content, "Para 1 lõige 2b1 tekst")
        XCTAssertEqual(section3.subpoints?.count, nil)
        XCTAssertEqual(section3.displayableNumber, "2¹")
    }

    func testParsesSubpoints() {
        let lawWithZeroSubpoints = try! parser.parse(rawXml: Laws.lawWithOneParagraph)
        let emptySection = lawWithZeroSubpoints.chapters[0].paragraphs[0].sections![0]
        XCTAssertTrue(emptySection.subpoints == nil)

        let lawWithAllSubpointCases = try! parser.parse(rawXml: Laws.artificialLawWithChaptersAndParagraphs)

        let section = lawWithAllSubpointCases.chapters[0].paragraphs[1].sections![0]
        XCTAssertEqual(section.subpoints?.count, 11)

        let subpoint = section.subpoints![0]
        XCTAssertEqual(subpoint.id, "para2lg1p1")
        XCTAssertEqual(subpoint.number, 1)
        XCTAssertEqual(subpoint.index, nil)
        XCTAssertEqual(subpoint.content, "1. jaanuar – uusaasta;")
        XCTAssertEqual(subpoint.displayableNumber, "1")

        let subpointWithIndex = section.subpoints![8]
        XCTAssertEqual(subpointWithIndex.id, "para2lg1p8b1")
        XCTAssertEqual(subpointWithIndex.number, 8)
        XCTAssertEqual(subpointWithIndex.index, 1)
        XCTAssertEqual(subpointWithIndex.content, "24. detsember – jõululaupäev;")
        XCTAssertEqual(subpointWithIndex.displayableNumber, "8¹")
    }
}
