import XCTest
import Foundation_iOS

class DuplicateCharacterPreprocessorTests: XCTestCase {
    func testDuplicationsErasure() {
        let preprocessor = DuplicatingCharacterProcessor(charset: CharacterSet(charactersIn: "-+"))

        XCTAssertEqual(preprocessor.process(text: "swift---alive"), "swift-alive")
        XCTAssertEqual(preprocessor.process(text: "swift+++alive"), "swift+alive")
        XCTAssertEqual(preprocessor.process(text: "swift'''alive"), "swift'''alive")
        XCTAssertEqual(preprocessor.process(text: "---swift"), "-swift")
        XCTAssertEqual(preprocessor.process(text: "swift---"), "swift-")
        XCTAssertEqual(preprocessor.process(text: "+++"), "+")
        XCTAssertEqual(preprocessor.process(text: ""), "")
    }
}
