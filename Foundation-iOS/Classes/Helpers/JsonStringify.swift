import Foundation

public enum JsonStringifyError: Error {
    case invalidModelData
    case invalidJsonString
}

public enum JsonStringify {
    public static func jsonString(from model: some Encodable) throws -> String {
        let encoder = JSONEncoder()

        let data = try encoder.encode(model)

        guard let string = String(data: data, encoding: .utf8) else {
            throw JsonStringifyError.invalidModelData
        }

        return string
    }

    public static func decodeFromString<T: Decodable>(_ jsonString: String) throws -> T {
        let decoder = JSONDecoder()

        guard let data = jsonString.data(using: .utf8) else {
            throw JsonStringifyError.invalidJsonString
        }

        return try decoder.decode(T.self, from: data)
    }
}
