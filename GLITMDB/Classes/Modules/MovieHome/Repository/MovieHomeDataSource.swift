//
//  MovieHomeDataSource.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 14/02/23.
//

import Foundation
import RxSwift

protocol MovieHomeDataSource {
    func discoverMovie(request: MovieHomeRequest) -> Observable<MovieListModel?>
    func searchMovie(request: MovieHomeSearchRequest) -> Observable<MovieListModel?>
}
