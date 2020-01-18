import Data
import OpenApi

extension LawParserController: Documentable {
    public static func defineDocumentation() {
        let parseLaw = OpenApi.defineAction(
            method: .get,
            route: "/api/v1/parse-law/:law_abbreviation",
            summary: "Parses a law based on the provided abbreviation.",
            description: parseLawDescription,
            parameters: [
                OpenApi.parameter(
                    name: "Law Abbreviation",
                    parameterLocation: .path,
                    description: "The official case sensitive abbreviation of the law. Should be URL encoded in case of special characters such as VÕS being V%C3%95S.",
                    required: true,
                    deprecated: false,
                    allowEmptyValue: false,
                    dataType: .string
                )
            ],
            request: nil,
            responses:
            [
                OpenApi.response(
                    code: "200",
                    description: "Successfully fetched the XML from Riigiteataja and parsed it into the corresponding JSON.",
                    object: LawBody.self,
                    contentType: "application/json"
                ),
                OpenApi.response(
                    code: "404",
                    description: parseLawResponse404
                ),
                OpenApi.response(
                    code: "500",
                    description: "Parsing of the XML fetched from Riigiteataja failed. If this happens then the current version of RT-Parser does not support parsing this specific law and a issue should be created on the project's GitHub page if a newer version of the project is not out yet."
                ),
                // Service unavailable
                OpenApi.response(
                    code: "503",
                    description: "RT-Parser failed to communicate with Riigiteataja. If this happens verify that Riigiteataja.ee is responsive and try again."
                )
            ],
            authorization: false
        )

        OpenApi.defineController(
            name: "Parse Law",
            description: "In order to invoke XML parsing into JSON the following endpoint should be called. Caching of law JSON's will be implemented in version 1.0.0",
            externalDocs: nil,
            actions: [parseLaw]
        )
    }
}

private let parseLawDescription =
"""
This endpoint is used to get a JSON format of a law from Riigiteataja. RT-Parser takes in a case sensitive, url encoded official abbreviation of a law and fetches the latest appropriate XML for this law from Riigiteatja.ee. After fetching the XML it then parses the XML into a JSON format and returns it. Currently the law is returned in hierarchical structure composed of the following elements: `LawBody` owning `LawMeta` and a list of `LawChapter` objects. `LawChapter` owning a list of `LawParagraph` objects. `LawParagraph` owning a list of `LawSection` objects and `LawSection` owning a list of `LawSubpoint` objects. The current structure has issues with supporting some laws which do not use chapters. This will be fixed in version 1.0.0.

For a more detailed overview of the properties on each object consult the following snipet:

```swift
public struct LawBody {
    let title: String
    let meta: LawMeta
    let chapters: [LawChapter]
}

public struct LawMeta {
    let passed: String
    let published: String
    let inForceFrom: String
    let inForceUntil: String?
    let entryIntoForce: String
    let abbreviation: String
    let textType: String
    let actType: String
    let issuer: String
}

public struct LawChapter {
    let id: String
    let number: Int
    let title: String
    let paragraphs: [LawParagraph]
    let displayableNumber: String
}

public struct LawParagraph {
    let id: String
    let index: Int?
    let number: Int
    let title: String?
    let sections: [LawSection]?
    let content: String?
    let displayableNumber: String
}

public struct LawSection {
    let id: String
    let number: Int?
    let index: Int?
    let content: String
    let subpoints: [LawSubpoint]?
    let displayableNumber: String?
}

public struct LawSubpoint {
    let id: String
    let number: Int
    let index: Int?
    let content: String
    let displayableNumber: String
}
```

Some common elements can be seen on each of the objects. The `id` property of each of the objects comes straight from Riigiteataja and is the same as the XML property would have. The property `displayableNumber` is a combined property of the `number` property and the `index` property where index will be superscripted generating the following format: `3¹`

In version 1.0.0 the `LawBody` object will also receive a list of `LawParagraph` objects to enable the usage of chapterless laws as well as support "hanging" paragraphs.
"""

private let parseLawResponse404 =
"""
The 404 can happen in two differnet ways.

1. The request URL has a missing abbreviation in which case 404 is returned as no other endpoints match this route.
2. No law matching the **case sensitive** official abbreviation of the law was found in the service's cache. If this is the case then check that the abbreviation is definitely correct, one way to make sure is to try to use it as a Riigiteataja url like this: https://www.riigiteataja.ee/akt/AS where `AS` is the abbreviation. If the abbreviation is indeed correct then another request should be made soon as the cache might not yet be up to date, however this should only happen if the service was just down.
"""
