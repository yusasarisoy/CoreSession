import Foundation

protocol RequestProtocol {
  var path: String { get }
  var requestType: RequestType { get }
  var params: [String: Any] { get }
  var urlParams: [String: String?] { get }
}

// MARK: - RequestProtocol

extension RequestProtocol {
  private var host: String {
    APIConstant.domain
  }

  var params: [String: Any] {
    [:]
  }

  var urlParams: [String: String?] {
    [:]
  }

  func createURLRequest() throws -> URLRequest {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = host
    urlComponents.path = path

    if !urlParams.isEmpty {
      urlComponents.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
    }

    guard let url = urlComponents.url else { throw NetworkError.invalidURL }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestType.rawValue

    urlRequest.setValue(
      "application/json",
      forHTTPHeaderField: "Content-Type"
    )

    if !params.isEmpty {
      urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
    }

    return urlRequest
  }
}
