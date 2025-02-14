import Cuckoo
@testable import Foundation_iOS

import UIKit






public class MockApplicationHandlerDelegate: ApplicationHandlerDelegate, Cuckoo.ProtocolMock {
    
    public typealias MocksType = ApplicationHandlerDelegate
    
    public typealias Stubbing = __StubbingProxy_ApplicationHandlerDelegate
    public typealias Verification = __VerificationProxy_ApplicationHandlerDelegate

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ApplicationHandlerDelegate?

    public func enableDefaultImplementation(_ stub: ApplicationHandlerDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
    public func didReceiveWillResignActive(notification: Notification)  {
        
    return cuckoo_manager.call(
    """
    didReceiveWillResignActive(notification: Notification)
    """,
            parameters: (notification),
            escapingParameters: (notification),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceiveWillResignActive!(notification: notification))
        
    }
    
    
    
    
    
    public func didReceiveDidBecomeActive(notification: Notification)  {
        
    return cuckoo_manager.call(
    """
    didReceiveDidBecomeActive(notification: Notification)
    """,
            parameters: (notification),
            escapingParameters: (notification),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceiveDidBecomeActive!(notification: notification))
        
    }
    
    
    
    
    
    public func didReceiveWillEnterForeground(notification: Notification)  {
        
    return cuckoo_manager.call(
    """
    didReceiveWillEnterForeground(notification: Notification)
    """,
            parameters: (notification),
            escapingParameters: (notification),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceiveWillEnterForeground!(notification: notification))
        
    }
    
    
    
    
    
    public func didReceiveDidEnterBackground(notification: Notification)  {
        
    return cuckoo_manager.call(
    """
    didReceiveDidEnterBackground(notification: Notification)
    """,
            parameters: (notification),
            escapingParameters: (notification),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceiveDidEnterBackground!(notification: notification))
        
    }
    
    

    public struct __StubbingProxy_ApplicationHandlerDelegate: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func didReceiveWillResignActive<M1: Cuckoo.Matchable>(notification: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Notification)> where M1.MatchedType == Notification {
            let matchers: [Cuckoo.ParameterMatcher<(Notification)>] = [wrap(matchable: notification) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockApplicationHandlerDelegate.self, method:
    """
    didReceiveWillResignActive(notification: Notification)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func didReceiveDidBecomeActive<M1: Cuckoo.Matchable>(notification: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Notification)> where M1.MatchedType == Notification {
            let matchers: [Cuckoo.ParameterMatcher<(Notification)>] = [wrap(matchable: notification) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockApplicationHandlerDelegate.self, method:
    """
    didReceiveDidBecomeActive(notification: Notification)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func didReceiveWillEnterForeground<M1: Cuckoo.Matchable>(notification: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Notification)> where M1.MatchedType == Notification {
            let matchers: [Cuckoo.ParameterMatcher<(Notification)>] = [wrap(matchable: notification) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockApplicationHandlerDelegate.self, method:
    """
    didReceiveWillEnterForeground(notification: Notification)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func didReceiveDidEnterBackground<M1: Cuckoo.Matchable>(notification: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Notification)> where M1.MatchedType == Notification {
            let matchers: [Cuckoo.ParameterMatcher<(Notification)>] = [wrap(matchable: notification) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockApplicationHandlerDelegate.self, method:
    """
    didReceiveDidEnterBackground(notification: Notification)
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_ApplicationHandlerDelegate: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func didReceiveWillResignActive<M1: Cuckoo.Matchable>(notification: M1) -> Cuckoo.__DoNotUse<(Notification), Void> where M1.MatchedType == Notification {
            let matchers: [Cuckoo.ParameterMatcher<(Notification)>] = [wrap(matchable: notification) { $0 }]
            return cuckoo_manager.verify(
    """
    didReceiveWillResignActive(notification: Notification)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func didReceiveDidBecomeActive<M1: Cuckoo.Matchable>(notification: M1) -> Cuckoo.__DoNotUse<(Notification), Void> where M1.MatchedType == Notification {
            let matchers: [Cuckoo.ParameterMatcher<(Notification)>] = [wrap(matchable: notification) { $0 }]
            return cuckoo_manager.verify(
    """
    didReceiveDidBecomeActive(notification: Notification)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func didReceiveWillEnterForeground<M1: Cuckoo.Matchable>(notification: M1) -> Cuckoo.__DoNotUse<(Notification), Void> where M1.MatchedType == Notification {
            let matchers: [Cuckoo.ParameterMatcher<(Notification)>] = [wrap(matchable: notification) { $0 }]
            return cuckoo_manager.verify(
    """
    didReceiveWillEnterForeground(notification: Notification)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func didReceiveDidEnterBackground<M1: Cuckoo.Matchable>(notification: M1) -> Cuckoo.__DoNotUse<(Notification), Void> where M1.MatchedType == Notification {
            let matchers: [Cuckoo.ParameterMatcher<(Notification)>] = [wrap(matchable: notification) { $0 }]
            return cuckoo_manager.verify(
    """
    didReceiveDidEnterBackground(notification: Notification)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class ApplicationHandlerDelegateStub: ApplicationHandlerDelegate {
    

    

    
    
    
    
    public func didReceiveWillResignActive(notification: Notification)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func didReceiveDidBecomeActive(notification: Notification)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func didReceiveWillEnterForeground(notification: Notification)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func didReceiveDidEnterBackground(notification: Notification)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}










public class MockApplicationHandlerProtocol: ApplicationHandlerProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = ApplicationHandlerProtocol
    
    public typealias Stubbing = __StubbingProxy_ApplicationHandlerProtocol
    public typealias Verification = __VerificationProxy_ApplicationHandlerProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ApplicationHandlerProtocol?

    public func enableDefaultImplementation(_ stub: ApplicationHandlerProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
    public var delegate: ApplicationHandlerDelegate? {
        get {
            return cuckoo_manager.getter("delegate",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.delegate)
        }
        
        set {
            cuckoo_manager.setter("delegate",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delegate = newValue)
        }
        
    }
    
    

    

    

    public struct __StubbingProxy_ApplicationHandlerProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var delegate: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockApplicationHandlerProtocol, ApplicationHandlerDelegate> {
            return .init(manager: cuckoo_manager, name: "delegate")
        }
        
        
        
    }

    public struct __VerificationProxy_ApplicationHandlerProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var delegate: Cuckoo.VerifyOptionalProperty<ApplicationHandlerDelegate> {
            return .init(manager: cuckoo_manager, name: "delegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
    }
}


public class ApplicationHandlerProtocolStub: ApplicationHandlerProtocol {
    
    
    
    
    public var delegate: ApplicationHandlerDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (ApplicationHandlerDelegate?).self)
        }
        
        set { }
        
    }
    
    

    

    
}





import Cuckoo
@testable import Foundation_iOS

import Foundation






public class MockCountdownTimerProtocol: CountdownTimerProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = CountdownTimerProtocol
    
    public typealias Stubbing = __StubbingProxy_CountdownTimerProtocol
    public typealias Verification = __VerificationProxy_CountdownTimerProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CountdownTimerProtocol?

    public func enableDefaultImplementation(_ stub: CountdownTimerProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
    public var delegate: CountdownTimerDelegate? {
        get {
            return cuckoo_manager.getter("delegate",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.delegate)
        }
        
        set {
            cuckoo_manager.setter("delegate",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delegate = newValue)
        }
        
    }
    
    
    
    
    
    public var state: CountdownTimerState {
        get {
            return cuckoo_manager.getter("state",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.state)
        }
        
    }
    
    
    
    
    
    public var notificationInterval: TimeInterval {
        get {
            return cuckoo_manager.getter("notificationInterval",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.notificationInterval)
        }
        
    }
    
    
    
    
    
    public var remainedInterval: TimeInterval {
        get {
            return cuckoo_manager.getter("remainedInterval",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.remainedInterval)
        }
        
    }
    
    

    

    
    
    
    
    public func start(with interval: TimeInterval, runLoop: RunLoop, mode: RunLoop.Mode)  {
        
    return cuckoo_manager.call(
    """
    start(with: TimeInterval, runLoop: RunLoop, mode: RunLoop.Mode)
    """,
            parameters: (interval, runLoop, mode),
            escapingParameters: (interval, runLoop, mode),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.start(with: interval, runLoop: runLoop, mode: mode))
        
    }
    
    
    
    
    
    public func stop()  {
        
    return cuckoo_manager.call(
    """
    stop()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.stop())
        
    }
    
    

    public struct __StubbingProxy_CountdownTimerProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var delegate: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockCountdownTimerProtocol, CountdownTimerDelegate> {
            return .init(manager: cuckoo_manager, name: "delegate")
        }
        
        
        
        
        var state: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCountdownTimerProtocol, CountdownTimerState> {
            return .init(manager: cuckoo_manager, name: "state")
        }
        
        
        
        
        var notificationInterval: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCountdownTimerProtocol, TimeInterval> {
            return .init(manager: cuckoo_manager, name: "notificationInterval")
        }
        
        
        
        
        var remainedInterval: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCountdownTimerProtocol, TimeInterval> {
            return .init(manager: cuckoo_manager, name: "remainedInterval")
        }
        
        
        
        
        
        func start<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(with interval: M1, runLoop: M2, mode: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(TimeInterval, RunLoop, RunLoop.Mode)> where M1.MatchedType == TimeInterval, M2.MatchedType == RunLoop, M3.MatchedType == RunLoop.Mode {
            let matchers: [Cuckoo.ParameterMatcher<(TimeInterval, RunLoop, RunLoop.Mode)>] = [wrap(matchable: interval) { $0.0 }, wrap(matchable: runLoop) { $0.1 }, wrap(matchable: mode) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCountdownTimerProtocol.self, method:
    """
    start(with: TimeInterval, runLoop: RunLoop, mode: RunLoop.Mode)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func stop() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCountdownTimerProtocol.self, method:
    """
    stop()
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_CountdownTimerProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var delegate: Cuckoo.VerifyOptionalProperty<CountdownTimerDelegate> {
            return .init(manager: cuckoo_manager, name: "delegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var state: Cuckoo.VerifyReadOnlyProperty<CountdownTimerState> {
            return .init(manager: cuckoo_manager, name: "state", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var notificationInterval: Cuckoo.VerifyReadOnlyProperty<TimeInterval> {
            return .init(manager: cuckoo_manager, name: "notificationInterval", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var remainedInterval: Cuckoo.VerifyReadOnlyProperty<TimeInterval> {
            return .init(manager: cuckoo_manager, name: "remainedInterval", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func start<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(with interval: M1, runLoop: M2, mode: M3) -> Cuckoo.__DoNotUse<(TimeInterval, RunLoop, RunLoop.Mode), Void> where M1.MatchedType == TimeInterval, M2.MatchedType == RunLoop, M3.MatchedType == RunLoop.Mode {
            let matchers: [Cuckoo.ParameterMatcher<(TimeInterval, RunLoop, RunLoop.Mode)>] = [wrap(matchable: interval) { $0.0 }, wrap(matchable: runLoop) { $0.1 }, wrap(matchable: mode) { $0.2 }]
            return cuckoo_manager.verify(
    """
    start(with: TimeInterval, runLoop: RunLoop, mode: RunLoop.Mode)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func stop() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    stop()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class CountdownTimerProtocolStub: CountdownTimerProtocol {
    
    
    
    
    public var delegate: CountdownTimerDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (CountdownTimerDelegate?).self)
        }
        
        set { }
        
    }
    
    
    
    
    
    public var state: CountdownTimerState {
        get {
            return DefaultValueRegistry.defaultValue(for: (CountdownTimerState).self)
        }
        
    }
    
    
    
    
    
    public var notificationInterval: TimeInterval {
        get {
            return DefaultValueRegistry.defaultValue(for: (TimeInterval).self)
        }
        
    }
    
    
    
    
    
    public var remainedInterval: TimeInterval {
        get {
            return DefaultValueRegistry.defaultValue(for: (TimeInterval).self)
        }
        
    }
    
    

    

    
    
    
    
    public func start(with interval: TimeInterval, runLoop: RunLoop, mode: RunLoop.Mode)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func stop()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}










public class MockCountdownTimerDelegate: CountdownTimerDelegate, Cuckoo.ProtocolMock {
    
    public typealias MocksType = CountdownTimerDelegate
    
    public typealias Stubbing = __StubbingProxy_CountdownTimerDelegate
    public typealias Verification = __VerificationProxy_CountdownTimerDelegate

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CountdownTimerDelegate?

    public func enableDefaultImplementation(_ stub: CountdownTimerDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
    public func didStart(with interval: TimeInterval)  {
        
    return cuckoo_manager.call(
    """
    didStart(with: TimeInterval)
    """,
            parameters: (interval),
            escapingParameters: (interval),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didStart(with: interval))
        
    }
    
    
    
    
    
    public func didCountdown(remainedInterval: TimeInterval)  {
        
    return cuckoo_manager.call(
    """
    didCountdown(remainedInterval: TimeInterval)
    """,
            parameters: (remainedInterval),
            escapingParameters: (remainedInterval),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didCountdown(remainedInterval: remainedInterval))
        
    }
    
    
    
    
    
    public func didStop(with remainedInterval: TimeInterval)  {
        
    return cuckoo_manager.call(
    """
    didStop(with: TimeInterval)
    """,
            parameters: (remainedInterval),
            escapingParameters: (remainedInterval),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didStop(with: remainedInterval))
        
    }
    
    

    public struct __StubbingProxy_CountdownTimerDelegate: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func didStart<M1: Cuckoo.Matchable>(with interval: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(TimeInterval)> where M1.MatchedType == TimeInterval {
            let matchers: [Cuckoo.ParameterMatcher<(TimeInterval)>] = [wrap(matchable: interval) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCountdownTimerDelegate.self, method:
    """
    didStart(with: TimeInterval)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func didCountdown<M1: Cuckoo.Matchable>(remainedInterval: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(TimeInterval)> where M1.MatchedType == TimeInterval {
            let matchers: [Cuckoo.ParameterMatcher<(TimeInterval)>] = [wrap(matchable: remainedInterval) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCountdownTimerDelegate.self, method:
    """
    didCountdown(remainedInterval: TimeInterval)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func didStop<M1: Cuckoo.Matchable>(with remainedInterval: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(TimeInterval)> where M1.MatchedType == TimeInterval {
            let matchers: [Cuckoo.ParameterMatcher<(TimeInterval)>] = [wrap(matchable: remainedInterval) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCountdownTimerDelegate.self, method:
    """
    didStop(with: TimeInterval)
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_CountdownTimerDelegate: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func didStart<M1: Cuckoo.Matchable>(with interval: M1) -> Cuckoo.__DoNotUse<(TimeInterval), Void> where M1.MatchedType == TimeInterval {
            let matchers: [Cuckoo.ParameterMatcher<(TimeInterval)>] = [wrap(matchable: interval) { $0 }]
            return cuckoo_manager.verify(
    """
    didStart(with: TimeInterval)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func didCountdown<M1: Cuckoo.Matchable>(remainedInterval: M1) -> Cuckoo.__DoNotUse<(TimeInterval), Void> where M1.MatchedType == TimeInterval {
            let matchers: [Cuckoo.ParameterMatcher<(TimeInterval)>] = [wrap(matchable: remainedInterval) { $0 }]
            return cuckoo_manager.verify(
    """
    didCountdown(remainedInterval: TimeInterval)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func didStop<M1: Cuckoo.Matchable>(with remainedInterval: M1) -> Cuckoo.__DoNotUse<(TimeInterval), Void> where M1.MatchedType == TimeInterval {
            let matchers: [Cuckoo.ParameterMatcher<(TimeInterval)>] = [wrap(matchable: remainedInterval) { $0 }]
            return cuckoo_manager.verify(
    """
    didStop(with: TimeInterval)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class CountdownTimerDelegateStub: CountdownTimerDelegate {
    

    

    
    
    
    
    public func didStart(with interval: TimeInterval)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func didCountdown(remainedInterval: TimeInterval)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
    public func didStop(with remainedInterval: TimeInterval)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}




