//
//  MovieHomeRepository.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 14/02/23.
//

import RxSwift

class MovieHomeRepository: MovieHomeDataSource {
    private let remoteData: NetworkProtocol
    
    init(remoteData: NetworkProtocol) {
        self.remoteData = remoteData
    }
    
    func discoverMovie(request: MovieHomeRequest) -> Observable<MovieListModel?> {
        let url = APIUrl.discoverMovie(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieListModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieListModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
    
    func searchMovie(request: MovieHomeSearchRequest) -> Observable<MovieListModel?> {
        let url = APIUrl.searchMovie(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieListModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieListModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
}
