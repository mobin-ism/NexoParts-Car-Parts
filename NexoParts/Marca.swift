//
//  Marca.swift
//  NexoParts
//
//  Created by Creativeitem on 6/12/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import Foundation

class Marca: NSObject {
    
    private var _idMarca: String
    private var _nombreMarca: String
    
    var idMarca: String {
        get {
            return _idMarca
        }
    }
    
    var nombreMarca: String {
        get {
            return _nombreMarca
        }
    }
    
    init(idMarca: String, nombreMarca: String) {
        self._idMarca = idMarca
        self._nombreMarca = nombreMarca
    }
}
