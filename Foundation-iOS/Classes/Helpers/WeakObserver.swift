import Foundation

public final class WeakObserver {
    public weak var target: AnyObject?
    public let notificationQueue: DispatchQueue
    public let closure: () -> Void

    public init(target: AnyObject, notificationQueue: DispatchQueue, closure: @escaping () -> Void) {
        self.target = target
        self.notificationQueue = notificationQueue
        self.closure = closure
    }
}

public extension [WeakObserver] {
    mutating func clearEmptyItems() {
        self = filter { $0.target != nil }
    }
}
