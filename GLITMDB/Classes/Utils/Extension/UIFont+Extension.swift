//
//  UIFont.swift
//  GLITMDB
//
//  Created by SehatQ on 13/02/23.
//

import UIKit

enum BarlowType: String {
    case SemiBold = "Barlow-SemiBold"
    case Regular = "Barlow-Regular"
    case Bold = "Barlow-Bold"
    case Italic = "Barlow-Italic"
    case Light = "Barlow-Light"
    case LightItalic = "Barlow-LightItalic"
}

extension UIFont {
    class func Barlow(type: BarlowType, ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: type.rawValue, size: ofSize) {
            return font
        }
        return UIFont.systemFont(ofSize: ofSize)
    }
}
