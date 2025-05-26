import Foundation

public struct WalletMigrationKeypair {
    public typealias PublicKey = Data
    public typealias PrivateKey = Data

    public let publicKey: PublicKey
    public let privateKey: PrivateKey
    
    public init(publicKey: PublicKey, privateKey: PrivateKey) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
}

public enum WalletMigrationAction: String, Equatable {
    case migrate
    case migrateAccepted = "migrate-accepted"
    case migrateComplete = "migrate-complete"
}

enum WalletMigrationQueryKey: String {
    case action
    case key
    case encryptedData = "mnemonic"
    case scheme
    case name
}

enum WalletMigrationDomain: String {
    case origin = "polkadot"
    case destination = "nova"
}

enum WalletMigrationParams {
    static let allowedAppLinkSchemes: Set<String> = ["https", "http"]
}

public enum WalletMigrationMessage: Equatable {
    public struct Start: Equatable {
        public let originScheme: String
        
        public init(originScheme: String) {
            self.originScheme = originScheme
        }
    }

    public struct Accepted: Equatable {
        public let destinationPublicKey: WalletMigrationKeypair.PublicKey
        
        public init(destinationPublicKey: WalletMigrationKeypair.PublicKey) {
            self.destinationPublicKey = destinationPublicKey
        }
    }

    public struct Complete: Equatable {
        public let originPublicKey: WalletMigrationKeypair.PublicKey
        public let encryptedData: Data
        public let name: String?
        
        public init(originPublicKey: WalletMigrationKeypair.PublicKey, encryptedData: Data, name: String?) {
            self.originPublicKey = originPublicKey
            self.encryptedData = encryptedData
            self.name = name
        }
    }

    case start(Start)
    case accepted(Accepted)
    case complete(Complete)
}
