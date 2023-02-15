//
//  Assembler.swift
//  GLITMDB
//
//  Created by SehatQ on 13/02/23.
//

import Foundation
import Swinject

extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler([
//            LoginAssembly(),
        ], container: container)
        return assembler
    }()
    
}
