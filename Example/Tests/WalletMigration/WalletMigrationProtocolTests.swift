import XCTest
import Foundation_iOS

final class WalletMigrationProtocolTests: XCTestCase {
    let originScheme = "polkadotapp"
    let destinationScheme = "novawallet"
    let universalLink = URL(string: "https://universal.app.link")!
    
    func testEndToEndWithDeepLinks() throws {
        // given
        
        let sharedNavigator = MockWalletMigrationLinkNavigator()
        
        let originSession = SecureSessionManager.createForWalletMigration()
        let originChannel = WalletMigrationOrigin(
            destinationAppLinkURL: universalLink,
            destinationScheme: destinationScheme,
            queryFactory: WalletMigrationDefaultQueryFactory(),
            navigator: sharedNavigator
        )
        
        let destinationSession = SecureSessionManager.createForWalletMigration()
        let destinationChannel = WalletMigrationDestination(
            originScheme: originScheme,
            queryFactory: WalletMigrationDefaultQueryFactory(),
            navigator: sharedNavigator
        )
        
        let originEntropy = Data(repeating: 7, count: 32)
        let walletName = "Migrate Me"
        
        let originMessageParser = WalletMigrationMessageParser(localDeepLinkScheme: originScheme)
        let destinationMessageParser = WalletMigrationMessageParser(localDeepLinkScheme: destinationScheme)
        
        // start
        
        let originKey = try originSession.startSession()
        
        let startMessageContent = WalletMigrationMessage.Start(originScheme: originScheme)
        try originChannel.start(with: startMessageContent)
        
        guard let startUrl = sharedNavigator.lastOpenedLink else {
            XCTFail("Missing start url")
            return
        }
        
        guard let startAction = destinationMessageParser.parseAction(from: startUrl) else {
            XCTFail("Unexpected start message for \(startUrl)")
            return
        }
        
        XCTAssertEqual(startAction, .migrate)
        
        let startMessage = try destinationMessageParser.parseMessage(for: startAction, from: startUrl)
        
        XCTAssertEqual(startMessage, .start(startMessageContent))
        
        // accept
        
        let destinationKey = try destinationSession.startSession()
        
        let acceptMessageContent = WalletMigrationMessage.Accepted(destinationPublicKey: destinationKey)
        try destinationChannel.accept(with: acceptMessageContent)
        
        guard let acceptUrl = sharedNavigator.lastOpenedLink else {
            XCTFail("Missing accept url")
            return
        }
        
        guard let acceptAction = originMessageParser.parseAction(from: acceptUrl) else {
            XCTFail("Unexpected accept message for \(acceptUrl)")
            return
        }
        
        XCTAssertEqual(acceptAction, .migrateAccepted)
        
        let acceptedMessage = try originMessageParser.parseMessage(for: acceptAction, from: acceptUrl)
        
        XCTAssertEqual(acceptedMessage, .accepted(acceptMessageContent))
        
        // complete
        
        let encryptor = try originSession.deriveCryptor(peerPubKey: destinationKey)
        let cipher = try encryptor.encrypt(originEntropy)
        
        let completeMessageContent = WalletMigrationMessage.Complete(
            originPublicKey: originKey,
            encryptedData: cipher,
            name: walletName
        )
        
        try originChannel.complete(with: completeMessageContent)
        
        guard let compleUrl = sharedNavigator.lastOpenedLink else {
            XCTFail("Missing complete url")
            return
        }
        
        guard let completeAction = destinationMessageParser.parseAction(from: compleUrl) else {
            XCTFail("Unexpected complete message for \(compleUrl)")
            return
        }
        
        XCTAssertEqual(completeAction, .migrateComplete)
        
        let completedMessage = try destinationMessageParser.parseMessage(for: completeAction, from: compleUrl)
        
        XCTAssertEqual(completedMessage, .complete(completeMessageContent))
        
        let decryptor = try destinationSession.deriveCryptor(peerPubKey: originKey)
        
        let decryptedEntropy = try decryptor.decrypt(cipher)
        
        XCTAssertEqual(decryptedEntropy, originEntropy)
    }
}
