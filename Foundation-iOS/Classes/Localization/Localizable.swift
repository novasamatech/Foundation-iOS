import Foundation

public protocol Localizable: AnyObject {
    var localizationManager: LocalizationManagerProtocol? { get set }

    func applyLocalization()
}

private struct LocalizableConstants {
    static var localizationManagerKey = "io.novasama.localizable.manager"
}

public extension Localizable {
    var localizationManager: LocalizationManagerProtocol? {
        set {

            let currentManager = localizationManager

            guard newValue !== currentManager else {
                return
            }

            currentManager?.removeObserver(by: self)

            newValue?.addObserver(with: self) { [weak self] (_, _) in
                self?.applyLocalization()
            }

            withUnsafePointer(to: &LocalizableConstants.localizationManagerKey) {
                objc_setAssociatedObject(
                    self,
                    $0,
                    newValue,
                    .OBJC_ASSOCIATION_RETAIN
                )
            }

            applyLocalization()
        }

        get {
            withUnsafePointer(to: &LocalizableConstants.localizationManagerKey) {
                return objc_getAssociatedObject(
                    self, $0
                ) as? LocalizationManagerProtocol
            }
        }
    }
}
