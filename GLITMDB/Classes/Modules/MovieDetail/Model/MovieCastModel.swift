//
//  MovieCastModel.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import Foundation

struct MovieCastModel: Codable {
    let id: Int?
    let cast: [Cast]?
    let crew: [Crew]?
    
    struct Cast: Codable {
        let gender: Int?
        let id: Int?
        let name: String?
        let character: String?
        let profile_path: String?
    }
    
    struct Crew: Codable {
        let gender: Int?
        let id: Int?
        let name: String?
        let job: String?
        let department: String?
    }
}
