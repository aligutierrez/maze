//
//  Person.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation

import Foundation

// MARK: - WelcomeElement
struct PersonShow: Decodable, Hashable {
    var personShowSelf: Bool
    var voice: Bool
    var links: Links

    enum CodingKeys: String, CodingKey {
        case personShowSelf = "self"
        case voice = "voice"
        case links = "_links"
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Links
struct Links: Codable, Hashable {
    var show: Character
    var character: Character

    enum CodingKeys: String, CodingKey {
        case show = "show"
        case character = "character"
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Character
struct Character: Codable, Hashable {
    var href: String

    enum CodingKeys: String, CodingKey {
        case href = "href"
    }
}

public struct Person: Decodable, Identifiable {
    private enum CodingKeys: CodingKey {
        case person
    }

    private struct PersonData: Decodable {
        private enum CodingKeys: CodingKey {
            case id
            case name
            case image
        }

        var id: Int
        var name: String
        var image: URL?
        var shows: [Show] = []

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            name = try values.decode(String.self, forKey: .name)
            let mediaImage = try? values.decode(MediaImage.self, forKey: .image)
            image = URL(string: mediaImage?.mediumImage ?? "")
        }
    }

    public var id: Int
    public var name: String
    public var image: URL?
    public var shows: [Show]

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let personData = try values.decode(PersonData.self, forKey: .person)
        id = personData.id
        name = personData.name
        image = personData.image
        shows = personData.shows
    }

    public init() {
        id = 0
        name = ""
        image = nil
        shows = []
    }
}
