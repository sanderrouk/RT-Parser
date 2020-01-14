#if os(Linux)

import XCTest
@testable import LawParserTests

XCTMain([
    // AppTests
    testCase(LawParserTests.allTests)
])

#endif
