import Foundation

public struct NotEqualWrapper<V>: Equatable {
    public let value: V

    public init(value: V) {
        self.value = value
    }

    public static func == (_: NotEqualWrapper<V>, _: NotEqualWrapper<V>) -> Bool {
        false
    }
}
