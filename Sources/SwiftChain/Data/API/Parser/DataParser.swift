import Foundation

// MARK: - DataParserProtocol

protocol DataParserProtocol {
  func parse<Element: Decodable>(data: Data) throws -> Element
}

// MARK: - DataParser

final class DataParser {
  
  // MARK: - Properties

  private var jsonDecoder: JSONDecoder

  // MARK: - Initialization
  
  init(jsonDecoder: JSONDecoder = JSONDecoder()) {
    self.jsonDecoder = jsonDecoder
  }
}

// MARK: - DataParserProtocol

extension DataParser: DataParserProtocol {
  func parse<Element: Decodable>(data: Data) throws -> Element {
    try jsonDecoder.decode(
      Element.self,
      from: data
    )
  }
}
