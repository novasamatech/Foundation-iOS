import Foundation

public enum UncertainStorage<T> {
    case undefined
    case defined(T)

    public var isDefined: Bool {
        switch self {
        case .defined:
            true
        case .undefined:
            false
        }
    }

    public var value: T? {
        switch self {
        case let .defined(value):
            value
        case .undefined:
            nil
        }
    }

    public func map<V>(_ closure: (T) -> V) -> UncertainStorage<V> {
        switch self {
        case let .defined(value):
            let newValue = closure(value)
            return .defined(newValue)
        case .undefined:
            return .undefined
        }
    }

    public func valueWhenDefined(else defaultValue: T) -> T {
        switch self {
        case let .defined(value):
            value
        case .undefined:
            defaultValue
        }
    }

    public func valueWhenDefinedElseThrow(_ message: String) throws -> T {
        switch self {
        case let .defined(value):
            return value
        case .undefined:
            throw UncertainStorageError.undefined(message)
        }
    }
}

public enum UncertainStorageError: Error {
    case undefined(String)
}

extension UncertainStorage: Equatable where T: Equatable {}
