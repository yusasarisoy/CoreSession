import Foundation

// MARK: - RequestProtocol

public protocol RequestProtocol {
  associatedtype Response: Decodable

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

  public nonisolated var urlParams: [String: String?] {
    [:]
  }

  public nonisolated func createURLRequest() throws -> URLRequest {
    let url = CoreSession.shared.makeURL(path, query: urlParams)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestType.rawValue
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return urlRequest
  }
}
