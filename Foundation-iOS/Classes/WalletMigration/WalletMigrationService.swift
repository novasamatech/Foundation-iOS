import Foundation

public protocol WalletMigrationObserver: AnyObject {
    func didReceiveMigration(message: WalletMigrationMessage)
}

public protocol WalletMigrationServiceProtocol {
    func addObserver(_ observer: WalletMigrationObserver)
    func removeObserver(_ observer: WalletMigrationObserver)

    func consumePendingMessage() -> WalletMigrationMessage?
    
    func handle(url: URL) -> Bool
}

public final class WalletMigrationService {
    private var observers: [WeakWrapper] = []

    private var pendingMessage: WalletMigrationMessage?

    private let parser: WalletMigrationMessageParser

    public init(localDeepLinkScheme: String) {
        parser = WalletMigrationMessageParser(localDeepLinkScheme: localDeepLinkScheme)
    }
}

private extension WalletMigrationService {
    func markPendingMessageConsumed() {
        pendingMessage = nil
    }

    func handle(message: WalletMigrationMessage) {
        observers.clearEmptyItems()

        if !observers.isEmpty {
            markPendingMessageConsumed()

            observers.forEach { ($0.target as? WalletMigrationObserver)?.didReceiveMigration(message: message) }
        } else {
            pendingMessage = message
        }
    }
}

extension WalletMigrationService: WalletMigrationServiceProtocol {
    public func handle(url: URL) -> Bool {
        guard
            let action = parser.parseAction(from: url) else {
            return false
        }

        if let message = try? parser.parseMessage(for: action, from: url) {
            handle(message: message)
        }

        return true
    }

    public func addObserver(_ observer: WalletMigrationObserver) {
        observers.clearEmptyItems()

        if !observers.contains(where: { $0.target === observer }) {
            observers.append(.init(target: observer))
        }
    }

    public func removeObserver(_ observer: WalletMigrationObserver) {
        observers.clearEmptyItems()

        observers = observers.filter { $0.target !== observer }
    }

    public func consumePendingMessage() -> WalletMigrationMessage? {
        let message = pendingMessage

        markPendingMessageConsumed()

        return message
    }
}

final class WeakWrapper {
    weak var target: AnyObject?

    init(target: AnyObject) {
        self.target = target
    }
}

extension Array where Element == WeakWrapper {
    mutating func clearEmptyItems() {
        self = filter { $0.target != nil }
    }
}
