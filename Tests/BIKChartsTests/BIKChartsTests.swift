import XCTest
@testable import BIKCharts

final class BIKChartsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BIKCharts().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
