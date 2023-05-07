// MARK: - ExampleRequest

enum ExampleRequest {
  case fetchExampleData(_ page: Int)
}

// MARK: - RequestProtocol

extension ExampleRequest: RequestProtocol {
  var path: String {
    "YOUR_PATH"
  }
  
  var urlParams: [String: String?] {
    switch self {
    case let .fetchExampleData(page):
      return [
        "api_key": APIConstant.apiKey,
        "limit": String(page),
      ]
    }
  }
  
  var requestType: RequestType {
    .GET
  }
}
