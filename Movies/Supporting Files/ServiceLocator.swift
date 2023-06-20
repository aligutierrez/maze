//
//  ServiceLocator.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/12/21.
//

import Foundation
/// Service locator.
var serviceLocator = ServiceLocator()

struct ServiceLocator {
    // Cocoa
    var userDefaults: UserDefaults = .standard

    //Protocol
    var webService: MazeAPI = MazeService()
    
}
