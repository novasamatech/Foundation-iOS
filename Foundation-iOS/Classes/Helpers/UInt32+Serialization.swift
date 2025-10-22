import Foundation

public extension UInt32 {
    var littleEndianBytes: [UInt8] {
        var value = littleEndian

        return withUnsafeBytes(of: &value, Array.init)
    }
}
