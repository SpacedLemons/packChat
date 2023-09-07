import XCTest
@testable import PackChat_iOS_Developer_Test

class ColoursViewControllerTests: XCTestCase {

    func testAddColourToSelectedList() {
        let viewController = ColoursViewController()

        viewController.addColourToSelectedList("Red")

        XCTAssertTrue(viewController.selectedColours.contains("Red"), "Color not added to selectedColours")
    }
}
