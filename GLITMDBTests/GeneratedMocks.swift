import Cuckoo
@testable import GLITMDB

import Foundation
import RxSwift


 class MockMovieDetailDataSource: MovieDetailDataSource, Cuckoo.ProtocolMock {
    
     typealias MocksType = MovieDetailDataSource
    
     typealias Stubbing = __StubbingProxy_MovieDetailDataSource
     typealias Verification = __VerificationProxy_MovieDetailDataSource

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: MovieDetailDataSource?

     func enableDefaultImplementation(_ stub: MovieDetailDataSource) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailModel?> {
        
    return cuckoo_manager.call("getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieDetail(request: request))
        
    }
    
    
    
     func getMovieTrailer(request: MovieTrailerRequest) -> Observable<MovieTrailerModel?> {
        
    return cuckoo_manager.call("getMovieTrailer(request: MovieTrailerRequest) -> Observable<MovieTrailerModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieTrailer(request: request))
        
    }
    
    
    
     func getMovieCast(request: MovieCastRequest) -> Observable<MovieCastModel?> {
        
    return cuckoo_manager.call("getMovieCast(request: MovieCastRequest) -> Observable<MovieCastModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieCast(request: request))
        
    }
    
    
    
     func getMovieReview(request: MovieReviewRequest) -> Observable<MovieReviewModel?> {
        
    return cuckoo_manager.call("getMovieReview(request: MovieReviewRequest) -> Observable<MovieReviewModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieReview(request: request))
        
    }
    

	 struct __StubbingProxy_MovieDetailDataSource: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getMovieDetail<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieDetailRequest), Observable<MovieDetailModel?>> where M1.MatchedType == MovieDetailRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetailRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovieDetailDataSource.self, method: "getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailModel?>", parameterMatchers: matchers))
	    }
	    
	    func getMovieTrailer<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieTrailerRequest), Observable<MovieTrailerModel?>> where M1.MatchedType == MovieTrailerRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieTrailerRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovieDetailDataSource.self, method: "getMovieTrailer(request: MovieTrailerRequest) -> Observable<MovieTrailerModel?>", parameterMatchers: matchers))
	    }
	    
	    func getMovieCast<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieCastRequest), Observable<MovieCastModel?>> where M1.MatchedType == MovieCastRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieCastRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovieDetailDataSource.self, method: "getMovieCast(request: MovieCastRequest) -> Observable<MovieCastModel?>", parameterMatchers: matchers))
	    }
	    
	    func getMovieReview<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieReviewRequest), Observable<MovieReviewModel?>> where M1.MatchedType == MovieReviewRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieReviewRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovieDetailDataSource.self, method: "getMovieReview(request: MovieReviewRequest) -> Observable<MovieReviewModel?>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_MovieDetailDataSource: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getMovieDetail<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieDetailRequest), Observable<MovieDetailModel?>> where M1.MatchedType == MovieDetailRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetailRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieTrailer<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieTrailerRequest), Observable<MovieTrailerModel?>> where M1.MatchedType == MovieTrailerRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieTrailerRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("getMovieTrailer(request: MovieTrailerRequest) -> Observable<MovieTrailerModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieCast<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieCastRequest), Observable<MovieCastModel?>> where M1.MatchedType == MovieCastRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieCastRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("getMovieCast(request: MovieCastRequest) -> Observable<MovieCastModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieReview<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieReviewRequest), Observable<MovieReviewModel?>> where M1.MatchedType == MovieReviewRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieReviewRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("getMovieReview(request: MovieReviewRequest) -> Observable<MovieReviewModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MovieDetailDataSourceStub: MovieDetailDataSource {
    

    

    
    
    
     func getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieDetailModel?>).self)
    }
    
    
    
     func getMovieTrailer(request: MovieTrailerRequest) -> Observable<MovieTrailerModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieTrailerModel?>).self)
    }
    
    
    
     func getMovieCast(request: MovieCastRequest) -> Observable<MovieCastModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieCastModel?>).self)
    }
    
    
    
     func getMovieReview(request: MovieReviewRequest) -> Observable<MovieReviewModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieReviewModel?>).self)
    }
    
}


import Cuckoo
@testable import GLITMDB

import Foundation
import RxSwift


 class MockMovieHomeDataSource: MovieHomeDataSource, Cuckoo.ProtocolMock {
    
     typealias MocksType = MovieHomeDataSource
    
     typealias Stubbing = __StubbingProxy_MovieHomeDataSource
     typealias Verification = __VerificationProxy_MovieHomeDataSource

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: MovieHomeDataSource?

     func enableDefaultImplementation(_ stub: MovieHomeDataSource) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func discoverMovie(request: MovieHomeRequest) -> Observable<MovieListModel?> {
        
    return cuckoo_manager.call("discoverMovie(request: MovieHomeRequest) -> Observable<MovieListModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.discoverMovie(request: request))
        
    }
    
    
    
     func searchMovie(request: MovieHomeSearchRequest) -> Observable<MovieListModel?> {
        
    return cuckoo_manager.call("searchMovie(request: MovieHomeSearchRequest) -> Observable<MovieListModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.searchMovie(request: request))
        
    }
    

	 struct __StubbingProxy_MovieHomeDataSource: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func discoverMovie<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieHomeRequest), Observable<MovieListModel?>> where M1.MatchedType == MovieHomeRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieHomeRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovieHomeDataSource.self, method: "discoverMovie(request: MovieHomeRequest) -> Observable<MovieListModel?>", parameterMatchers: matchers))
	    }
	    
	    func searchMovie<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieHomeSearchRequest), Observable<MovieListModel?>> where M1.MatchedType == MovieHomeSearchRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieHomeSearchRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovieHomeDataSource.self, method: "searchMovie(request: MovieHomeSearchRequest) -> Observable<MovieListModel?>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_MovieHomeDataSource: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func discoverMovie<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieHomeRequest), Observable<MovieListModel?>> where M1.MatchedType == MovieHomeRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieHomeRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("discoverMovie(request: MovieHomeRequest) -> Observable<MovieListModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func searchMovie<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieHomeSearchRequest), Observable<MovieListModel?>> where M1.MatchedType == MovieHomeSearchRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieHomeSearchRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("searchMovie(request: MovieHomeSearchRequest) -> Observable<MovieListModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MovieHomeDataSourceStub: MovieHomeDataSource {
    

    

    
    
    
     func discoverMovie(request: MovieHomeRequest) -> Observable<MovieListModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieListModel?>).self)
    }
    
    
    
     func searchMovie(request: MovieHomeSearchRequest) -> Observable<MovieListModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieListModel?>).self)
    }
    
}

