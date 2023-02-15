//
//  MovieHomeViewModelTest.swift
//  GLITMDBTests
//
//  Created by Nur Choirudin on 15/02/23.
//

@testable import GLITMDB
import XCTest
import Cuckoo
import RxSwift

class MovieHomeViewModelTest: XCTestCase {
    let mockDataSource = MockMovieHomeDataSource()
    var viewModel: MovieHomeViewModel?
    let disposeBag = DisposeBag()
    
    let expectedMovieListModel = DummyMovieListModel().getMovieListModel()

    override func setUp() {
        super.setUp()
        viewModel = MovieHomeViewModel(dataSource: mockDataSource)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testDiscoverMovie(){
        let expected = expectation(description: "Observer Passed")
        viewModel?.state.subscribe(
            onNext: {[weak self] state in
                guard let self = self else { return }
                switch state {
                case .finished:
                    XCTAssertNotNil(self.viewModel?.getMovieListModel())
                    XCTAssertEqual(self.viewModel?.getMovieListModel()?.results?.first?.id, self.expectedMovieListModel.results?.first?.id)
                    expected.fulfill()
                default:
                    break
                }
            }).disposed(by: self.disposeBag)
        
        stub(mockDataSource) { stub in
            when(stub).discoverMovie(request: any()).thenReturn(Observable.just(self.expectedMovieListModel))
        }
        
        viewModel?.discoverMovie()
        verify(mockDataSource).discoverMovie(request: any())
        wait(for: [expected], timeout: 10)
    }
    
    func testSearchMovie(){
        let expected = expectation(description: "Observer Passed")
        viewModel?.state.subscribe(
            onNext: {[weak self] state in
                guard let self = self else { return }
                switch state {
                case .finished:
                    XCTAssertNotNil(self.viewModel?.getMovieSearchListModel())
                    XCTAssertEqual(self.viewModel?.getMovieSearchListModel()?.results?.first?.id, self.expectedMovieListModel.results?.first?.id)
                    expected.fulfill()
                default:
                    break
                }
            }).disposed(by: self.disposeBag)
        
        stub(mockDataSource) { stub in
            when(stub).searchMovie(request: any()).thenReturn(Observable.just(self.expectedMovieListModel))
        }
        
        viewModel?.searchMovie(query: "")
        verify(mockDataSource).searchMovie(request: any())
        wait(for: [expected], timeout: 10)
    }
    
    func testLoadMoreDiscovery(){
        let expected = expectation(description: "Observer Passed")
        viewModel?.state.subscribe(
            onNext: {[weak self] state in
                guard let self = self else { return }
                switch state {
                case .finished:
                    XCTAssertNotNil(self.viewModel?.getMovieListModel())
                    XCTAssertEqual(self.viewModel?.getMovieListModel()?.results?.first?.id, self.expectedMovieListModel.results?.first?.id)
                    expected.fulfill()
                default:
                    break
                }
            }).disposed(by: self.disposeBag)
        
        stub(mockDataSource) { stub in
            when(stub).discoverMovie(request: any()).thenReturn(Observable.just(self.expectedMovieListModel))
        }
        
        viewModel?.loadMore(status: true)
        verify(mockDataSource).discoverMovie(request: any())
        wait(for: [expected], timeout: 10)
    }
    
    func testLoadMoreSearchMovie(){
        let expected = expectation(description: "Observer Passed")
        viewModel?.toggleToSearchMovie(status: true)
        viewModel?.state.subscribe(
            onNext: {[weak self] state in
                guard let self = self else { return }
                switch state {
                case .finished:
                    XCTAssertNotNil(self.viewModel?.getMovieSearchListModel())
                    XCTAssertEqual(self.viewModel?.getMovieSearchListModel()?.results?.first?.id, self.expectedMovieListModel.results?.first?.id)
                    expected.fulfill()
                default:
                    break
                }
            }).disposed(by: self.disposeBag)
        
        stub(mockDataSource) { stub in
            when(stub).searchMovie(request: any()).thenReturn(Observable.just(self.expectedMovieListModel))
        }
        
        viewModel?.loadMore(status: true)
        verify(mockDataSource).searchMovie(request: any())
        wait(for: [expected], timeout: 10)
    }
    
    func testReloadHomeDiscovery(){
        let expected = expectation(description: "Observer Passed")
        viewModel?.state.subscribe(
            onNext: {[weak self] state in
                guard let self = self else { return }
                switch state {
                case .finished:
                    XCTAssertNotNil(self.viewModel?.getMovieListModel())
                    XCTAssertEqual(self.viewModel?.getMovieListModel()?.results?.first?.id, self.expectedMovieListModel.results?.first?.id)
                    expected.fulfill()
                default:
                    break
                }
            }).disposed(by: self.disposeBag)
        
        stub(mockDataSource) { stub in
            when(stub).discoverMovie(request: any()).thenReturn(Observable.just(self.expectedMovieListModel))
        }
        
        viewModel?.reloadHome()
        verify(mockDataSource).discoverMovie(request: any())
        wait(for: [expected], timeout: 10)
    }
    
    func testReloadHomeSearchMovie(){
        let expected = expectation(description: "Observer Passed")
        viewModel?.toggleToSearchMovie(status: true)
        viewModel?.state.subscribe(
            onNext: {[weak self] state in
                guard let self = self else { return }
                switch state {
                case .finished:
                    XCTAssertNotNil(self.viewModel?.getMovieSearchListModel())
                    XCTAssertEqual(self.viewModel?.getMovieSearchListModel()?.results?.first?.id, self.expectedMovieListModel.results?.first?.id)
                    expected.fulfill()
                default:
                    break
                }
            }).disposed(by: self.disposeBag)
        
        stub(mockDataSource) { stub in
            when(stub).searchMovie(request: any()).thenReturn(Observable.just(self.expectedMovieListModel))
        }
        
        viewModel?.reloadHome()
        verify(mockDataSource).searchMovie(request: any())
        wait(for: [expected], timeout: 10)
    }
    
}
