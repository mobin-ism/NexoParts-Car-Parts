//
//  ResumenDeComprarModel.swift
//  NexoParts
//
//  Created by Creativeitem on 8/2/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import Foundation
class ResumenDeComprarModel: NSObject {
    
    private var _offerId : String
    private var _marca: String
    private var _model: String
    private var _year: String
    private var _atricleTitle: String
    private var _status: String
    private var _valor: String
    
    var offerId : String{
        get{
            return _offerId
        }
    }
    var marca: String {
        get {
            return _marca
        }
    }
    var model: String {
        get {
            return _model
        }
    }
    var year: String {
        get {
            return _year
        }
    }
    var atricleTitle: String {
        get {
            return _atricleTitle
        }
    }
    var status: String {
        get {
            return _status
        }
    }
    var valor: String {
        get {
            return _valor
        }
    }
    
    init(offerId: String, marca: String, model: String, year: String, atricleTitle: String, status: String, valor: String) {
        self._offerId = offerId
        self._marca     = marca
        self._model       = model
        self._year             = year
        self._atricleTitle   = atricleTitle
        self._status = status
        self._valor = valor
    }
}
