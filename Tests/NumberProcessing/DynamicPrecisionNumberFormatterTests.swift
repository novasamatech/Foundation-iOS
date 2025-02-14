import XCTest
import Foundation_iOS

class DynamicPrecisionNumberFormatterTests: XCTestCase {
    func testValidateFormatting() {
        let formatter = DynamicPrecisionFormatter(preferredPrecision: 4, roundingMode: .down)
        formatter.locale = Locale(identifier: "en")

        XCTAssertEqual(formatter.stringFromDecimal(0.1234), "0.1234")
        XCTAssertEqual(formatter.stringFromDecimal(0.12345), "0.1234")
        XCTAssertEqual(formatter.stringFromDecimal(0.123), "0.123")
        XCTAssertEqual(formatter.stringFromDecimal(0), "0")
        XCTAssertEqual(formatter.stringFromDecimal(1234.12345), "1234.1234")
        XCTAssertEqual(formatter.stringFromDecimal(1234.00001), "1234")
        XCTAssertEqual(formatter.stringFromDecimal(0.00001), "0.00001")
        XCTAssertEqual(formatter.stringFromDecimal(0.0000111), "0.00001")
        XCTAssertEqual(formatter.stringFromDecimal(0.0000000000213123), "0.00000000002")
    }
    
    func testValidateFormattingWithOffset() {
        let formatter = DynamicPrecisionFormatter(preferredPrecision: 4, preferredPrecisionOffset: 2, roundingMode: .down)
        formatter.locale = Locale(identifier: "en")

        XCTAssertEqual(formatter.stringFromDecimal(0.1234), "0.1234")
        XCTAssertEqual(formatter.stringFromDecimal(0.12345), "0.1234")
        XCTAssertEqual(formatter.stringFromDecimal(0.123), "0.123")
        XCTAssertEqual(formatter.stringFromDecimal(0), "0")
        XCTAssertEqual(formatter.stringFromDecimal(1234.12345), "1234.1234")
        XCTAssertEqual(formatter.stringFromDecimal(1234.00001), "1234")
        XCTAssertEqual(formatter.stringFromDecimal(0.00001), "0.00001")
        XCTAssertEqual(formatter.stringFromDecimal(0.0000111), "0.0000111")
        XCTAssertEqual(formatter.stringFromDecimal(0.0000000000213123), "0.0000000000213")
        XCTAssertEqual(formatter.stringFromDecimal(0.0012345), "0.00123")
        XCTAssertEqual(formatter.stringFromDecimal(0.012345), "0.0123")
        XCTAssertEqual(formatter.stringFromDecimal(0.1234567), "0.1234")
    }
    
    func testValidateFormattingWithZeroOffset() {
        let formatter = DynamicPrecisionFormatter(preferredPrecision: 4, preferredPrecisionOffset: 0, roundingMode: .down)
        formatter.locale = Locale(identifier: "en")

        XCTAssertEqual(formatter.stringFromDecimal(0.1234), "0.1234")
        XCTAssertEqual(formatter.stringFromDecimal(0.12345), "0.1234")
        XCTAssertEqual(formatter.stringFromDecimal(0.123), "0.123")
        XCTAssertEqual(formatter.stringFromDecimal(0), "0")
        XCTAssertEqual(formatter.stringFromDecimal(1234.12345), "1234.1234")
        XCTAssertEqual(formatter.stringFromDecimal(1234.00001), "1234")
        XCTAssertEqual(formatter.stringFromDecimal(0.00001), "0.00001")
        XCTAssertEqual(formatter.stringFromDecimal(0.0000111), "0.00001")
        XCTAssertEqual(formatter.stringFromDecimal(0.0000000000213123), "0.00000000002")
        XCTAssertEqual(formatter.stringFromDecimal(0.0012345), "0.0012")
        XCTAssertEqual(formatter.stringFromDecimal(0.012345), "0.0123")
        XCTAssertEqual(formatter.stringFromDecimal(0.1234567), "0.1234")
    }
}
