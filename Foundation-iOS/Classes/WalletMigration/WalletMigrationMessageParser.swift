import Foundation

public enum WalletMigrationMessageParsingError: Error {
    case invalidURL(URL)
    case expectedQueryParam(String)
    case schemeMismatch(String?)
}

public protocol WalletMigrationMessageParsing {
    func parseAction(from url: URL) -> WalletMigrationAction?
    func parseMessage(for action: WalletMigrationAction, from url: URL) throws -> WalletMigrationMessage
}

public final class WalletMigrationMessageParser {
    let localDeepLinkScheme: String
    let queryFactory: WalletMigrationQueryFactoryProtocol
    
    public init(
        localDeepLinkScheme: String,
        queryFactory: WalletMigrationQueryFactoryProtocol = WalletMigrationDefaultQueryFactory()
    ) {
        self.localDeepLinkScheme = localDeepLinkScheme
        self.queryFactory = queryFactory
    }
}

private extension WalletMigrationMessageParser {
    func parseQueryItems(from url: URL) throws -> [URLQueryItem] {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems,
            !queryItems.isEmpty else {
            throw WalletMigrationMessageParsingError.invalidURL(url)
        }

        return queryItems
    }

    func parseQueryItem<T>(
        by queryKey: WalletMigrationQueryKey,
        from items: [URLQueryItem],
        using mappingClosure: (String) throws -> T
    ) throws -> T {
        guard
            let item = items.first(where: { $0.name == queryKey.rawValue }),
            let value = item.value else {
            throw WalletMigrationMessageParsingError.expectedQueryParam(queryKey.rawValue)
        }

        return try mappingClosure(value)
    }

    func parseQueryItemString(
        by queryKey: WalletMigrationQueryKey,
        from items: [URLQueryItem]
    ) throws -> String {
        try parseQueryItem(by: queryKey, from: items, using: { $0 })
    }

    func parseStartDeepLinkMessage(from url: URL) throws -> WalletMigrationMessage {
        let queryItems = try parseQueryItems(from: url)

        let scheme = try parseQueryItemString(by: .scheme, from: queryItems)

        return .start(.init(originScheme: scheme))
    }

    func parseStartAppLinkMessage(from url: URL) throws -> WalletMigrationMessage {
        let queryItems = try parseQueryItems(from: url)

        let scheme = try parseQueryItemString(by: .scheme, from: queryItems)

        return .start(.init(originScheme: scheme))
    }

    func parseStartMessage(from url: URL) throws -> WalletMigrationMessage {
        if url.scheme == localDeepLinkScheme {
            return try parseStartDeepLinkMessage(from: url)
        } else if
            let scheme = url.scheme,
            WalletMigrationParams.allowedAppLinkSchemes.contains(scheme) {
            return try parseStartAppLinkMessage(from: url)
        } else {
            throw WalletMigrationMessageParsingError.schemeMismatch(url.scheme)
        }
    }

    func parseAcceptMessage(from url: URL) throws -> WalletMigrationMessage {
        guard url.scheme == localDeepLinkScheme else {
            throw WalletMigrationMessageParsingError.schemeMismatch(url.scheme)
        }

        let queryItems = try parseQueryItems(from: url)

        let pubKey: WalletMigrationKeypair.PublicKey = try parseQueryItem(
            by: .key,
            from: queryItems
        ) { value in
            try queryFactory.dataFrom(string: value)
        }

        return .accepted(.init(destinationPublicKey: pubKey))
    }

    func parseCompleteMessage(from url: URL) throws -> WalletMigrationMessage {
        guard url.scheme == localDeepLinkScheme else {
            throw WalletMigrationMessageParsingError.schemeMismatch(url.scheme)
        }

        let queryItems = try parseQueryItems(from: url)

        let pubKey: WalletMigrationKeypair.PublicKey = try parseQueryItem(
            by: .key,
            from: queryItems
        ) { value in
            try queryFactory.dataFrom(string: value)
        }

        let encryptedData: Data = try parseQueryItem(
            by: .encryptedData,
            from: queryItems
        ) { value in
            try queryFactory.dataFrom(string: value)
        }

        let name = try? parseQueryItemString(by: .name, from: queryItems)

        let complete = WalletMigrationMessage.Complete(
            originPublicKey: pubKey,
            encryptedData: encryptedData,
            name: name
        )

        return WalletMigrationMessage.complete(complete)
    }

    func extractRawActionFromAppLink(url: URL) -> String? {
        do {
            let queryItems = try parseQueryItems(from: url)

            return try parseQueryItemString(by: .action, from: queryItems)
        } catch {
            return nil
        }
    }

    func extractRawActionFromDeepLink(url: URL) -> String? {
        url.path(percentEncoded: false).trimmingCharacters(in: CharacterSet(charactersIn: "/"))
    }

    func extractRawAction(from url: URL) -> String? {
        if url.scheme == localDeepLinkScheme {
            return extractRawActionFromDeepLink(url: url)
        } else if
            let scheme = url.scheme,
            WalletMigrationParams.allowedAppLinkSchemes.contains(scheme) {
            return extractRawActionFromAppLink(url: url)
        } else {
            return nil
        }
    }
}

extension WalletMigrationMessageParser: WalletMigrationMessageParsing {
    public func parseAction(from url: URL) -> WalletMigrationAction? {
        guard let rawValue = extractRawAction(from: url) else {
            return nil
        }

        return WalletMigrationAction(rawValue: rawValue)
    }

    public func parseMessage(for action: WalletMigrationAction, from url: URL) throws -> WalletMigrationMessage {
        switch action {
        case .migrate:
            try parseStartMessage(from: url)
        case .migrateAccepted:
            try parseAcceptMessage(from: url)
        case .migrateComplete:
            try parseCompleteMessage(from: url)
        }
    }
}
