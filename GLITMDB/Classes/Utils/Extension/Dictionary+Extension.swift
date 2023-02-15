//
//  Dictionary+Extension.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 14/02/23.
//

import Foundation

extension Dictionary {
    func toQueryString() -> String {
        var queryString: String = ""
        for (key,value) in self {
            queryString += "\(key)=\(value)&"
        }
        return String(queryString)
    }
}
