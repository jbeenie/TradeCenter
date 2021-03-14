import Foundation

public protocol HttpAction {

    associatedtype Response
    typealias ResultType = Result<Response, Error>

    var path: String { get }
    var method: HttpMethod { get }
    var headers: [HttpHeader] { get }
    var contentType: HttpContentType { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    var timeout: TimeInterval { get }

    /// Allows actions to define their own decoding logic if necessary
    func response(from data: Data) -> Response?

    /// Allows actions to define their own error decoding logic if necessary
    func error(from data: Data) -> Error?
}

extension HttpAction where Self.Response: Decodable {

    func response(from data: Data) -> Response? {
        switch contentType {
        case .json:
            return try? JSONDecoder().decode(Response.self, from: data)
        }
    }

    func error(from data: Data) -> Error? {
        return nil
    }
}

extension HttpAction {

    var headers: [HttpHeader] {
        return []
    }

    var contentType: HttpContentType {
        return .json
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var body: Data? {
        return nil
    }

    var timeout: TimeInterval {
        return 10
    }
}
