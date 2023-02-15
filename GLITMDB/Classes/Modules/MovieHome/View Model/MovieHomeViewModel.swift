//
//  MovieHomeViewModel.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 14/02/23.
//

import Foundation
import RxSwift
import RxCocoa

class MovieHomeViewModel: BaseViewModel {
    private let dataSource: MovieHomeDataSource
    private let movieListModel = BehaviorRelay<MovieListModel?>(value: nil)
    private let movieSearchListModel = BehaviorRelay<MovieListModel?>(value: nil)
    private let discoverMovieRequest = BehaviorRelay<MovieHomeRequest?>(value: MovieHomeRequest(page: 1))
    private let searchMovieRequest = BehaviorRelay<MovieHomeSearchRequest?>(value: MovieHomeSearchRequest(page: 1, query: ""))
    
    private let nextPage = BehaviorRelay<Bool>(value: false)
    private let movieSearch = BehaviorRelay<Bool>(value: false)
    
    init(dataSource: MovieHomeDataSource) {
        self.dataSource = dataSource
    }
    
    func discoverMovie(){
        guard let request = discoverMovieRequest.value else { return }
        state.accept(.loading)
        dataSource.discoverMovie(request: request)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else { return }
                if self.nextPage.value {
                    let movieResult = self.movieListModel.value?.results
                    let newMovieResult = model?.results
                    let newModel = MovieListModel(page: model?.page, results: (movieResult ?? []) + (newMovieResult ?? []), totalPages: model?.totalPages, totalResults: model?.totalResults)
                    self.movieListModel.accept(newModel)
                } else {
                    self.movieListModel.accept(model)
                }
                self.nextPage.accept(false)
                self.state.accept(.finished)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.handleNetworkError(error)
                
                self.nextPage.accept(false)
                self.state.accept(.failed)
            })
            .disposed(by: disposeBag)
    }
    
    func searchMovie(query: String?){
        if searchMovieRequest.value?.query != query {
            movieSearchListModel.accept(nil)
            searchMovieRequest.accept(MovieHomeSearchRequest(page: 1, query: query))
        } else {
            searchMovieRequest.accept(MovieHomeSearchRequest(page: searchMovieRequest.value?.page, query: query))
        }
        state.accept(.loading)
        
        guard let request = searchMovieRequest.value else { return }
        dataSource.searchMovie(request: request)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else { return }
                if self.nextPage.value {
                    let movieResult = self.movieSearchListModel.value?.results
                    let newMovieResult = model?.results
                    let newModel = MovieListModel(page: model?.page, results: (movieResult ?? []) + (newMovieResult ?? []), totalPages: model?.totalPages, totalResults: model?.totalResults)
                    self.movieSearchListModel.accept(newModel)
                } else {
                    self.movieSearchListModel.accept(model)
                }
                self.state.accept(.finished)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.handleNetworkError(error)
                self.state.accept(.failed)
            })
            .disposed(by: disposeBag)
    }
    
    func getMovieListModel() -> MovieListModel? {
        return movieListModel.value
    }
    
    func getMovieSearchListModel() -> MovieListModel? {
        return movieSearchListModel.value
    }
    
    func loadMore(status: Bool) {
        nextPage.accept(status)
        if movieSearch.value {
            if nextPage.value {
                guard let query = searchMovieRequest.value?.query else { return }
                guard let page = searchMovieRequest.value?.page else { return }
                
                searchMovieRequest.accept(MovieHomeSearchRequest(page: page + 1, query: query))
                searchMovie(query: searchMovieRequest.value?.query)
            }
        } else {
            if nextPage.value {
                guard let page = discoverMovieRequest.value?.page else { return }
                discoverMovieRequest.accept(MovieHomeRequest(page: page + 1))
                discoverMovie()
            }
        }
    }
    
    func toggleToSearchMovie(status: Bool) {
        movieSearch.accept(status)
    }
    
    func isLoadmore() -> Bool {
        return nextPage.value
    }
    
    func isMovieSearch() -> Bool {
        return movieSearch.value
    }
    
    func reloadHome(){
        if movieSearch.value {
            guard let query = searchMovieRequest.value?.query else { return }
            movieSearchListModel.accept(nil)
            searchMovieRequest.accept(MovieHomeSearchRequest(page: 1, query: query))
            searchMovie(query: searchMovieRequest.value?.query)
        } else {
            movieListModel.accept(nil)
            discoverMovieRequest.accept(MovieHomeRequest(page: 1))
            discoverMovie()
        }
    }
    
}
