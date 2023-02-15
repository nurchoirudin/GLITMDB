//
//  MovieDetailAssembly.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import Foundation
import Swinject

class MovieDetailAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkProtocol.self) { r in
            return NetworkProvider()
        }
        
        container.register(MovieDetailDataSource.self) { r in
            guard let dataProvider = r.resolve(NetworkProtocol.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return MovieDetailRepository(remoteData: dataProvider)
        }
        
        container.register(MovieDetailViewModel.self) { r in
            guard let dataSource = r.resolve(MovieDetailDataSource.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return MovieDetailViewModel(dataSource: dataSource)
        }
    }
}
