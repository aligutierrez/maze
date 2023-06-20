//
//  Episode.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation

public struct Episode: Decodable, Hashable, Identifiable{
    private enum CodingKeys: CodingKey {
        case id
        case name
        case number
        case season
        case summary
        case image
        case airdate
    }
    public var id: Int
    public var name: String
    public var number: Int
    public var season: Int
    public var summary: String?
    public var image: URL?
    public var airdate: String

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        number = try values.decode(Int.self, forKey: .number)
        season = try values.decode(Int.self, forKey: .season)
        let rawSummary = try values.decode(String?.self, forKey: .summary)
        summary = rawSummary?.htmlDecoded
        let mediaImage = try values.decode(MediaImage?.self, forKey: .image)
        image = URL(string: mediaImage?.mediumImage ?? "")
        airdate = try values.decode(String.self, forKey: .airdate)
        
    }

    public init() {
        id = 0
        name = ""
        number = 0
        season = 0
        summary = nil
        image = nil
        airdate = ""
    }
}
