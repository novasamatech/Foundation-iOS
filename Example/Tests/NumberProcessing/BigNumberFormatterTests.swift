import XCTest
import Foundation_iOS

class BigNumberFormatterTests: XCTestCase {
    let abbreviations: [BigNumberAbbreviation] = [
        .defaultInitial,
        .defaultThousands,
        .defaultMillions,
        .defaultBillions
    ]

    func testValidateFormatting() {
        let formatter = BigNumberFormatter(abbreviations: abbreviations)
        formatter.locale = Locale(identifier: "en")

        XCTAssertEqual(formatter.stringFromDecimal(Decimal(598)), "598")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(1000)), "1K")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(9940)), "9.9K")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(9980)), "10K")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(39900)), "39.9K")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(99880)), "99.9K")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(399880)), "0.4M")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(999898)), "1M")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(999999)), "1M")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(1456384)), "1.5M")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(12383474)), "12.4M")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(123_834_745)), "0.1B")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(166_834_745)), "0.2B")
        XCTAssertEqual(formatter.stringFromDecimal(Decimal(1_238_347_456)), "1.2B")
    }
}
