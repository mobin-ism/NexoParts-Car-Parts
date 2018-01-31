//
//  OffertaArticulosModel.swift
//  NexoParts
//
//  Created by Creativeitem on 8/3/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import Foundation

class OffertaArticulosModel: NSObject {
    
    private var _marca: String
    private var _state: String
    private var _year: String
    private var _atriculosTitle: String
    private var _chasisNumber: String
    private var _idDetalle: String
    private var _articleImage: String
    
    var marca: String {
        get {
            return _marca
        }
    }
    var state: String {
        get {
            return _state
        }
    }
    var year: String {
        get {
            return _year
        }
    }
    var atriculosTitle: String {
        get {
            return _atriculosTitle
        }
    }
    var chasisNumber: String {
        get {
            return _chasisNumber
        }
    }
    var idDetalle: String {
        get {
            return _idDetalle
        }
    }
    var articleImage: String {
        get {
            return _articleImage
        }
    }
    
    init(marca: String, state: String, year: String, articulosTitle: String, chasisNumber: String, idDetalle: String, articleImage: String) {
        self._marca     = marca
        self._state       = state
        self._year             = year
        self._atriculosTitle   = articulosTitle
        self._chasisNumber = chasisNumber
        self._idDetalle = idDetalle
        self._articleImage = articleImage
    }
}

