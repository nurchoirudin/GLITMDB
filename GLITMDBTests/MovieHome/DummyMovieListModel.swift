//
//  DummyMovieListModel.swift
//  GLITMDBTests
//
//  Created by Nur Choirudin on 15/02/23.
//

@testable import GLITMDB
import RxSwift

struct DummyMovieListModel {
    let dummyInt = Int.random(in: 0...100)
    let dummyDouble = Double.random(in: 0...100)
    let dummyString = UUID().uuidString
    let dummyBool = Bool.random()
    
    func getMovieListModel() -> MovieListModel {
        return MovieListModel(page: dummyInt, results: [MovieListModel.Result(adult: dummyBool, backdropPath: dummyString, genreIDS: [dummyInt], id: dummyInt, originalLanguage: dummyString, originalTitle: dummyString, overview: dummyString, popularity: dummyDouble, posterPath: dummyString, releaseDate: dummyString, title: dummyString, video: dummyBool, voteAverage: dummyDouble, voteCount: dummyInt)], totalPages: dummyInt, totalResults: dummyInt)
    }
}
