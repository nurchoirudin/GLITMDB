//
//  MovieDetailViewModelTest.swift
//  GLITMDBTests
//
//  Created by Nur Choirudin on 15/02/23.
//

@testable import GLITMDB
import XCTest
import Cuckoo
import RxSwift

class MovieDetailViewModelTest: XCTestCase {
    let mockDataSource = MockMovieDetailDataSource()
    var viewModel: MovieDetailViewModel?
    let disposeBag = DisposeBag()
    
    let expectedMovieDetailModel = DummyMovieDetailModel().getMovieDetailModel()
    let expectedMovieTrailerModel = DummyMovieDetailModel().getMovieTrailerModel()
    let expectedMovieCastModel = DummyMovieDetailModel().getMovieCastModel()
    let expectedMovieReviewModel = DummyMovieDetailModel().getMovieReviewModel()
   
    override func setUp() {
        super.setUp()
        viewModel = MovieDetailViewModel(dataSource: mockDataSource)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSearchMovie(){
        let expected = expectation(description: "Observer Passed")
        viewModel?.setMovieId(0)
        viewModel?.state.subscribe(
            onNext: {[weak self] state in
                guard let self = self else { return }
                switch state {
                case .finished:
                    XCTAssertNotNil(self.viewModel?.getMovieDetailModel())
                    XCTAssertNotNil(self.viewModel?.getMovieCastModel())
                    XCTAssertNotNil(self.viewModel?.getMovieReviewModel())
                    XCTAssertNotNil(self.viewModel?.getMovieTrailerModel())

                    XCTAssertEqual(self.viewModel?.getMovieDetailModel()?.id, self.expectedMovieDetailModel.id)
                    XCTAssertEqual(self.viewModel?.getMovieCastModel()?.cast?.first?.id, self.expectedMovieCastModel.cast?.first?.id)
                    XCTAssertEqual(self.viewModel?.getMovieReviewModel()?.results?.first?.id, self.expectedMovieReviewModel.results?.first?.id)
                    XCTAssertEqual(self.viewModel?.getMovieTrailerModel()?.results?.first?.id, self.expectedMovieTrailerModel.results?.first?.id)
                    
                    expected.fulfill()
                default:
                    break
                }
            }).disposed(by: self.disposeBag)
        
        stub(mockDataSource) { stub in
            when(stub).getMovieDetail(request: any()).thenReturn(Observable.just(self.expectedMovieDetailModel))
        }
        
        stub(mockDataSource) { stub in
            when(stub).getMovieReview(request: any()).thenReturn(Observable.just(self.expectedMovieReviewModel))
        }
        
        stub(mockDataSource) { stub in
            when(stub).getMovieTrailer(request: any()).thenReturn(Observable.just(self.expectedMovieTrailerModel))
        }
        
        stub(mockDataSource) { stub in
            when(stub).getMovieCast(request: any()).thenReturn(Observable.just(self.expectedMovieCastModel))
        }
        
        viewModel?.getDetailPage()
        
        verify(mockDataSource).getMovieDetail(request: any())
        verify(mockDataSource).getMovieReview(request: any())
        verify(mockDataSource).getMovieDetail(request: any())
        verify(mockDataSource).getMovieTrailer(request: any())

        wait(for: [expected], timeout: 10)
    }
}
