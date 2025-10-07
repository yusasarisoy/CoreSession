import Foundation

// MARK: - RequestManagerProtocol

public protocol RequestManagerProtocol {
  func makeRequest<Request: RequestProtocol>(_ request: Request) async throws -> Request.Response
}

// MARK: - RequestManager

public final class RequestManager {
  
  // MARK: - Properties
  
  private let urlSession: URLSession
  private let parser: DataParserProtocol

  // MARK: - Initialization
  
  public init(
    urlSession: URLSession = .shared,
    parser: DataParserProtocol = DataParser()
  ) {
    self.urlSession = urlSession
    self.parser = parser
  }
}

// MARK: - RequestManagerProtocol

extension RequestManager: RequestManagerProtocol {
  public func makeRequest<Request: RequestProtocol>(_ request: Request) async throws -> Request.Response {
    let (data, response) = try await urlSession.data(for: request.createURLRequest())
    guard let http = response as? HTTPURLResponse,
          (200...299).contains(http.statusCode) else {
      throw NetworkError.invalidServerResponse
    }
    
    do {
      return try parser.parse(Request.Response.self, from: data)
    } catch {
      throw NetworkError.dataParsingFailed
    }
  }
}
