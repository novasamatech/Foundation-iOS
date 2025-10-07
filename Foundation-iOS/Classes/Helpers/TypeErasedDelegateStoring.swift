import Foundation

// We let the delegate instance itself retain the type-erased wrapper (AnyMessageExchangeServiceDelegate).
// This ensures the wrapper stays alive even though the owner only keeps a weak reference.
// Since a single object can conform to multiple delegate protocols, each requiring its
// own type-erased wrapper, we store these wrappers as associated objects on the delegate.
// That way, the delegate can safely act in multiple roles without leaking or cycles.

public protocol TypeErasedDelegateStoring: AnyObject {
    func storeErasedType(instance: AnyObject)
}

private final class TypeErasureStore {
    private var items: [AnyObject] = []
    func add(_ obj: AnyObject) { items.append(obj) }
}

private nonisolated(unsafe) var retainingAnyKey: UInt8 = 0

private func getTypeErasureStore(on host: AnyObject) -> TypeErasureStore {
    if let bag = objc_getAssociatedObject(host, &retainingAnyKey) as? TypeErasureStore {
        return bag
    }
    let store = TypeErasureStore()
    objc_setAssociatedObject(host, &retainingAnyKey, store, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    return store
}

public extension TypeErasedDelegateStoring {
    func storeErasedType(instance: AnyObject) {
        let store = getTypeErasureStore(on: self)
        store.add(instance)
    }
}
