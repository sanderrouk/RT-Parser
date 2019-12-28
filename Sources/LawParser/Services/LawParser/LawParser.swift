import Foundation

final class LawParser: NSObject, XMLParserDelegate {

    enum Error: Swift.Error {
        case malformedXml
        case parsingFailed
    }

    private var elementStack = [LawElements]()
    private var inElement = LawElements.none
    private var subpointParsingContainer: SubpointParsingContainer?
    private var sectionParsingContainer: SectionParsingContainer?

    private var sections = [LawSection]()

    private var inSection: Bool {
        return sectionParsingContainer != nil
    }

    private var inSubpoint: Bool {
        return subpointParsingContainer != nil
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
    }

    func parse(rawXml: Data) throws -> [LawSection] {
        let xmlParser = XMLParser(data: rawXml)
        xmlParser.delegate = self
        guard xmlParser.parse() else { throw Error.parsingFailed }
        return sections
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

        case .loige:
            sectionParsingContainer = SectionParsingContainer()
            handleAttributes(attributeDict)

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

        case .alampunkt where inSubpoint:
            let container = subpointParsingContainer!
            guard let number = container.number else { return }

            let subpoint = LawSubpoint(
                id: container.id,
                number: number,
                content: container.content
            )

            sectionParsingContainer?.subpoints.append(subpoint)
            subpointParsingContainer = nil

        case .loige where inSection:
            let container = sectionParsingContainer!

            let section = LawSection(
                id: container.id,
                number: container.number,
                content: container.content,
                subpoints: container.subpoints.isEmpty ? nil : container.subpoints
            )

            sections.append(section)
            sectionParsingContainer = nil

        default:
            break
        }

    }

    private func handleAttributes(_ attributes: [String: String]) {
        switch inElement {

        case .alampunkt:
            guard let id = attributes[Attributes.id.rawValue] else { return }
            subpointParsingContainer?.id = id

        case .loige:
            guard let id = attributes[Attributes.id.rawValue] else { return }
            sectionParsingContainer?.id = id

        default:
            break
        }
    }

    private func stripCDATA(from string: String) -> String {
        return string.replacingOccurrences(of: "<!\\[CDATA\\[|\\]\\]>", with: "", options: [.regularExpression])
    }
}
