//
//  MovieDetailRepository.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import Foundation
import RxSwift

class MovieDetailRepository: MovieDetailDataSource {
    private let remoteData: NetworkProtocol
    
    init(remoteData: NetworkProtocol) {
        self.remoteData = remoteData
    }
    
    func getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailModel?> {
        let url = APIUrl.getDetailMovie(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieDetailModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieDetailModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
    
    func getMovieTrailer(request: MovieTrailerRequest) -> Observable<MovieTrailerModel?> {
        let url = APIUrl.getTrailerMovie(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieTrailerModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieTrailerModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
    
    func getMovieCast(request: MovieCastRequest) -> Observable<MovieCastModel?> {
        let url = APIUrl.getCastMovie(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieCastModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieCastModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
    func getMovieReview(request: MovieReviewRequest) -> Observable<MovieReviewModel?> {
        let url = APIUrl.getReviewMovie(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieReviewModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieReviewModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
}
