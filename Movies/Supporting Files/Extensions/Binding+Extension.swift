//
//  Binding+Extension.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI
import Combine

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
