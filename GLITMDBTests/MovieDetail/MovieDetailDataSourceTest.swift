//
//  MovieDetailDataSourceTest.swift
//  GLITMDBTests
//
//  Created by Nur Choirudin on 15/02/23.
//

import Foundation
@testable import GLITMDB
import XCTest
import RxSwift
import Cuckoo

class MovieDetailDataSourceTest: XCTestCase {
    let mockDataSource = MockMovieDetailDataSource()
    let disposeBag = DisposeBag()
    let delay: TimeInterval = 5
    
    let expectedMovieDetailModel = DummyMovieDetailModel().getMovieDetailModel()
    let expectedMovieTrailerModel = DummyMovieDetailModel().getMovieTrailerModel()
    let expectedMovieCastModel = DummyMovieDetailModel().getMovieCastModel()
    let expectedMovieReviewModel = DummyMovieDetailModel().getMovieReviewModel()
    
    func testGetMovieDetail(){
        let expected = expectation(description: "Observer Passed")

        stub(mockDataSource) { stub in
            when(stub).getMovieDetail(request: any()).thenReturn(Observable.just(expectedMovieDetailModel))
        }

        mockDataSource.getMovieDetail(request: MovieDetailRequest(movieId: 0)).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)

        wait(for: [expected], timeout: delay)
    }
    
    
    func testGetMovieDetailError(){
        let expected = expectation(description: "Observer Passed")
        
        stub(mockDataSource) { stub in
            when(stub).getMovieDetail(request: any()).thenReturn(Observable.error(MockError.errorLoadData))
        }
        
        mockDataSource.getMovieDetail(request: MovieDetailRequest(movieId: 0)).subscribe(
            onNext: { response in
                XCTFail("Should not return success")
                expected.fulfill()
            }, onError: { error in
                expected.fulfill()
                if let mockError = error as? MockError {
                    XCTAssertEqual(MockError.errorLoadData, mockError)
                } else {
                    XCTFail(error.localizedDescription)
                }
                
            }).disposed(by: disposeBag)
        
        wait(for: [expected], timeout: delay)
    }
    
    func testGetMovieTrailer(){
        let expected = expectation(description: "Observer Passed")
        stub(mockDataSource) { stub in
            when(stub).getMovieTrailer(request: any()).thenReturn(Observable.just(expectedMovieTrailerModel))
        }
        mockDataSource.getMovieTrailer(request: MovieTrailerRequest(movieId: 0)).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expected], timeout: delay)
    }
    
    
    func testGetMovieTrailerError(){
        let expected = expectation(description: "Observer Passed")
        stub(mockDataSource) { stub in
            when(stub).getMovieTrailer(request: any()).thenReturn(Observable.error(MockError.errorLoadData))
        }
        mockDataSource.getMovieTrailer(request: MovieTrailerRequest(movieId: 0)).subscribe(
            onNext: { response in
                XCTFail("Should not return success")
                expected.fulfill()
            }, onError: { error in
                expected.fulfill()
                if let mockError = error as? MockError {
                    XCTAssertEqual(MockError.errorLoadData, mockError)
                } else {
                    XCTFail(error.localizedDescription)
                }
                
            }).disposed(by: disposeBag)
        
        wait(for: [expected], timeout: delay)
    }
    
    func testGetMovieReview(){
        let expected = expectation(description: "Observer Passed")
        stub(mockDataSource) { stub in
            when(stub).getMovieReview(request: any()).thenReturn(Observable.just(expectedMovieReviewModel))
        }
        mockDataSource.getMovieReview(request: MovieReviewRequest(movieId: 0)).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expected], timeout: delay)
    }
    
    
    func testGetMovieReviewError(){
        let expected = expectation(description: "Observer Passed")
        stub(mockDataSource) { stub in
            when(stub).getMovieReview(request: any()).thenReturn(Observable.error(MockError.errorLoadData))
        }
        mockDataSource.getMovieReview(request: MovieReviewRequest(movieId: 0)).subscribe(
            onNext: { response in
                XCTFail("Should not return success")
                expected.fulfill()
            }, onError: { error in
                expected.fulfill()
                if let mockError = error as? MockError {
                    XCTAssertEqual(MockError.errorLoadData, mockError)
                } else {
                    XCTFail(error.localizedDescription)
                }
                
            }).disposed(by: disposeBag)
        
        wait(for: [expected], timeout: delay)
    }
    
    func testGetMovieCast(){
        let expected = expectation(description: "Observer Passed")
        stub(mockDataSource) { stub in
            when(stub).getMovieCast(request: any()).thenReturn(Observable.just(expectedMovieCastModel))
        }
        mockDataSource.getMovieCast(request: MovieCastRequest(movieId: 0)).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expected], timeout: delay)
    }
    
    
    func testGetMovieCastError(){
        let expected = expectation(description: "Observer Passed")
        stub(mockDataSource) { stub in
            when(stub).getMovieCast(request: any()).thenReturn(Observable.error(MockError.errorLoadData))
        }
        mockDataSource.getMovieCast(request: MovieCastRequest(movieId: 0)).subscribe(
            onNext: { response in
                XCTFail("Should not return success")
                expected.fulfill()
            }, onError: { error in
                expected.fulfill()
                if let mockError = error as? MockError {
                    XCTAssertEqual(MockError.errorLoadData, mockError)
                } else {
                    XCTFail(error.localizedDescription)
                }
                
            }).disposed(by: disposeBag)
        
        wait(for: [expected], timeout: delay)
    }
}
