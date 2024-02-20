import XCTest
import Foundation_iOS

class TrimmingCharacterPreprocessorTests: XCTestCase {
    func testPrefixErasure() {
        let preprocessor = TrimmingCharacterProcessor(charset: CharacterSet(charactersIn: "-+"))

        XCTAssertEqual(preprocessor.process(text: "---swift"), "swift")
        XCTAssertEqual(preprocessor.process(text: "++swift++"), "swift")
        XCTAssertEqual(preprocessor.process(text: "''swift"), "''swift")
        XCTAssertEqual(preprocessor.process(text: "swift---"), "swift")
        XCTAssertEqual(preprocessor.process(text: "+++"), "")
        XCTAssertEqual(preprocessor.process(text: ""), "")
    }
}
