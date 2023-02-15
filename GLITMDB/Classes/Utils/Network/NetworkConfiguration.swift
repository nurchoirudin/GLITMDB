//
//  NetworkConfiguration.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 13/02/23.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum ImageMovieType {
    case poster, backdrop, avatar
}

struct NetworkConfiguration {
    static let BASE_URL = "http://api.themoviedb.org/"
    static let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/"

    static let apiPath = "3/"
    static var apiKey: [String: Any] = ["api_key": "37d93132bd2d64d208704da776a15349"]
    
    static let kTokenExpiredErrorCode = 405
    static let kGatewayTimeoutErrorCode = 503
    static let kMissingPhoneNumberErrorCode = 403
    
    static var envBaseUrl: String = {
        return BASE_URL
    }()
    
    static var apiVersion: String = {
        return apiPath
    }()
    
    static func api(_ apiType: APIUrl) -> String {
        return envBaseUrl + apiVersion + apiType.apiString()
    }
    
    static func getAssetUrlPath(type: ImageMovieType) -> String {
        switch type {
        case .poster:
            return "\(BASE_IMAGE_URL)w500"
        case .backdrop:
            return "\(BASE_IMAGE_URL)w1920_and_h800_multi_faces"
        case .avatar:
            return "\(BASE_IMAGE_URL)w276_and_h350_face"
        }
    }
}
