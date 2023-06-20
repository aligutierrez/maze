//
//  Sequence+Extension.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/20/23.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
