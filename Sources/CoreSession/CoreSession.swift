//
//  CoreSession.swift
//  CoreSession
//
//  Created by Yuşa on 7.10.2025.
//

import Foundation

public actor CoreSession {
    
    // MARK: - Properties
    
    public static let shared = CoreSession()
    
    public var scheme: String {
        config.scheme
    }

    public var host: String {
        config.host
    }
    
    private(set) var config = Config(
        scheme: "https",
        host: "your_domain",
        apiKey: nil
    )
    
    // MARK: - Initialization
    
    private init() { }
    
    // MARK: - Config Structure
    
    public struct Config {
        let scheme: String
        let host: String
        let apiKey: String?
    }
    
    // MARK: - Configuration
    
    public func configure(
        scheme: String,
        host: String,
        apiKey: String?
    ) {
        config = Config(
            scheme: scheme,
            host: host,
            apiKey: apiKey
        )
    }
    
    // MARK: - URL Builder
    
    public func makeURL(_ path: String, query: [String: String?] = [:]) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path.hasPrefix("/") ? path : "/" + path
        if !query.isEmpty {
            components.queryItems = query.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        return components.url!
    }
}
