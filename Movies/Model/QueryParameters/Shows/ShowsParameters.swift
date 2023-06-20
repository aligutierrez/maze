//
//  ShowsParameters.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation

struct ShowsParameters {

    
    // Properties

    var page: Int

    /// Inits a LoginParameters object with default values
    ///
    init() {
        page = 1
    }
}

// MARK: - Encodable
extension ShowsParameters: Encodable {
    enum CodingKeys: String, CodingKey {
        case page
    }

}

// MARK: - Equatable
extension ShowsParameters: Equatable {

    /// Equatable conformance
    ///
    /// - Parameters:
    ///   - lhs: left hand side of == operator
    ///   - rhs: right hand side of == operator
    /// - Returns: bool indicating if both objects are considered equal.
    static func == (lhs: ShowsParameters, rhs: ShowsParameters) -> Bool {
        return
            lhs.page == rhs.page
    }
}
