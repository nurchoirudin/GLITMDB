//
//  ResponseErrorModel.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 13/02/23.
//

import Foundation

struct ResponseErrorArrayModel: Codable, Error {
    let statusCode: Int
    let statusMessage: String
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}

struct ResponseErrorModel: Codable, Error {
    var title: String?
    var detail: String?
    var errorImageUrl: String?
    var status: NSNumber?
    var code: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case detail
        case code
    }
}
