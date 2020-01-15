#if os(Linux)

import XCTest
@testable import LawParserTests

XCTMain([
    testCase(LawParserTests.allTests),
    testCase(LawParsingServiceTests.allTests)
])

#endif
