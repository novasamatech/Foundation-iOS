import XCTest
import Foundation_iOS

class LocalizableTests: XCTestCase {
    private class LocalizablePresenter: Localizable {
        private(set) var applyLocalizationCount = 0

        func applyLocalization() {
            applyLocalizationCount += 1
        }
    }

    func testDelegateIsCalledWhenLanguageChanges() {
        // given

        let localizationManager = LocalizationManager(localization: LocalizationConstants.russian)
        let presenter = LocalizablePresenter()

        // when

        presenter.localizationManager = localizationManager
        localizationManager?.selectedLocalization = LocalizationConstants.english

        // then

        XCTAssertEqual(presenter.applyLocalizationCount, 2)
    }
}
