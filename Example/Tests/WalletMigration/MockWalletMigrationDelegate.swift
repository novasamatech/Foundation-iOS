import Foundation
import Foundation_iOS

final class MockWalletMigrationDelegate {
    private(set) var lastMessage: WalletMigrationMessage?
}

extension MockWalletMigrationDelegate: WalletMigrationObserver {
    func didReceiveMigration(message: WalletMigrationMessage) {
        lastMessage = message
    }
}
