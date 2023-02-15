//
//  APIUrl.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 13/02/23.
//

import Foundation

enum APIUrl {
    case discoverMovie(request: MovieHomeRequest)
    case searchMovie(request: MovieHomeSearchRequest)
    case getDetailMovie(request: MovieDetailRequest)
    case getTrailerMovie(request: MovieTrailerRequest)
    case getCastMovie(request: MovieCastRequest)
    case getReviewMovie(request: MovieReviewRequest)

    func apiString() -> String {
        switch self {
        case .discoverMovie(let request):
            let param = "\(NetworkConfiguration.apiKey.toQueryString())\(request.getParams().toQueryString())"
            return "discover/movie?\(param)"
        case .searchMovie(let request):
            let param = "\(NetworkConfiguration.apiKey.toQueryString())\(request.getParams().toQueryString())"
            return "search/movie?\(param)"
        case .getDetailMovie(let request):
            return "movie/\(request.movieId ?? 0)?\(NetworkConfiguration.apiKey.toQueryString())"
        case .getTrailerMovie(let request):
            return "movie/\(request.movieId ?? 0)/videos?\(NetworkConfiguration.apiKey.toQueryString())"
        case .getCastMovie(let request):
            return "movie/\(request.movieId ?? 0)/credits?\(NetworkConfiguration.apiKey.toQueryString())"
        case .getReviewMovie(let request):
            let param = "\(NetworkConfiguration.apiKey.toQueryString())\(request.getParams().toQueryString())"
            return "movie/\(request.movieId ?? 0)/reviews?\(param)"
        }
    }
    
    func urlString() -> String {
        return NetworkConfiguration.api(self)
    }
}
