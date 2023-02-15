//
//  MovieReviewRequest.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import Foundation

struct MovieReviewRequest {
    var movieId: Int? = 0
    var page: Int? = 1
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        params["page"] = page
        return params
    }
}
