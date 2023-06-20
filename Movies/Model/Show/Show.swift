//
//  Show.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation

public struct ShowSearch: Decodable, Hashable {
    let score: Double
    let show: Show
}


public struct Show: Decodable, Hashable, Identifiable {
    
    private enum CodingKeys: CodingKey {
        case id
        case name
        case image
        case schedule
        case genres
        case summary
    }

    public var id: Int
    public var name: String
    public var poster: URL?
    public var schedule: Schedule
    public var genres: [String]
    public var summary: String?
    public var episodesBySeason: [Int: [Episode]] = [:]
    public var seasonKeys: [Int] {
        episodesBySeason.keys.sorted()
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        let mediaImage = try values.decode(MediaImage?.self, forKey: .image)
        poster = URL(string: mediaImage?.mediumImage ?? "")
        schedule = try values.decode(Schedule.self, forKey: .schedule)
        genres = try values.decode([String].self, forKey: .genres)
        let rawSummary = try values.decode(String?.self, forKey: .summary)
        summary = rawSummary?.htmlDecoded
    }

    public init() {
        id = 0
        name = ""
        poster = nil
        schedule = Schedule(time: "", days: [])
        genres = []
        summary = nil
        episodesBySeason = [:]
    }
}

// MARK: - Equatable
extension Show: Equatable {

    /// Equatable conformance
    ///
    /// - Parameters:
    ///   - lhs: left hand side of == operator
    ///   - rhs: right hand side of == operator
    /// - Returns: bool indicating if both objects are considered equal.
    public static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.poster == rhs.poster &&
        lhs.genres == rhs.genres &&
        lhs.summary == rhs.summary

    }
}
