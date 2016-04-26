import XCTest
@testable import Sideburns

class SideburnsTests: XCTestCase {
    func testReality() {
        XCTAssert(2 + 2 == 4, "Something is severely wrong here.")
    }
}

extension SideburnsTests {
    static var allTests: [(String, SideburnsTests -> () throws -> Void)] {
        return [
           ("testReality", testReality),
        ]
    }
}
