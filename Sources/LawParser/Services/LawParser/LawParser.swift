import Foundation

final class LawParser: NSObject, XMLParserDelegate {

    enum Error: Swift.Error {
        case malformedXml
        case parsingFailed
    }

    private var elementStack = [LawElements]()
    private var inElement = LawElements.none
    private var subpointParsingContainer: SubpointParsingContainer?

    private var subpoints = [LawSubpoint]()

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

    func parse(rawXml: Data) throws -> [LawSubpoint] {
        let xmlParser = XMLParser(data: rawXml)
        xmlParser.delegate = self
        guard xmlParser.parse() else { throw Error.parsingFailed }
        return subpoints
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
        default: break
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
        case .alampunkt where subpointParsingContainer != nil:
            let container = subpointParsingContainer!
            guard let number = container.number else { return
            }
            let subpoint = LawSubpoint(
                id: container.id,
                number: number,
                conent: container.content
            )
            //TODO: Add Subpoint to outer container
            subpoints.append(subpoint)
            subpointParsingContainer = nil
        default:
            break
        }

    }

    func parser(
        _ parser: XMLParser,
        foundCharacters string: String
    ) {
        switch inElement {
        case .sisutekst where subpointParsingContainer != nil,
             .tavatekst where subpointParsingContainer != nil:
            subpointParsingContainer?.content += string
        case .alampunktNr where subpointParsingContainer != nil:
            subpointParsingContainer?.number = Int(string)
        default:
            break
        }
    }

    private func handleAttributes(_ attributes: [String: String]) {
        switch inElement {
        case .alampunkt:
            guard let id = attributes[Attributes.id.rawValue] else { return }
            subpointParsingContainer?.id = id
        default:
            break
        }
    }
}
