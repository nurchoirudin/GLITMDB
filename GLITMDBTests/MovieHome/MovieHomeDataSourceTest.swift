//
//  MovieHomeDataSourceTest.swift
//  GLITMDBTests
//
//  Created by Nur Choirudin on 15/02/23.
//

import Foundation
@testable import GLITMDB
import XCTest
import RxSwift
import Cuckoo

class MovieHomeDataSourceTest: XCTestCase {
    let mockDataSource = MockMovieHomeDataSource()
    let disposeBag = DisposeBag()
    let delay: TimeInterval = 5
    
    let expectedMovieListModel = DummyMovieListModel().getMovieListModel()
    
    func testDiscoverMovie(){
        let expected = expectation(description: "Observer Passed")

        stub(mockDataSource) { stub in
            when(stub).discoverMovie(request: any()).thenReturn(Observable.just(expectedMovieListModel))
        }

        mockDataSource.discoverMovie(request: MovieHomeRequest(page: 1)).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)

        wait(for: [expected], timeout: delay)
    }
    
    func testDiscoverMovieError(){
        let expected = expectation(description: "Observer Passed")

        stub(mockDataSource) { stub in
            when(stub).discoverMovie(request: any()).thenReturn(Observable.error(MockError.errorLoadData))
        }
        
        mockDataSource.discoverMovie(request: MovieHomeRequest(page: 1)).subscribe(
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
    
    func testSearchMovie(){
        let expected = expectation(description: "Observer Passed")

        stub(mockDataSource) { stub in
            when(stub).searchMovie(request: any()).thenReturn(Observable.just(expectedMovieListModel))
        }

        mockDataSource.searchMovie(request: MovieHomeSearchRequest(page: 0, query: "")).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)

        wait(for: [expected], timeout: delay)
    }
    
    func testSearchMovieError(){
        let expected = expectation(description: "Observer Passed")

        stub(mockDataSource) { stub in
            when(stub).searchMovie(request: any()).thenReturn(Observable.error(MockError.errorLoadData))
        }
        
        mockDataSource.searchMovie(request: MovieHomeSearchRequest(page: 1)).subscribe(
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
