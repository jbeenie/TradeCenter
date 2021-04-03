import Foundation

/// An http session action handler that consolidates `URLSession` logic in a reusable mannor for different network api's
open class HttpActionHandler {

    public let baseUrl: URL

    // MARK: Init

    public init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }

    // MARK: Interface

    /// Used to run actions and log results
    ///
    /// - Parameters:
    ///   - action: The http action to process
    ///   - completionQueue: The dispatch queue to complete the action on
    ///   - completion: Handle the network result on the given completion queue
    public func run<T: HttpAction>(action: T,
                            completionQueue: DispatchQueue = .main,
                            completion: @escaping (T.ResultType) -> Void) {
        process(action: action, completionQueue: completionQueue) { [weak self] result, response in
            self?.log(result: result, response: response, for: action)
            completion(result)
        }
    }

    // MARK: Helpers

    /// Processes the given action and allows the action to decode a response from the data
    private func process<T: HttpAction>(action: T,
                                        completionQueue: DispatchQueue,
                                        completion: @escaping (T.ResultType, HTTPURLResponse?) -> Void) {
        let request: URLRequest

        do {
            request = try urlRequest(for: action)
        } catch let error {
            completion(.failure(error), nil)
            return
        }

        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            completionQueue.async {
                let httpURLResponse = urlResponse as? HTTPURLResponse

                guard let data = data else {
                    completion(.failure(HttpError.invalidResponse), httpURLResponse)
                    return
                }

                if let response = action.response(from: data) {
                    completion(.success(response), httpURLResponse)
                } else if let error = action.error(from: data) {
                    completion(.failure(error), httpURLResponse)
                } else {
                    completion(.failure(HttpError.responseDecoding), httpURLResponse)
                }
            }
        }.resume()
    }

    /// Creates a url request object for the given action
    private func urlRequest<T: HttpAction>(for action: T) throws -> URLRequest {
        var builder = URLComponents()
        builder.path = action.path
        builder.queryItems = action.queryItems

        guard let url = builder.url(relativeTo: baseUrl) else {
            throw HttpError.invalidUrl
        }

        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringCacheData,
                                 timeoutInterval: action.timeout)
        for (key, value) in action.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.setValue(action.contentType.rawValue, forHTTPHeaderField: HttpContentType.headerField)
        request.httpMethod = action.method.rawValue
        request.httpBody = action.body
        return request
    }

    private func log<T: HttpAction>(result: T.ResultType,
                                    response: HTTPURLResponse?,
                                    for action: T) {
        guard let response = response,
            let url = response.url else {
            print("Error: No URL response received.")
            return
        }

        let statusCode = response.statusCode

        switch result {
        case .success:
            print("HTTP Success: (\(url), Status Code: \(statusCode)")
        case .failure(let error):
            print("HTTP Error: (\(url), Error: \(error.localizedDescription), Status Code: \(statusCode)")
        }
    }
}
