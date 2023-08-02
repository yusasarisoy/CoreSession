import Foundation

public enum NetworkError: LocalizedError {
  case dataParsingFailed
  case invalidServerResponse
  case invalidURL

  public var errorDescription: String? {
    switch self {
    case .dataParsingFailed:
      return "Data parsing has failed."
    case .invalidServerResponse:
      return "Invalid server response occurred."
    case .invalidURL:
      return "The URL is invalid."
    }
  }
}
