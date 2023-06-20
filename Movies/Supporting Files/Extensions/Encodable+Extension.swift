//
//  Encodable+Extension.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation

extension Encodable {

    /// Flat maps a JSON from an encodable object to create a dictionary
    var asDictionary: [String: Any] {
        guard
            let data = try? JSONEncoder().encode(self),
            let dict = (try? JSONSerialization.jsonObject(with: data,
                                                          options: .allowFragments)).flatMap({ $0 as? [String: Any] })
            else {
                return [:]
        }
        return dict
    }

    var asJSONString: String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

