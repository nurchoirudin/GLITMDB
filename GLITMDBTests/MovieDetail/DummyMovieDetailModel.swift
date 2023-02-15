//
//  DummyMovieDetailModel.swift
//  GLITMDBTests
//
//  Created by Nur Choirudin on 15/02/23.
//

@testable import GLITMDB
import RxSwift

struct DummyMovieDetailModel {
    let dummyInt = Int.random(in: 0...100)
    let dummyDouble = Double.random(in: 0...100)
    let dummyString = UUID().uuidString
    let dummyBool = Bool.random()
    
    func getMovieDetailModel() -> MovieDetailModel {
        return MovieDetailModel(adult: dummyBool, backdropPath: dummyString, belongsToCollection: MovieDetailModel.BelongsToCollection(id: dummyInt, name: dummyString, posterPath: dummyString, backdropPath: dummyString), budget: dummyInt, genres: [MovieDetailModel.Genre(id: dummyInt, name: dummyString)], homepage: dummyString, id: dummyInt, imdbID: dummyString, originalLanguage: dummyString, originalTitle: dummyString, overview: dummyString, popularity: dummyDouble, posterPath: dummyString, productionCompanies: [MovieDetailModel.ProductionCompany(id: dummyInt, logoPath: dummyString, name: dummyString, originCountry: dummyString)], productionCountries: [MovieDetailModel.ProductionCountry(iso3166_1: dummyString, name: dummyString)], releaseDate: dummyString, revenue: dummyInt, runtime: dummyInt, spokenLanguages: [MovieDetailModel.SpokenLanguage(englishName: dummyString, iso639_1: dummyString, name: dummyString)], status: dummyString, tagline: dummyString, title: dummyString, video: dummyBool, voteAverage: dummyDouble, voteCount: dummyInt)
    }
    
    func getMovieTrailerModel() -> MovieTrailerModel {
        return MovieTrailerModel(id: dummyInt, results: [MovieTrailerModel.Result(iso639_1: dummyString, iso3166_1: dummyString, name: dummyString, key: dummyString, publishedAt: dummyString, site: dummyString, size: dummyInt, type: dummyString, official: dummyBool, id: dummyString)])
    }
    
    func getMovieCastModel() -> MovieCastModel {
        return MovieCastModel(id: dummyInt, cast: [MovieCastModel.Cast(gender: dummyInt, id: dummyInt, name: dummyString, character: dummyString, profile_path: dummyString)], crew: [MovieCastModel.Crew(gender: dummyInt, id: dummyInt, name: dummyString, job: dummyString, department: dummyString)])
    }
    
    func getMovieReviewModel() -> MovieReviewModel {
        return MovieReviewModel(id: dummyInt, page: dummyInt, results: [MovieReviewModel.Result(author: dummyString, authorDetails: MovieReviewModel.AuthorDetails(name: dummyString, username: dummyString, avatarPath: dummyString, rating: dummyInt), content: dummyString, createdAt: dummyString, id: dummyString, updatedAt: dummyString, url: dummyString)], totalPages: dummyInt, totalResults: dummyInt)
    }
}
