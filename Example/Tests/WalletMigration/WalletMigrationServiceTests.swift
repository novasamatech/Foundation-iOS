import XCTest
import Foundation_iOS

final class WalletMigrationServiceTests: XCTestCase {
    let originScheme = "polkadotapp"
    let destinationScheme = "novawallet"
    let universalLink = URL(string: "https://universal.app.link")!
    
    func testCanStorePendingMessageIfNoDelegate() throws {
        // given
        
        let navigator = MockWalletMigrationLinkNavigator()
        
        let originChannel = WalletMigrationOrigin(
            destinationAppLinkURL: universalLink,
            destinationScheme: destinationScheme,
            queryFactory: WalletMigrationDefaultQueryFactory(),
            navigator: navigator
        )
        
        let expectedMessageContent = WalletMigrationMessage.Start(originScheme: originScheme)
        
        let destService = WalletMigrationService(localDeepLinkScheme: destinationScheme)
        
        // when
        
        try originChannel.start(with: expectedMessageContent)
        
        guard let url = navigator.lastOpenedLink else {
            XCTFail("No message")
            return
        }
        
        
        XCTAssert(destService.handle(url: url))
        
        // then
        
        XCTAssertEqual(destService.consumePendingMessage(), .start(expectedMessageContent))
        
        XCTAssertNil(destService.consumePendingMessage())
    }
    
    func testCanNotifyDelegateWhenMessageArrives() throws {
        // given
        
        let navigator = MockWalletMigrationLinkNavigator()
        
        let originChannel = WalletMigrationOrigin(
            destinationAppLinkURL: universalLink,
            destinationScheme: destinationScheme,
            queryFactory: WalletMigrationDefaultQueryFactory(),
            navigator: navigator
        )
        
        let expectedMessageContent = WalletMigrationMessage.Start(originScheme: originScheme)
        
        let destService = WalletMigrationService(localDeepLinkScheme: destinationScheme)
        let delegate = MockWalletMigrationDelegate()
        destService.addObserver(delegate)
        
        // when
        
        try originChannel.start(with: expectedMessageContent)
        
        guard let url = navigator.lastOpenedLink else {
            XCTFail("No message")
            return
        }
        
        XCTAssert(destService.handle(url: url))
        
        // then
        
        XCTAssertEqual(delegate.lastMessage, .start(expectedMessageContent))
        
        XCTAssertNil(destService.consumePendingMessage())
    }
}
