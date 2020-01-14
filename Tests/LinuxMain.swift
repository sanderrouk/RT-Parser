#if os(Linux)

import XCTest
import LawParserTests

XCTMain([
    // AppTests
    testCase(LawParserTests.allTests)
])

#endif
