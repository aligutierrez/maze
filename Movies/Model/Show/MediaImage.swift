//
//  MediaImage.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation

public struct MediaImage: Decodable {
    private enum CodingKeys: String, CodingKey {
        case mediumImage = "medium"
    }
    public var mediumImage: String
}

