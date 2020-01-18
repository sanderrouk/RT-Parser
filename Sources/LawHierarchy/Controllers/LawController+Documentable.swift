import Data
import OpenApi

extension LawController: Documentable {
    public static func defineDocumentation() {
        let findLaws = OpenApi.defineAction(
            method: .get,
            route: "/api/v1/laws",
            summary: "List all laws in Riigiteataja",
            description: findLawsDescription,
            parameters: nil,
            request: nil,
            responses:
            [
                OpenApi.response(
                    code: "200",
                    description: "The list of found laws without law bodies.",
                    array: Law.self
                ),
                OpenApi.response(
                    code: "204",
                    description: "The returned list is empty but the request succeeded. This most likely means that the cache has not yet been generated and the request should be re-attempted.",
                    array: Law.self
                ),
                OpenApi.response(
                    code: "500",
                    description: "Something went wrong on the server side. This should never occur unless something breaks really badly. The RT-Parser service is at fault here.")
            ],
            authorization: false
        )

        OpenApi.defineController(
            name: "Law Hierarchy",
            description: "The laws have a flat hierarchy meaning that there is just a flat list of laws. There are no plans to implement a more complex hierarchy for laws at this time.",
            externalDocs: nil,
            actions: [findLaws]
        )
    }
}

private let findLawsDescription =
"""
Returns a list of all the cached laws from Riigiteataja. This list is updated every 12 hours.
The counter starts when the service is first deployed and is ran every twelve hours after that.

This list does not include the `LawBody` structure at this time as currently there is no support
for caching `LawBody` objects. The support for this should be added for version 1.0.0 as a separate API endpoint.

This information can be used to fetch the appropriate XML files for all the laws as well as get
the abbreviations which can be sent to another endpoint to fetch the parsed JSON `LawBody` object.
"""
