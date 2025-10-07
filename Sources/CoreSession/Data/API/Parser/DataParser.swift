import Foundation

// MARK: - DataParserProtocol

public protocol DataParserProtocol {
  func parse<Element: Decodable>(_ type: Element.Type, from data: Data) throws -> Element
}

// MARK: - DataParser

public final class DataParser {
  
  // MARK: - Properties
  
  private let jsonDecoder: JSONDecoder
  
  // MARK: - Initialization
  
  public init(jsonDecoder: JSONDecoder = JSONDecoder()) {
    self.jsonDecoder = jsonDecoder
    self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
  }
}

// MARK: - DataParserProtocol

extension DataParser: DataParserProtocol {
  public func parse<Element: Decodable>(_ type: Element.Type, from data: Data) throws -> Element {
    try jsonDecoder.decode(Element.self, from: data)
  }
}
