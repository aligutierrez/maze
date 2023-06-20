//
//  NetworkError.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation

public enum NetworkError: String, MazeError {
    case invalidUrl = "The endpoint url is invalid"
    case dataNotFound = "The data was not found"
    case lastPageAchieved = "The last page was achieved"
    case parseFailed = "The parsing of thee network response failed"
    case rateLimitAchieved = "The rate limit was achieved"
    case invalidSubDomain = "Please provide a valid URL"
}


// MARK: - CaseIterable
extension NetworkError: CaseIterable {

    /// Failable init from a localized description.
    ///
    /// - Parameter description: Exact localized description for the case.
    init?(description: String) {
        guard let value = NetworkError.allCases.first(where: { $0.errorDescription == description }) else { return nil }
        self = value
    }
}
