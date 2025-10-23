import Foundation

public extension Array where Element: Hashable {
    func distinct() -> [Element] {
        Array(Set(self))
    }
}
