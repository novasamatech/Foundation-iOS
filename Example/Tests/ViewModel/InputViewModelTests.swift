import XCTest
import Foundation_iOS

class InputViewModelTests: XCTestCase {

    func testInitialization() {
        let inputHandler = InputHandler()
        let title = "Some title"
        let placeholder = "Some placeholder"
        let autocapitalization = UITextAutocapitalizationType.words

        let inputViewModel = InputViewModel(inputHandler: inputHandler,
                                            title: title,
                                            placeholder: placeholder,
                                            autocapitalization: autocapitalization)

        XCTAssertEqual(inputViewModel.title, title)
        XCTAssertEqual(inputViewModel.placeholder, placeholder)
        XCTAssertEqual(inputViewModel.autocapitalization, autocapitalization)
    }
}
