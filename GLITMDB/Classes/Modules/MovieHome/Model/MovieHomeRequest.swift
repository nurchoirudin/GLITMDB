//
//  MovieHomeRequestModel.swift
//  GLITMDB
//
//  Created by SehatQ on 14/02/23.
//

import Foundation
struct MovieHomeRequestModel {
    var page: Int? = 1
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        params["page"] = page
        
        return params
    }
    
    mutating func resetPage() {
        page = 1
    }
}
