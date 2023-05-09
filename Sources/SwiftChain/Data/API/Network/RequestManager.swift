// MARK: - RequestManagerProtocol

public protocol RequestManagerProtocol {
  func makeRequest<Element: Decodable>(from request: RequestProtocol) async throws -> Element
}

// MARK: - RequestManager

final class RequestManager {
  
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
  func makeRequest<Element: Decodable>(from request: RequestProtocol) async throws -> Element {
    let data = try await apiManager.makeRequest(from: request)
    let decoded: Element = try parser.parse(data: data)
    return decoded
  }
}
