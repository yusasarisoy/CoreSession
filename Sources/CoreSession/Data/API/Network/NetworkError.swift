import Foundation

// MARK: - NetworkError

public enum NetworkError {
  case invalidServerResponse
  case invalidURL
  case dataParsingFailed
}

// MARK: - NetworkError+LocalizedError

extension NetworkError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .invalidServerResponse:
      return "The server returned an invalid response."
    case .invalidURL:
      return "The URL is invalid."
    case .dataParsingFailed:
      return "Data parsing has failed for the requested type."
    }
  }
}
