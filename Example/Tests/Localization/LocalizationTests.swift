import XCTest
import Foundation_iOS
import Keystore_iOS

class LocalizationTests: XCTestCase {
    func testObserverIsNotifiedWhenLocalizationChanges() {
        // given

        let localizationManager = LocalizationManager(localization: LocalizationConstants.russian)!

        XCTAssertEqual(localizationManager.selectedLocalization, LocalizationConstants.russian)

        // when

        let changeExpectation = XCTestExpectation()

        localizationManager.addObserver(with: self, queue: .main) { (old, new) in
            changeExpectation.fulfill()
        }

        localizationManager.selectedLocalization = LocalizationConstants.english

        // then

        wait(for: [changeExpectation], timeout: LocalizationConstants.defaultTimeout)

        XCTAssertEqual(localizationManager.selectedLocalization, LocalizationConstants.english)
    }

    func testObserverCanBeAddAndRemoved() {
        // given

        let localizationManager = LocalizationManager(localization: LocalizationConstants.russian)!

        // when

        localizationManager.addObserver(with: self, queue: .main) { (_, _) in }

        // then

        XCTAssertEqual(localizationManager.observers.count, 1)
        XCTAssertTrue(localizationManager.observers.first?.owner === self)

        // when

        localizationManager.removeObserver(by: self)

        // then

        XCTAssertTrue(localizationManager.observers.isEmpty)
    }

    func testLocalizationIsSavedToSettings() {
        // given

        let settings = InMemorySettingsManager()

        let localizationManager = LocalizationManager(settings: settings, key: LocalizationConstants.settingsKey)

        XCTAssertEqual(localizationManager.selectedLocalization,
                       settings.string(for: LocalizationConstants.settingsKey))

        // when

        localizationManager.selectedLocalization = LocalizationConstants.russian

        // then

        XCTAssertEqual(localizationManager.selectedLocalization, LocalizationConstants.russian)
        XCTAssertEqual(settings.string(for: LocalizationConstants.settingsKey), LocalizationConstants.russian)
    }

    func testLocalizationFetchedFromSettings() {
        // given

        let settings = InMemorySettingsManager()
        settings.set(value: LocalizationConstants.spanish, for: LocalizationConstants.settingsKey)

        // when

        let localizationManager = LocalizationManager(settings: settings,
                                                      key: LocalizationConstants.settingsKey,
                                                      preferredLanguages: [LocalizationConstants.russian],
                                                      availableLocalizations: [LocalizationConstants.russian])

        // then

        XCTAssertEqual(localizationManager.selectedLocalization,
                       settings.string(for: LocalizationConstants.settingsKey))
    }

    func testAvailableLocalizationAppliedWhenInitWithSelectedLocalization() {
        // given

        let localizations = [LocalizationConstants.spanish]

        // when

        let localizationManager = LocalizationManager(localization: LocalizationConstants.spanish,
                                                      availableLocalizations: localizations)!

        // then

        XCTAssertEqual(localizations, localizationManager.availableLocalizations)
    }

    func testAvailableLocalizationAppliedWhenInitWithSettings() {
        // given

        let settings = InMemorySettingsManager()
        let localizations = [LocalizationConstants.spanish]

        // when

        let localizationManager = LocalizationManager(settings: settings,
                                                      key: LocalizationConstants.spanish,
                                                      availableLocalizations: localizations)

        // then

        XCTAssertEqual(localizations, localizationManager.availableLocalizations)
    }

    func testDefaultLanguageIsUsedIfLocaleMatchingFailed() {
        // given

        let settings = InMemorySettingsManager()

        // when

        let localizationManager = LocalizationManager(settings: settings,
                                                      key: LocalizationConstants.settingsKey,
                                                      preferredLanguages: [LocalizationConstants.russian],
                                                      availableLocalizations: [LocalizationConstants.english],
                                                      defaultLocalization: LocalizationConstants.spanish)

        // then

        XCTAssertEqual(localizationManager.selectedLocalization, LocalizationConstants.spanish)
    }

    func testAvailableLocalizationIsFullyMatchesPreferred() {
        // given

        let settings = InMemorySettingsManager()

        let spanishUsComponents = [
            NSLocale.Key.languageCode.rawValue: LocalizationConstants.spanish,
            NSLocale.Key.countryCode.rawValue: LocalizationConstants.usRegion
        ]

        let spanishUs = Locale.identifier(fromComponents: spanishUsComponents)

        // when

        let localizationManager = LocalizationManager(settings: settings,
                                                      key: LocalizationConstants.settingsKey,
                                                      preferredLanguages: [LocalizationConstants.russian, spanishUs, LocalizationConstants.spanish],
                                                      availableLocalizations: [spanishUs],
                                                      defaultLocalization: LocalizationConstants.english)

        // then

        XCTAssertEqual(localizationManager.selectedLocalization, spanishUs)
    }

    func testAvailableLocalizationIsPartiallyMatchesPreferred() {
        // given

        let settings = InMemorySettingsManager()

        let spanishUsComponents = [
            NSLocale.Key.languageCode.rawValue: LocalizationConstants.spanish,
            NSLocale.Key.countryCode.rawValue: LocalizationConstants.usRegion
        ]

        let spanishUs = Locale.identifier(fromComponents: spanishUsComponents)

        // when

        let localizationManager = LocalizationManager(settings: settings,
                                                      key: LocalizationConstants.settingsKey,
                                                      preferredLanguages: [LocalizationConstants.russian, spanishUs, LocalizationConstants.english],
                                                      availableLocalizations: [LocalizationConstants.spanish],
                                                      defaultLocalization: LocalizationConstants.english)

        // then

        XCTAssertEqual(localizationManager.selectedLocalization, LocalizationConstants.spanish)
    }

    func testPreferredLocalizationIsPartiallyMatchesAvailable() {
        // given

        let settings = InMemorySettingsManager()

        let spanishUsComponents = [
            NSLocale.Key.languageCode.rawValue: LocalizationConstants.spanish,
            NSLocale.Key.countryCode.rawValue: LocalizationConstants.usRegion
        ]

        let spanishUs = Locale.identifier(fromComponents: spanishUsComponents)

        // when

        let localizationManager = LocalizationManager(settings: settings,
                                                      key: LocalizationConstants.settingsKey,
                                                      preferredLanguages: [LocalizationConstants.russian, LocalizationConstants.spanish, LocalizationConstants.english],
                                                      availableLocalizations: [spanishUs],
                                                      defaultLocalization: LocalizationConstants.english)

        // then

        XCTAssertEqual(localizationManager.selectedLocalization, spanishUs)
    }

    func testFirstMatchingPreferredLanguageMustBeSelected() {
        // given

        let settings = InMemorySettingsManager()

        // when

        let localizationManager = LocalizationManager(settings: settings,
                                                      key: LocalizationConstants.settingsKey,
                                                      preferredLanguages: [LocalizationConstants.russian, LocalizationConstants.english],
                                                      availableLocalizations: [LocalizationConstants.english, LocalizationConstants.russian],
                                                      defaultLocalization: LocalizationConstants.spanish)

        // then

        XCTAssertEqual(localizationManager.selectedLocalization, LocalizationConstants.russian)
    }
}
