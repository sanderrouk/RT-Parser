import Foundation

final class LawParser: NSObject, XMLParserDelegate {

    enum Error: Swift.Error {
        case malformedXml
        case parsingFailed
    }

    private var elementStack = [LawElements]()
    private var inElement = LawElements.none

    private var legislation: LawBody?

    private var subpointParsingContainer: SubpointParsingContainer?
    private var sectionParsingContainer: SectionParsingContainer?
    private var paragraphParsingContainer: ParagraphParsingContainer?
    private var chapterParsingContainer: ChapterParsingContainer?
    private var metaParsingContainer: MetaParsingContainer?
    private var bodyParsingContainer: BodyParsingContainer?

    private var inSubpoint: Bool {
        return subpointParsingContainer != nil
    }

    private var inSection: Bool {
        return sectionParsingContainer != nil
    }

    private var inParagraph: Bool {
        return paragraphParsingContainer != nil
    }

    private var inChapter: Bool {
        return chapterParsingContainer != nil
    }

    private var inMeta: Bool {
        return metaParsingContainer != nil
    }

    private var inBody: Bool {
        return bodyParsingContainer != nil
    }

    private enum Superscripts: String {
        case zero = "\u{2070}"
        case one = "\u{00B9}"
        case two = "\u{00B2}"
        case three = "\u{00B3}"
        case four = "\u{2074}"
        case five = "\u{2075}"
        case six = "\u{2076}"
        case seven = "\u{2077}"
        case eight = "\u{2078}"
        case nine = "\u{2079}"
    }

    private enum Attributes: String {
        case id
        case ylaIndeks
    }

    func parse(rawXml: Data) throws -> LawBody {
        let xmlParser = XMLParser(data: rawXml)
        xmlParser.delegate = self
        guard xmlParser.parse(),
            let legislation = legislation
            else { throw Error.parsingFailed }

        self.legislation = nil
        return legislation
    }

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        guard let element = LawElements(rawValue: elementName) else { return }
        inElement = element
        elementStack.append(element)

