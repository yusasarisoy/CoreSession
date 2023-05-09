// MARK: - RequestManagerProtocol

public protocol RequestManagerProtocol {
  func makeRequest<Element: Decodable>(from request: RequestProtocol) async throws -> Element
}

// MARK: - RequestManager

public final class RequestManager {
  
  // MARK: - Singleton Instance
  
  public static let shared = RequestManager()
  
  // MARK: - Properties
  
  let apiManager: APIManagerProtocol
  let parser: DataParserProtocol

  // MARK: - Initialization
  
  init(
    apiManager: APIManagerProtocol = APIManager(),
    parser: DataParserProtocol = DataParser()
  ) {
    self.apiManager = apiManager
    self.parser = parser
  }
}

// MARK: - RequestManagerProtocol

extension RequestManager: RequestManagerProtocol {
  public func makeRequest<Element: Decodable>(from request: RequestProtocol) async throws -> Element {
    let data = try await apiManager.makeRequest(from: request)
    let decoded: Element = try parser.parse(data: data)
    return decoded
  }
}
