//
//  ViewControllerAssembly.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 13/02/23.
//

import Foundation
import Swinject

class ViewControllerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MovieHomeVC.self) { _ in
            let vc = MovieHomeVC()
            return vc
        }

        container.register(MovieDetailVC.self){ (_: Resolver, movieId: Int?) in
            let vc = MovieDetailVC(movieId: movieId)
            return vc
        }
    }
}
