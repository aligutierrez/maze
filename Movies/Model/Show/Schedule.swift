//
//  Schedule.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation

public struct Schedule: Decodable, Hashable {
    public var time: String
    public var days: [String]
}
