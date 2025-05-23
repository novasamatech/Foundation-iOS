import Foundation
import CryptoKit

public enum SecureSessionAesCryptorError: Error {
    case cipherGenerationFailed
    case randomizerFailed
}

public final class SecureSessionAesCryptor {
    public let key: SymmetricKey
    public let nonceSize: Int

    public init(key: SymmetricKey, nonceSize: Int = 12) {
        self.key = key
        self.nonceSize = nonceSize
    }
}

extension SecureSessionAesCryptor: SecureSessionCrypting {
    public func encrypt(_ message: SecureSession.Message) throws -> SecureSession.Cipher {
        var nonceBytes = [UInt8](repeating: 0, count: nonceSize)
        let status = SecRandomCopyBytes(kSecRandomDefault, nonceSize, &nonceBytes)
        
        guard status == errSecSuccess else {
            throw SecureSessionAesCryptorError.randomizerFailed
        }

        let nonce = try AES.GCM.Nonce(data: Data(nonceBytes))
        let sealedBox = try AES.GCM.seal(message, using: key, nonce: nonce)

        guard let combinedData = sealedBox.combined else {
            throw SecureSessionAesCryptorError.cipherGenerationFailed
        }

        return combinedData
    }

    public func decrypt(_ cipher: SecureSession.Cipher) throws -> SecureSession.Message {
        let receivedSealedBox = try AES.GCM.SealedBox(combined: cipher)

        return try AES.GCM.open(receivedSealedBox, using: key)
    }
}