        switch element {

        case .alampunkt:
            subpointParsingContainer = SubpointParsingContainer()
            handleAttributes(attributeDict)

        case .alampunktNr:
            handleAttributes(attributeDict)

        case .loige:
            sectionParsingContainer = SectionParsingContainer()
            handleAttributes(attributeDict)

        case .loigeNr:
            handleAttributes(attributeDict)

        case .paragrahv:
            paragraphParsingContainer = ParagraphParsingContainer()
            handleAttributes(attributeDict)

        case .paragrahvNr:
            handleAttributes(attributeDict)

        case .peatykk:
            chapterParsingContainer = ChapterParsingContainer()
            handleAttributes(attributeDict)

        case .metadata:
            metaParsingContainer = MetaParsingContainer()

        case .legislation:
            bodyParsingContainer = BodyParsingContainer()

        default: break
        }
    }

    func parser(
        _ parser: XMLParser,
        foundCharacters string: String
    ) {
        switch inElement {

        // Subpoint
        case .sisutekst where inSubpoint,
             .tavatekst where inSubpoint:
            subpointParsingContainer?.content += string

        case .kuvatavtekst where inSubpoint:
            subpointParsingContainer?.content += stripCDATA(from: string)

        case .alampunktNr where inSubpoint:
            subpointParsingContainer?.number = Int(string)

        // Section
        case .loigeNr where inSection:
            sectionParsingContainer?.number = Int(string)

        case .sisutekst where inSection,
             .tavatekst where inSection:
            sectionParsingContainer?.content += string

        case .kuvatavtekst where inSection:
            sectionParsingContainer?.content += stripCDATA(from: string)

        // Paragraph
        case .paragrahvNr where inParagraph:
            paragraphParsingContainer?.number = Int(string)
        case .paragrahvPealkiri where inParagraph:
            paragraphParsingContainer?.title += string
        case .sisutekst where inParagraph,
             .tavatekst where inParagraph,
             .kuvatavtekst where inParagraph:
            let content = paragraphParsingContainer?.content ?? ""
            paragraphParsingContainer?.content = content + stripCDATA(from: string)

        // Chapter
        case .peatykkNr where inChapter:
            chapterParsingContainer?.number = Int(string)
        case .peatykkPealkiri where inChapter:
            chapterParsingContainer?.title += string

        // Metadata
        case .issuer where inMeta:
            metaParsingContainer?.issuer += string
        case .actType where inMeta:
            metaParsingContainer?.actType += string
        case .textType where inMeta:
            metaParsingContainer?.textType += string
        case .abbreviation where inMeta:
            metaParsingContainer?.abbreviation += string
        case .entryIntoForce where inMeta:
            metaParsingContainer?.entryIntoForce += string
        case .inForceFrom where inMeta:
            metaParsingContainer?.inForceFrom += string
        case .inForceUntil where inMeta:
            metaParsingContainer?.inForceUntil += string
        case .published where inMeta:
            metaParsingContainer?.published += string
        case .passed where inMeta:
            metaParsingContainer?.passed += string

        // Body
        case .title where inBody:
            bodyParsingContainer?.title += string

        default:
            break
        }
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        guard let element = LawElements(rawValue: elementName) else { return }
        elementStack.removeLast()
        inElement = elementStack.last ?? .none

        switch element {

        // Subpoint
        case .alampunkt where inSubpoint:
            let container = subpointParsingContainer!
            guard let number = container.number else { return }

            let subpoint = LawSubpoint(
                id: container.id,
                number: number,
                index: container.index,
                content: container.content
            )

            sectionParsingContainer?.subpoints.append(subpoint)
            subpointParsingContainer = nil

        // Section
        case .loige where inSection:
            let container = sectionParsingContainer!

            let section = LawSection(
                id: container.id,
                number: container.number,
                index: container.index,
                content: container.content,
                subpoints: container.subpoints.isEmpty ? nil : container.subpoints
            )

            paragraphParsingContainer?.sections.append(section)
            sectionParsingContainer = nil

        // Paragraph
        case .paragrahv where inParagraph:
            let container = paragraphParsingContainer!
            guard let number = container.number else { return }

            let paragraph = LawParagraph(
                id: container.id,
                index: container.index,
                number: number,
                title: container.title,
                sections: container.sections.isEmpty ? nil : container.sections,
                content: container.content
            )

            chapterParsingContainer?.paragraphs.append(paragraph)
            paragraphParsingContainer = nil

        // Chapter
        case .peatykk where inChapter:
            let container = chapterParsingContainer!
            guard let number = container.number else { return }

            let chapter = LawChapter(
                id: container.id,
                number: number,
                title: container.title,
                paragraphs: container.paragraphs
            )

            bodyParsingContainer?.chapters.append(chapter)
            chapterParsingContainer = nil

        // Metadata
        case .metadata where inMeta:
            let container = metaParsingContainer!

            let metadata = LawMeta(
                passed: container.passed,
                published: container.published,
                inForceFrom: container.inForceFrom,
                inForceUntil: container.inForceUntil,
                entryIntoForce: container.entryIntoForce,
                abbreviation: container.abbreviation,
                textType: container.textType,
                actType: container.actType,
                issuer: container.issuer
            )

            bodyParsingContainer?.meta = metadata
            metaParsingContainer = nil

        case .legislation where inBody:
            let container = bodyParsingContainer!
            guard let metadata = container.meta else { return }

            let lawBody = LawBody(
                title: container.title,
                meta: metadata,
                chapters: container.chapters
            )

            legislation = lawBody
            bodyParsingContainer = nil

        default:
            break
        }
    }

    private func handleAttributes(_ attributes: [String: String]) {
        switch inElement {

        case .alampunkt:
            guard let id = attributes[Attributes.id.rawValue] else { return }
            subpointParsingContainer?.id = id

        case .alampunktNr:
            guard let index = attributes[Attributes.ylaIndeks.rawValue] else { return }
            subpointParsingContainer?.index = convertToSuperscript(from: index)

        case .loige:
            guard let id = attributes[Attributes.id.rawValue] else { return }
            sectionParsingContainer?.id = id

        case .loigeNr:
            guard let index = attributes[Attributes.ylaIndeks.rawValue] else { return }
            sectionParsingContainer?.index = convertToSuperscript(from: index)

        case .paragrahv:
            guard let id = attributes[Attributes.id.rawValue] else { return }
            paragraphParsingContainer?.id = id

        case .paragrahvNr:
            guard let index = attributes[Attributes.ylaIndeks.rawValue] else { return }
            paragraphParsingContainer?.index = convertToSuperscript(from: index)

        case .peatykk:
            guard let id = attributes[Attributes.id.rawValue] else { return }
            chapterParsingContainer?.id = id

        default:
            break
        }
    }

    private func stripCDATA(from string: String) -> String {
        return string.replacingOccurrences(of: "<!\\[CDATA\\[|\\]\\]>", with: "", options: [.regularExpression])
    }

    private func convertToSuperscript(from string: String) -> String {
        return string
            .replacingOccurrences(of: "0", with: Superscripts.zero.rawValue)
            .replacingOccurrences(of: "1", with: Superscripts.one.rawValue)
            .replacingOccurrences(of: "2", with: Superscripts.two.rawValue)
            .replacingOccurrences(of: "3", with: Superscripts.three.rawValue)
            .replacingOccurrences(of: "4", with: Superscripts.four.rawValue)
            .replacingOccurrences(of: "5", with: Superscripts.five.rawValue)
            .replacingOccurrences(of: "6", with: Superscripts.six.rawValue)
            .replacingOccurrences(of: "7", with: Superscripts.seven.rawValue)
            .replacingOccurrences(of: "8", with: Superscripts.eight.rawValue)
            .replacingOccurrences(of: "9", with: Superscripts.nine.rawValue)
    }
}
