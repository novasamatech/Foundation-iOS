import XCTest
import Foundation_iOS

class InputHandlingRestrictionsTests: XCTestCase {

    func testMaxLengthRestriction() {
        // given

        let someChanges = "some changes"

        let inputHandler = InputHandler(maxLength: someChanges.count)

        // when

        _ = inputHandler.didReceiveReplacement(someChanges, for: NSRange(location: 0, length: 0))
        _ = inputHandler.didReceiveReplacement(someChanges, for: NSRange(location: someChanges.count, length: 0))

        // then

        XCTAssertEqual(someChanges, inputHandler.value)
    }

    func testMinLengthRestriction() {
        // given

        let someChanges = "some changes"

        let inputHandler = InputHandler(value: someChanges, minLength: someChanges.count)

        // when

        _ = inputHandler.didReceiveReplacement("", for: NSRange(location: 0, length: someChanges.count))

        // then

        XCTAssertEqual(inputHandler.value, someChanges)
    }

    func testRejectInputIfDisabled() {
        // given

        let inputHandler = InputHandler(enabled: false)

        // when

        _ = inputHandler.didReceiveReplacement("some changes", for: NSRange(location: 0, length: 0))

        // then

        XCTAssertTrue(inputHandler.value.isEmpty)
    }

    func testCanInputAnyCharacterWhenValidationSetNil() {
        // given

        let changes = "😀привет日本語"

        let inputHandler = InputHandler()

        // when

        _ = inputHandler.didReceiveReplacement(changes, for: NSRange(location: 0, length: 0))

        // then

        XCTAssertEqual(inputHandler.value, changes)
    }
}
