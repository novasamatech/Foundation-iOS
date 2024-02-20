import Foundation

public struct LocalizableResource<R> {
    private let closure: (Locale) -> R

    public func value(for locale: Locale) -> R {
        return closure(locale)
    }

    public init(closure: @escaping (Locale) -> R) {
        self.closure = closure
    }
}
