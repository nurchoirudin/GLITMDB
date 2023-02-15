//
//  Assembler.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 13/02/23.
//

import Foundation
import Swinject

extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler([
            ViewControllerAssembly(),
            MovieHomeAssembly(),
            MovieDetailAssembly()
        ], container: container)
        return assembler
    }()
    
}
