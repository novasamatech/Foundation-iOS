import Foundation

public protocol WalletMigrationQueryFactoryProtocol {
    func stringify(data: Data) -> String
    func dataFrom(string: String) throws -> Data
}

public final class WalletMigrationDefaultQueryFactory {
    public init() {}
}

public enum WalletMigrationDefaultQueryFactoryError: Error {
    case invalidBase64Encoding
}

extension WalletMigrationDefaultQueryFactory: WalletMigrationQueryFactoryProtocol {
    public func stringify(data: Data) -> String {
        data.base64EncodedString()
    }
    
    public func dataFrom(string: String) throws -> Data {
        guard let data = Data(base64Encoded: string) else {
            throw WalletMigrationDefaultQueryFactoryError.invalidBase64Encoding
        }
        
        return data
    }
}
