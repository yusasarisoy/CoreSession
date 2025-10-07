//
//  CoreSessionTests.swift
//  CoreSession
//
//  Created by Yuşa on 7.10.2025.
//

import Foundation
import Testing
@testable import CoreSession

@Suite("CoreSession basic suite")
struct CoreSessionSuite {
  
  @Test("Defaults: scheme & host not empty")
  func defaultsNotEmpty() async {
    let scheme = await CoreSession.shared.scheme
    let host = await CoreSession.shared.host
    #expect(!scheme.isEmpty)
    #expect(!host.isEmpty)
  }
  
  @Test("makeURL builds correct components")
  func makeURLBuildsComponents() async {
    // Given
    let path = "/v1/test"
    let params = [
      "b": "x",
      "a": "1"
    ]
    
    // When
    let url = await CoreSession.shared.makeURL(path, query: params)
    
    // Then
    let scheme = await CoreSession.shared.scheme
    let host   = await CoreSession.shared.host
    #expect(url.scheme == scheme)
    #expect(url.host == host)
    #expect(url.path == path)
    
    let items = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems ?? []
    let dict = Dictionary(uniqueKeysWithValues: items.map { ($0.name, $0.value ?? "") })
    #expect(dict == params)
  }
}
