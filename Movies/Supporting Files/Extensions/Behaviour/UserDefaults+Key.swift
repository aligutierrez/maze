//
//  UserDefaults+Key.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import Foundation

extension UserDefaults {

    // MARK: - Keys
    enum Key: String {

        // Application State
        case baseURL
        case appLanguage
        case token
        case type
        case userType
        case isSessionActive
        case isAppLockEnable
        case favoriteShows

        case hasLoginKey
        case userEmailKey
        case userPhoneNumber
        case userLoggedIn

    }

    // MARK: - Getters

    func integer(forKey key: Key) -> Int {
        return integer(forKey: key.rawValue)
    }

    func string(forKey key: Key) -> String? {
        return string(forKey: key.rawValue)
    }

    func url(forKey key: Key) -> URL? {
        return url(forKey: key.rawValue)
    }

    func object(forKey key: Key) -> Any? {
        return object(forKey: key.rawValue)
    }

    // Generic getter.
    func object<T>(forKey key: Key) -> T? {
        return object(forKey: key) as? T
    }

    // MARK: - Setters

    func set(_ integer: Int, forKey key: Key) {
        set(integer, forKey: key.rawValue)
    }

    func set(_ url: URL, forKey key: Key) {
        set(url, forKey: key.rawValue)
    }

    func set(_ object: Any?, forKey key: Key) {
        set(object, forKey: key.rawValue)
    }
}
