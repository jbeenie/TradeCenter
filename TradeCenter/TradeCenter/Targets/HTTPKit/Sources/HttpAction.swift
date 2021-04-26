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
    func result(from data: Data) -> ResultType
}

public extension HttpAction where Self.Response: Decodable {

    func result(from data: Data) -> ResultType {
        switch contentType {
        case .json:
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                return .success(response)
            } catch let error {
                return .failure(error)
            }
        }
    }
}

public extension HttpAction {

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
