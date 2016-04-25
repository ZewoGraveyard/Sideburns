#if os(Linux)

import XCTest
@testable import SideburnsTestSuite

XCTMain([
    testCase(SideburnsTests.allTests)
])

#endif
