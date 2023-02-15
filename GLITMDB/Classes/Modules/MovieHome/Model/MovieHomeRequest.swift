//
//  MovieHomeRequest.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 14/02/23.
//

import Foundation

struct MovieHomeRequest {
    var page: Int? = 1
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        params["page"] = page
        
        return params
    }
}
