import Data
import Foundation

final class CategoryHierarchyParser: NSObject, XMLParserDelegate {

    enum Error: Swift.Error {
        case malformedXml
        case parsingFailed
    }

    private enum HierarchyElements: String {
        case category
        case categoryName = "catName"
        case law
        case void
    }

    private struct ParsingContainer {
        var categoryName = ""
        var lawName = ""
        var lawNames = [String]()
        var inCategory = HierarchyElements.void
    }

    private(set) var categories = [LawCategory]()
    private(set) var hierarchy = [String: [String]]()

    private var parsingContainer = ParsingContainer()

    func parse(rawXml: String) throws {
        parsingContainer = ParsingContainer()
        guard let xmlData = rawXml.data(using: .utf8) else { throw Error.malformedXml }
        let xmlParser = XMLParser(data: xmlData)
        xmlParser.delegate = self
        guard xmlParser.parse() else { throw Error.parsingFailed }
    }

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        guard let element = HierarchyElements(rawValue: elementName) else { return }
        parsingContainer.inCategory = element

        if element == .category {
            parsingContainer = .init()
        }
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        guard let element = HierarchyElements(rawValue: elementName) else { return }
        parsingContainer.inCategory = .void

        if element == .category, parsingContainer.categoryName != "" {
            let categoryName = parsingContainer.categoryName
            categories.append(LawCategory(id: nil, title: categoryName))
            hierarchy[categoryName] = parsingContainer.lawNames
        } else if element == .law, parsingContainer.lawName != "" {
            parsingContainer.lawNames.append(parsingContainer.lawName)
            parsingContainer.lawName = ""
        }
    }

    func parser(
        _ parser: XMLParser,
        foundCharacters string: String
    ) {
        switch parsingContainer.inCategory {
        case .categoryName:
            parsingContainer.categoryName += string
        case .law:
            parsingContainer.lawName += string
        default: break
        }
    }
}
