import Foundation

public protocol WalletMigrationLinkNavigating {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)
}
