//
//  TMDBColor.swift
//  GLITMDB
//
//  Created by SehatQ on 14/02/23.
//

import Foundation

enum TMDBColor: String {
    case scrollerGrey = "#dbdbdb"
    case lightGrey = "#e3e3e3"
    case darkerGrey = "#c8c8c8"
    case tmdbDarkBlue = "#032541"
    case tmdbLightBlue = "#01b4e4"
    case tmdbLighterGreen = "#c0fed0"
    case tmdbLightGreen = "#1ed5a9"
    case tmdbLogoGreen = "#90cea1"
    case tmdbLogoOrange = "#fdc170"
    case tmdbLogoRed = "#d93b63"
    case accountSilver = "#959595"
    case accountPink = "#ea148c"
    case accountPurple = "#805be7"
    case accountGreen = "#01d277"
    case accountTeal = "#01c6ac"
    case accountBlue = "#0177d2"
    case accountOrange = "#d27701"
    case accountYellow = "#d29001"
    case accountRed = "#d40242"
    
    func getColor() -> UIColor? {
        return UIColor(hexString: self.rawValue)
    }
}
