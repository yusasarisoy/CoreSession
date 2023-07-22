import Foundation

// MARK: - DataParserProtocol

public protocol DataParserProtocol {
  func parse<Element: Decodable>(data: Data) throws -> Element
}

// MARK: - DataParser

public final class DataParser {
  
  // MARK: - Properties

  private var jsonDecoder: JSONDecoder

  // MARK: - Initialization
  
  public init(jsonDecoder: JSONDecoder = JSONDecoder()) {
    self.jsonDecoder = jsonDecoder
  }
}

// MARK: - DataParserProtocol

extension DataParser: DataParserProtocol {
  public func parse<Element: Decodable>(data: Data) throws -> Element {
    try jsonDecoder.decode(
      Element.self,
      from: data
    )
  }
}
