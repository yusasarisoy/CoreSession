//
//  CoreSessionManager.swift
//  CoreSession
//
//  Created by Yuşa on 7.10.2025.
//

import Foundation

public final class CoreSessionManager: @unchecked Sendable {
  
  // MARK: - Properties
  
  public static let shared = CoreSessionManager()
  
  private var _config = Config(
    scheme: "https",
    host: "your_domain",
    apiKey: nil
  )
  
  private let lock = NSLock()
  
  public var scheme: String {
    withLock { $0.scheme }
  }
  
  public var host: String {
    withLock { $0.host }
  }
  
  // MARK: - Initialization
  
  private init() { }
  
  // MARK: - Config Structure
  
  public struct Config: Sendable {
    let scheme: String
    let host: String
    let apiKey: String?
  }
  
  // MARK: - Configuration
  
  public func configure(scheme: String, host: String, apiKey: String?) {
    lock.lock()
    defer {
      lock.unlock()
    }
    _config = Config(scheme: scheme, host: host, apiKey: apiKey)
  }
  
  // MARK: - URL Builder
  
  public func makeURL(_ path: String, query: [String: String?] = [:]) -> URL {
    let config = withLock { $0 }
    var comps = URLComponents()
    comps.scheme = config.scheme
    comps.host = config.host
    comps.path = path.hasPrefix("/") ? path : "/" + path
    if !query.isEmpty {
      comps.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    guard let url = comps.url else {
      fatalError("Invalid URL")
    }
    return url
  }
  
  // MARK: - Private Helper Functions
  
  @inline(__always)
  private func withLock<Element>(_ body: (Config) -> Element) -> Element {
    lock.lock()
    defer {
      lock.unlock()
    }
    return body(_config)
  }
}
