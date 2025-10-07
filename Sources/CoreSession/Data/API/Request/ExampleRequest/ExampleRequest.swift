// MARK: - ExampleRequest

enum ExampleRequest {
  case fetchExampleData(_ page: Int)
}

// MARK: - ExampleData

struct ExampleData: Decodable {
    let id: Int
    let name: String
}

// MARK: - RequestProtocol

extension ExampleRequest: RequestProtocol {
  typealias Response = ExampleData
  
  var path: String {
    "YOUR_PATH"
  }
  
  var urlParams: [String: String?] {
    switch self {
    case let .fetchExampleData(page):
      let params: [String: String?] = [
        "limit": String(page)
      ]
      return params
    }
  }
  
  var requestType: RequestType {
    .GET
  }
}
