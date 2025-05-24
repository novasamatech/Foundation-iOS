import Foundation

public protocol WalletMigrationLinkNavigating {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)
}

public final class WalletMigrationLinkNavigator {
    let application: UIApplication
    
    public init(application: UIApplication) {
        self.application = application
    }
}

extension WalletMigrationLinkNavigator: WalletMigrationLinkNavigating {
    public func canOpenURL(_ url: URL) -> Bool {
        application.canOpenURL(url)
    }
    
    public func open(_ url: URL) {
        application.open(url)
    }
}
