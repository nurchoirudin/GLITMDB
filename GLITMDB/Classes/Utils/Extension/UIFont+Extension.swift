//
//  UIFont.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 13/02/23.
//

import UIKit

extension UIFont {
    class func Barlow(type: BarlowType, ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: type.rawValue, size: ofSize) {
            return font
        }
        return UIFont.systemFont(ofSize: ofSize)
    }
}
