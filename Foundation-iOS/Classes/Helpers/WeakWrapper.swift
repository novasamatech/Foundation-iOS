import Foundation

public final class WeakWrapper {
    public weak var target: AnyObject?

    public init(target: AnyObject) {
        self.target = target
    }
}

public extension [WeakWrapper] {
    mutating func clearEmptyItems() {
        self = filter { $0.target != nil }
    }
}
