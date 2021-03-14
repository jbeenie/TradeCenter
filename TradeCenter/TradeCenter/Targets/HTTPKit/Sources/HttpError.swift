import Foundation

enum HttpError: String, Error, CustomStringConvertible {
    case invalidRequest
    case invalidUrl
    case invalidResponse
    case responseDecoding

    var description: String {
        return rawValue
    }
}
