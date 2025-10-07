import Foundation

public class InMemoryCache<K: Hashable, V> {
    private var cache: [K: V] = [:]
    private let mutex = NSLock()
}

public extension InMemoryCache {
    func fetchValue(for key: K) -> V? {
        mutex.lock()

        defer {
            mutex.unlock()
        }

        return cache[key]
    }

    func store(value: V, for key: K) {
        mutex.lock()

        defer {
            mutex.unlock()
        }

        cache[key] = value
    }

    func clear(for key: K) {
        mutex.lock()

        defer {
            mutex.unlock()
        }

        cache[key] = nil
    }

    func allKeys() -> Set<K> {
        mutex.lock()

        defer {
            mutex.unlock()
        }

        return Set(cache.keys)
    }

    func allValues() -> [V] {
        mutex.lock()

        defer {
            mutex.unlock()
        }

        return Array(cache.values)
    }
}
