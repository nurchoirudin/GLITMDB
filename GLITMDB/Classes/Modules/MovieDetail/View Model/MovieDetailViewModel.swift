//
//  MovieDetailViewModel.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel: BaseViewModel {
    private let dataSource: MovieDetailDataSource
    private let movieDetailModel = BehaviorRelay<MovieDetailModel?>(value: nil)
    private let movieTrailerModel = BehaviorRelay<MovieTrailerModel?>(value: nil)
    private let movieCastModel = BehaviorRelay<MovieCastModel?>(value: nil)
    private let movieReviewModel = BehaviorRelay<MovieReviewModel?>(value: nil)

    private let movieId = BehaviorRelay<Int?>(value: nil)
    
    init(dataSource: MovieDetailDataSource) {
        self.dataSource = dataSource
    }
    
    func getDetailPage(){
        state.accept(.loading)
        guard let movieId = self.movieId.value else { return }
        let getMovieDetail = dataSource.getMovieDetail(request: MovieDetailRequest(movieId: movieId))
        let getMovieTrailer = dataSource.getMovieTrailer(request: MovieTrailerRequest(movieId: movieId))
        let getMovieCast = dataSource.getMovieCast(request: MovieCastRequest(movieId: movieId))
        let getMovieReview = dataSource.getMovieReview(request: MovieReviewRequest(movieId: movieId))

        Observable.zip(getMovieDetail, getMovieTrailer, getMovieCast, getMovieReview).map({
            if let movieDetailModel = $0.0 {
                self.movieDetailModel.accept(movieDetailModel)
            }
            if let trailerMovieModel = $0.1 {
                self.movieTrailerModel.accept(trailerMovieModel)
            }
            if let castMovieModel = $0.2 {
                self.movieCastModel.accept(castMovieModel)
            }
            if let reviewMovieModel = $0.3 {
                self.movieReviewModel.accept(reviewMovieModel)
            }
        }).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.state.accept(.finished)
        }, onError: {[weak self] _ in
            guard let self = self else { return }
            self.state.accept(.failed)
        }).disposed(by: self.disposeBag)
    }
    
    func getMovieDetailModel() -> MovieDetailModel? {
        return movieDetailModel.value
    }
    
    func getMovieTrailerModel() -> MovieTrailerModel? {
        return movieTrailerModel.value
    }
    
    func getMovieCastModel() -> MovieCastModel? {
        return movieCastModel.value
    }
    
    func getMovieReviewModel() -> MovieReviewModel? {
        return movieReviewModel.value
    }

    func setMovieId(_ movieId: Int?){
        self.movieId.accept(movieId)
    }
}
