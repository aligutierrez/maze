//
//  UIDevice+Extension.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import UIKit
import Foundation

// Family of devices, based on the screen size
// Useful create specific layouts
public enum ScreenType {
    case iPhone5to5C // 5, 5S, 5C
    case iPhone6to8 // 6, 6S, 7, 8
    case iPhone6to8Plus // 6Plus, 6SPlus, 7Plus, 8Plus
    case iPhoneXto14Pro // X, XS, 11Pro, 12Pro 13Pro ,14Pro
    case iPhoneXSMaxTo14ProMax // XS Max, 14Pro Max
    case iPhoneXRto14 // XR, 14
    case unknown

    public var isSmallScreen: Bool {
        [.iPhone5to5C, .iPhone6to8].contains(self)
    }
}

public extension UIDevice {
    // Maps devices screen sizes to the proper device family
    static var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136: return .iPhone5to5C
        case 1334: return .iPhone6to8
        case 1792: return .iPhoneXRto14
        case 1920, 2208: return .iPhone6to8Plus
        case 2436: return .iPhoneXto14Pro
        case 2688: return .iPhoneXSMaxTo14ProMax
        default: return .unknown
        }
    }
}
