import XCTest
import Foundation_iOS

class CompoundNumberProcessingTests: XCTestCase {
    let compoundNumberFormatter: LocalizableDecimalFormatting = {
        let abbreviations: [BigNumberAbbreviation] = [
            BigNumberAbbreviation(
                threshold: 0,
                divisor: 1.0,
                suffix: "",
                formatter: DynamicPrecisionFormatter(preferredPrecision: 5, roundingMode: .down)
            ),
            BigNumberAbbreviation(
                threshold: 1,
                divisor: 1.0,
                suffix: "",
                formatter: NumberFormatter.decimalFormatter(
                    precision: 5,
                    rounding: .down,
                    usesIntGrouping: true
                )
            ),
            BigNumberAbbreviation(
                threshold: 1_000,
                divisor: 1.0,
                suffix: "",
                formatter: NumberFormatter.decimalFormatter(
                    precision: 2,
                    rounding: .down,
                    usesIntGrouping: true
                )
            ),
            BigNumberAbbreviation(
                threshold: 1_000_000,
                divisor: 1_000_000.0,
                suffix: "M",
                formatter: nil
            ),
            BigNumberAbbreviation(
                threshold: 1_000_000_000,
                divisor: 1_000_000_000.0,
                suffix: "B",
                formatter: nil
            ),
            BigNumberAbbreviation(
                threshold: 1_000_000_000_000,
                divisor: 1_000_000_000_000.0,
                suffix: "T",
                formatter: nil
            )
        ]

        return BigNumberFormatter(
            abbreviations: abbreviations,
            precision: 2,
            rounding: .down,
            usesIntGrouping: true
        )
    }()

    func testFearlessUsecase() {
        compoundNumberFormatter.locale = Locale(identifier: "en_US")

        XCTAssertEqual(compoundNumberFormatter.stringFromDecimal(0.000000011676979), "0.00000001")
        XCTAssertEqual(compoundNumberFormatter.stringFromDecimal(0.000021676979), "0.00002")
        XCTAssertEqual(compoundNumberFormatter.stringFromDecimal(0.315000041811), "0.315")
        XCTAssertEqual(compoundNumberFormatter.stringFromDecimal(0.99999999999), "0.99999")
        XCTAssertEqual(compoundNumberFormatter.stringFromDecimal(999.99999999), "999.99999")
        XCTAssertEqual(compoundNumberFormatter.stringFromDecimal(888_888.1234), "888,888.12")
        XCTAssertEqual(compoundNumberFormatter.stringFromDecimal(1_243_000), "1.24M")
        XCTAssertEqual(compoundNumberFormatter.stringFromDecimal(1_243_011), "1.24M")
        XCTAssertEqual(compoundNumberFormatter.stringFromDecimal(100_041_000_000), "100.04B")
        XCTAssertEqual(compoundNumberFormatter.stringFromDecimal(1_001_000_000_000), "1T")
        XCTAssertEqual(compoundNumberFormatter.stringFromDecimal(1_001_000_000_000_000), "1,001T")
    }

    func testFearlessUsecaseWithTokenFormatter() {
        let tokenFormatter = TokenFormatter(
            decimalFormatter: compoundNumberFormatter,
            tokenSymbol: "KSM",
            separator: " ",
            position: .suffix
        )

        tokenFormatter.locale = Locale(identifier: "en_US")

        XCTAssertEqual(tokenFormatter.stringFromDecimal(0.000000011676979), "0.00000001 KSM")
        XCTAssertEqual(tokenFormatter.stringFromDecimal(0.000021676979), "0.00002 KSM")
        XCTAssertEqual(tokenFormatter.stringFromDecimal(0.315000041811), "0.315 KSM")
        XCTAssertEqual(tokenFormatter.stringFromDecimal(0.99999999999), "0.99999 KSM")
        XCTAssertEqual(tokenFormatter.stringFromDecimal(999.99999999), "999.99999 KSM")
        XCTAssertEqual(tokenFormatter.stringFromDecimal(888_888.1234), "888,888.12 KSM")
        XCTAssertEqual(tokenFormatter.stringFromDecimal(1_243_000), "1.24M KSM")
        XCTAssertEqual(tokenFormatter.stringFromDecimal(1_243_011), "1.24M KSM")
        XCTAssertEqual(tokenFormatter.stringFromDecimal(100_041_000_000), "100.04B KSM")
        XCTAssertEqual(tokenFormatter.stringFromDecimal(1_001_000_000_000), "1T KSM")
        XCTAssertEqual(tokenFormatter.stringFromDecimal(1_001_000_000_000_000), "1,001T KSM")
    }
}
