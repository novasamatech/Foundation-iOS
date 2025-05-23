import Foundation

public protocol WalletMigrationDestinationProtocol {
    func accept(with message: WalletMigrationMessage.Accepted) throws
}

public final class WalletMigrationDestination {
    public let originScheme: String
    let navigator: WalletMigrationLinkNavigating
    let queryFactory: WalletMigrationQueryFactoryProtocol

    public init(
        originScheme: String,
        queryFactory: WalletMigrationQueryFactoryProtocol,
        navigator: WalletMigrationLinkNavigating
    ) {
        self.originScheme = originScheme
        self.queryFactory = queryFactory
        self.navigator = navigator
    }
}

private extension WalletMigrationDestination {
    func createAcceptedDeepLink(from message: WalletMigrationMessage.Accepted) throws -> URL {
        var components = URLComponents()
        components.scheme = originScheme
        components.host = WalletMigrationDomain.origin.rawValue
        components.path = "/" + WalletMigrationAction.migrateAccepted.rawValue

        components.queryItems = [
            URLQueryItem(
                name: WalletMigrationQueryKey.key.rawValue,
                value: queryFactory.stringify(data: message.destinationPublicKey)
            )
        ]

        guard let url = components.url else {
            throw WalletMigrationChannelError.invalidParameters
        }

        return url
    }
}

extension WalletMigrationDestination: WalletMigrationDestinationProtocol {
    public func accept(with message: WalletMigrationMessage.Accepted) throws {
        let deepLink = try createAcceptedDeepLink(from: message)

        navigator.open(deepLink)
    }
}
