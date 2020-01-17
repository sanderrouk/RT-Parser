#if os(Linux)

import XCTest
@testable import LawHierarchyTests
@testable import LawParserTests

XCTMain([
    testCase(LawServiceTests.allTests),
    testCase(LawUrlAndAbbreviationProviderTests.allTests),
    testCase(LawParserTests.allTests),
    testCase(LawParsingServiceTests.allTests)
])

#endif
