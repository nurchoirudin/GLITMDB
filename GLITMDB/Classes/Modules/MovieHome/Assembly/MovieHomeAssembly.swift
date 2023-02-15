//
//  MovieHomeAssembly.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 13/02/23.
//

import Foundation
import Swinject

class MovieHomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkProtocol.self) { r in
            return NetworkProvider()
        }
        
        container.register(MovieHomeDataSource.self) { r in
            guard let dataProvider = r.resolve(NetworkProtocol.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return MovieHomeRepository(remoteData: dataProvider)
        }
        
        container.register(MovieHomeViewModel.self) { r in
            guard let dataSource = r.resolve(MovieHomeDataSource.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return MovieHomeViewModel(dataSource: dataSource)
        }
    }
}
