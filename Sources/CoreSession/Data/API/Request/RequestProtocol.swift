import Foundation

// MARK: - RequestProtocol

public protocol RequestProtocol {
  associatedtype Response: Decodable
  var path: String { get }
  var requestType: RequestType { get }
  var urlParams: [String: String?] { get }
}

extension RequestProtocol {
  public nonisolated var urlParams: [String: String?] {
    [:]
  }
  
  public nonisolated func createURLRequest() async throws -> URLRequest {
    let url = await CoreSession.shared.makeURL(path, query: urlParams)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestType.rawValue
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return urlRequest
  }
}
