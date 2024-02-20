import Foundation

public extension DateFormatter {
    func localizableResource() -> LocalizableResource<DateFormatter> {
        return LocalizableResource { locale in
            self.locale = locale
            return self
        }
    }
}
