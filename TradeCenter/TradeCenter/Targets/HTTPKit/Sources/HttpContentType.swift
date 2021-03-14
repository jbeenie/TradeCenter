import Foundation

public enum HttpContentType: String {
    case json = "application/json"

    static let headerField = "Content-Type"
}
