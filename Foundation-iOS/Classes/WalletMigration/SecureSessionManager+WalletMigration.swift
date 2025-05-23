import Foundation

public extension SecureSessionManager {
    static let encryptionSalt = "ephemeral-salt".data(using: .utf8)!
    static let encryptionAuth = Data([1])

    static func createForWalletMigration() -> SecureSessionManager {
        SecureSessionManager(
            auth: encryptionAuth,
            salt: encryptionSalt
        )
    }
}
