//
//  BackendEnvironment.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import UIKit

private var selectedHost: URL?

enum BackendEnvironment: Int, CaseIterable {
    case www = 0
    case dev
    case local

    init?(fromHost host: String) {
        guard let validCase = BackendEnvironment.allCases.first(where: { host.contains($0.description) }) else {
            return nil
        }
        self = validCase
    }

    static var baseURL: URL {
        get {
            if let host = selectedHost {
                return host
            }

            // Read from user preferences
            if let url = serviceLocator.userDefaults.url(forKey: .baseURL) {
                selectedHost = url
                return url
            } else {
                // Default to www
                guard let url = BackendEnvironment.www.url else { fatalError("Error with baseURL") }
                selectedHost = url
                return url
            }
        }
        set {
            // Save to user preferences.
            selectedHost = newValue
            serviceLocator.userDefaults.set(newValue, forKey: .baseURL)
        }
    }

    static var current: BackendEnvironment? {
        let currentURL = baseURL
        return allCases.first(where: { $0.url == currentURL })
    }

    static var allDescriptors: [String] {
        return allCases.map { $0.description }
    }

    var description: String {
        switch self {
        case .www:
            return "api"
        case .dev:
            return "dev-api"
        case .local:
            return "local-api"
        }
    }

    var string: String {
        switch self {
        case .local:
            return "http://localhost:3000"
        default:
            return self.description
        }
    }

    var url: URL? {
        var uri: String
        switch self {
        case .local:
            uri = "http://alis-mac-mini.local:10000"
        default:
            uri = "https://\(self.description).tvmaze.com"
        }
        guard let url = URL(string: uri) else { return nil }
        return url
    }

    // Convenience
    static func buildCustomURL(_ domain: String) -> URL? {

        let uri = domain.isStringLink || domain.hasSuffix(".local:3000") ? domain : "https://\(domain).tvmaze.com"

        guard let url = URL(string: uri) else {
            return nil
        }
        return url
    }
}
