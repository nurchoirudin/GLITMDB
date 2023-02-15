//
//  MovieDetailDataSource.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import Foundation
import RxSwift

protocol MovieDetailDataSource {
    func getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailModel?>
    func getMovieTrailer(request: MovieTrailerRequest) -> Observable<MovieTrailerModel?>
    func getMovieCast(request: MovieCastRequest) -> Observable<MovieCastModel?>
    func getMovieReview(request: MovieReviewRequest) -> Observable<MovieReviewModel?>
}
