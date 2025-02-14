import XCTest
import Foundation_iOS

class NameInputHandlingTests: XCTestCase {

    private struct Constants {
        static let personNameLimit = 30
        static let personNameSeparators = CharacterSet.whitespaces.union(CharacterSet(charactersIn: "-'"))
        static let personNameCharset = CharacterSet.letters.union(Constants.personNameSeparators)

        static var personNamePredicate: NSPredicate {
            let format = "\\p{L}([\\s'\\-]*\\p{L})*"
            return NSPredicate(format: "SELF MATCHES %@", format)
        }
    }

    func testAcceptedValues() {
        check(for: "D", changes: [], resultValue: "D", expectCompletion: true)
        check(for: "Dummy", changes: (0..<5).map({ _ in "Dummy" }), resultValue: "DummyDummyDummyDummyDummyDummy", expectCompletion: true)
        check(for: "Виталий", changes: [" ", "Деменьтьев"], resultValue: "Виталий Деменьтьев", expectCompletion: true)
        check(for: "Ваш", changes: ["'","ер","-Лаграв"], resultValue: "Ваш'ер-Лаграв", expectCompletion: true)
        check(for: "姓", changes: ["名"], resultValue: "姓名", expectCompletion: true)
        check(for: "Виталий", changes: ["-"," ", "Деменьтьев"], resultValue: "Виталий- Деменьтьев", expectCompletion: true)
    }

    func testHandlingInput() {
        check(for: "DummyDummyDummyDummyDummyDummy", changes: ["A", "B"], resultValue: "DummyDummyDummyDummyDummyDummy", expectCompletion: true)
        check(for: "Виталий", changes: [",", " ", "Деметьев"], resultValue: "Виталий Деметьев", expectCompletion: true)
        check(for: "Ваш", changes: ["`", "ер", "-", "Лаграв"], resultValue: "Вашер-Лаграв", expectCompletion: true)
        check(for: "Ваш", changes: ["'", "ер", "=","Лаграв"], resultValue: "Ваш'ерЛаграв", expectCompletion: true)
        check(for: "", changes: ["姓", "2", "名"], resultValue: "姓名", expectCompletion: true)
        check(for: "", changes: [" ", "-", "'"], resultValue: "", expectCompletion: false)
        check(for: "Robert", changes: [" ", "-", "'"], resultValue: "Robert -'", expectCompletion: false)
        check(for: "Robert", changes: [" ", "-", "'", "Brown"], resultValue: "Robert -'Brown", expectCompletion: true)
        check(for: "Robert", changes: [" "], resultValue: "Robert", expectCompletion: true)
        check(for: "Robert ", changes: [], resultValue: "Robert", expectCompletion: true)
        check(for: "Robert", changes: ["-"], resultValue: "Robert-", expectCompletion: false)
        check(for: "Robert", changes: ["'"], resultValue: "Robert'", expectCompletion: false)
    }

    // MARK: Private

    /**
     *  Executes check for view model which validates that input value:
     *  - not empty and contains no more than 30 characters;
     *  - contains only letters, whitespaces, hyphen or apostrophe;
     *  - begins only with a letter;
     *  - doesn't contain subsequent whitespaces, hyphens or apostrophe. Like 'Robin--Good';
     *  - doesn't end with hyphen or apostrophe. Like 'Robin-';
     *  - trims whitespaces;
     */

    func check(for initialValue: String, changes: [String], resultValue: String, expectCompletion: Bool) {
        let normalizer = TrimmingCharacterProcessor(charset: CharacterSet.whitespaces)
        let processor = CompoundTextProcessor(processors: [
            PrefixCharacterProcessor(charset: Constants.personNameSeparators),
            DuplicatingCharacterProcessor(charset: Constants.personNameSeparators)
        ])

        let viewModel = InputHandler(value: initialValue,
                                     maxLength: Constants.personNameLimit,
                                     validCharacterSet: Constants.personNameCharset,
                                     predicate: Constants.personNamePredicate,
                                     processor: processor,
                                     normalizer: normalizer)

        changes.forEach {
            let value = viewModel.value
            _ = viewModel.didReceiveReplacement($0, for: NSRange(location: value.unicodeScalars.count, length: 0))
        }

        XCTAssertEqual(viewModel.completed, expectCompletion, "initial: \(initialValue)\nchanges: \(changes)")

        XCTAssertEqual(viewModel.normalizedValue, resultValue)
    }
}
