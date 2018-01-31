//
//  Cotizacion.swift
//  NexoParts
//
//  Created by Creativeitem on 6/16/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import Foundation

class Cotizacion: NSObject {
    
    private var _idCotizacion: String
    private var _clientName: String
    private var _date: String
    private var _atriculosTitle: String
    private var _statusCotizacion: String
    
    var idCotizacion: String {
        get {
            return _idCotizacion
        }
    }
    var clientName: String {
        get {
            return _clientName
        }
    }
    var date: String {
        get {
            return _date
        }
    }
    var atriculosTitle: String {
        get {
            return _atriculosTitle
        }
    }
    var statusCotizacion: String {
        get {
            return _statusCotizacion
        }
    }

    init(idCotizacion: String, clientName: String, date: String, articulosTitle: String, statusCotizacion: String) {
        self._idCotizacion     = idCotizacion
        self._clientName       = clientName
        self._date             = date
        self._atriculosTitle   = articulosTitle
        self._statusCotizacion = statusCotizacion
    }
}
