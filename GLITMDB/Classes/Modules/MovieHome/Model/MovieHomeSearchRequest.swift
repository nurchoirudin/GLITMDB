//
//  MovieHomeSearchRequest.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 14/02/23.
//

import Foundation

struct MovieHomeSearchRequest {
    var page: Int? = 1
    var query: String?
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        params["page"] = page
        params["query"] = query

        return params
    }
    
    mutating func resetPage() {
        page = 1
    }
}
