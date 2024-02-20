import XCTest
import Foundation_iOS

class TokenFormatterTests: XCTestCase {

    func testPriceSymbols() {
        let formatter = TokenFormatter(
            decimalFormatter: NumberFormatter.decimalFormatter(
                precision: 2,
                rounding: .down,
                usesIntGrouping: true
            ),
            tokenSymbol: "$",
            separator: "",
            position: .prefix
        )

        formatter.locale = Locale(identifier: "en_US")

        XCTAssertEqual(formatter.stringFromDecimal(0), "$0")
        XCTAssertEqual(formatter.stringFromDecimal(1_234), "$1,234")
        XCTAssertEqual(formatter.stringFromDecimal(0.232), "$0.23")
    }

}
