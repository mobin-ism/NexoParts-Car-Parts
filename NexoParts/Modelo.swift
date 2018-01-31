//
//  Modelo.swift
//  NexoParts
//
//  Created by Creativeitem on 6/18/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import Foundation
class Modelo: NSObject {
    
    private var _idModel: String
    private var _nombreModelo: String
    
    var idModel: String {
        get {
            return _idModel
        }
    }
    
    var nombreModelo: String {
        get {
            return _nombreModelo
        }
    }
    
    init(idModel: String, nombreModelo: String) {
        self._idModel = idModel
        self._nombreModelo = nombreModelo
    }
}
