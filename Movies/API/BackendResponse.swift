//
//  BackendResponse.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation

// Type to be used for all enums that represent an error from Backend
typealias MazeError = Error & LocalizedError & Decodable

/// Structure for a custom Mitwerken backend response.
struct BackendResponse<T> where T: MazeError {
    let error: MoviesAPIError?
}

struct MoviesAPIError: Codable {
    let message: String
    let code: String
}

// MARK: - MoviesError
extension BackendResponse: MazeError {
    // MARK: LocalizedError

    // MARK: Decodable

    enum CodingKeys: CodingKey {
        case error
    }

    /// Custom implementation for decoder to support T and custom errors from API.
    ///
    /// - Parameter decoder: a decoder.
    /// - Throws: When a container does not contain one of the CodingKeys.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let error = try? container.decode(MoviesAPIError.self, forKey: .error)
        self.init(error: error)
    }
}

