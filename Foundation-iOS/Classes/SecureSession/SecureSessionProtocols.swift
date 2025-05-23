import Foundation

public enum SecureSession {
    public typealias PublicKey = Data
    public typealias Message = Data
    public typealias Cipher = Data
}

public protocol SecureSessionCrypting {
    func encrypt(_ message: SecureSession.Message) throws -> SecureSession.Cipher
    func decrypt(_ cipher: SecureSession.Cipher) throws -> SecureSession.Message
}

public protocol SecureSessionManaging {
    func startSession() throws -> SecureSession.PublicKey
    func deriveCryptor(peerPubKey: SecureSession.PublicKey) throws -> SecureSessionCrypting
}
