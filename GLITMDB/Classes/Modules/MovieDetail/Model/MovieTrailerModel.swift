//
//  MovieTrailerModel.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import Foundation

struct MovieTrailerModel: Codable {
    let id: Int?
    let results: [Result]?
    
    //MARK: - Result
    struct Result: Codable {
        let iso639_1: String?
        let iso3166_1: String?
        let name, key, publishedAt: String?
        let site: String?
        let size: Int?
        let type: String?
        let official: Bool?
        let id: String?
        
        enum CodingKeys: String, CodingKey {
            case iso639_1 = "iso_639_1"
            case iso3166_1 = "iso_3166_1"
            case name, key
            case publishedAt = "published_at"
            case site, size, type, official, id
        }
    }
    
}
