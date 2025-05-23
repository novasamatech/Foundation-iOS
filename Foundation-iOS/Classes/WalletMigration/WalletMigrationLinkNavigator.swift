import UIKit

public protocol WalletMigrationLinkNavigating {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)
}

public final class WalletMigrationLinkNavigator {
    public init() {}
}

extension WalletMigrationLinkNavigator: WalletMigrationLinkNavigating {
    public func canOpenURL(_ url: URL) -> Bool {
        UIApplication.shared.canOpenURL(url)
    }

    public func open(_ url: URL) {
        UIApplication.shared.open(url)
    }
}
