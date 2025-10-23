import Foundation

public extension Optional {
    func hasError<TData, TError: Error>() -> Bool where Wrapped == Result<TData, TError> {
        switch self {
        case .success,
             .none:
            false
        case .failure:
            true
        }
    }

    func mapOrThrow(_ error: Error) throws -> Wrapped {
        guard let value = self else {
            throw error
        }

        return value
    }
}
