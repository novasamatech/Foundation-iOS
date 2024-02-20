import Foundation

public extension NumberFormatter {
    func localizableResource() -> LocalizableResource<NumberFormatter> {
        return LocalizableResource { locale in
            self.locale = locale
            return self
        }
    }
}
