//
//  Estado.swift
//  NexoParts
//
//  Created by Creativeitem on 6/12/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import Foundation

class Estado: NSObject {
    
    private var _idEstado: String
    private var _detalle: String
    
    var idEstado: String {
        get {
            return _idEstado
        }
    }
    
    var detalle: String {
        get {
            return _detalle
        }
    }
    
    init(idEstado: String, detalle: String) {
        self._idEstado = idEstado
        self._detalle = detalle
    }
}

class Provincia: NSObject {
    
    private var _idProvincia: String
    private var _detalle: String
    
    var idProvincia: String {
        get {
            return _idProvincia
        }
    }
    
    var detalle: String {
        get {
            return _detalle
        }
    }
    
    init(idProvincia: String, detalle: String) {
        self._idProvincia = idProvincia
        self._detalle = detalle
    }
}

class ProvinciaForRegister: NSObject {
    
    private var _idProvincia: String
    private var _detalle: String
    
    var idProvincia: String {
        get {
            return _idProvincia
        }
    }
    
    var detalle: String {
        get {
            return _detalle
        }
    }
    
    init(idProvincia: String, detalle: String) {
        self._idProvincia = idProvincia
        self._detalle = detalle
    }
}
class Ubicacion: NSObject {
    private var _idUbicacion: String
    private var _detalle: String
    
    var idUbicacion: String {
        get {
            return _idUbicacion
        }
    }
    var detalle: String {
        get {
            return _detalle
        }
    }
    init(idUbicacion: String, detalle: String) {
        self._idUbicacion = idUbicacion
        self._detalle = detalle
    }
}

class TiempoDeEntrega: NSObject {
    private var _idTiempoDeEntrega: String
    private var _title: String
    
    var idTiempoDeEntrega: String {
        get {
            return _idTiempoDeEntrega
        }
    }
    var detalle: String {
        get {
            return _title
        }
    }
    init(idTiempoDeEntrega: String, title: String) {
        self._idTiempoDeEntrega = idTiempoDeEntrega
        self._title = title
    }
}

class Garantia: NSObject {
    private var _idGranatia: String
    private var _nombre: String
    
    var idGranatia: String {
        get {
            return _idGranatia
        }
    }
    var nombre: String {
        get {
            return _nombre
        }
    }
    init(idGranatia: String, nombre: String) {
        self._idGranatia = idGranatia
        self._nombre = nombre
    }
}

class Pieza: NSObject {
    private var _idPieza: String
    private var _nombre: String
    
    var idPieza: String {
        get {
            return _idPieza
        }
    }
    var nombre: String {
        get {
            return _nombre
        }
    }
    init(idPieza: String, nombre: String) {
        self._idPieza = idPieza
        self._nombre = nombre
    }
}

class userRole: NSObject {
    
    private var _idUser: String
    private var _userType: String
    
    var idUser: String {
        get {
            return _idUser
        }
    }
    
    var userType: String {
        get {
            return _userType
        }
    }
    
    init(idUser: String, userType: String) {
        self._idUser = idUser
        self._userType = userType
    }
}

class PriceRange: NSObject {
    private var _idPriceRange: String
    private var _range: String
    
    var idPriceRange: String {
        get {
            return _idPriceRange
        }
    }
    var range: String {
        get {
            return _range
        }
    }
    init(idPriceRange: String, range: String) {
        self._idPriceRange = idPriceRange
        self._range = range
    }
}
class PriceRange2: NSObject {
    private var _idPriceRange: String
    private var _range: String
    
    var idPriceRange: String {
        get {
            return _idPriceRange
        }
    }
    var range: String {
        get {
            return _range
        }
    }
    init(idPriceRange: String, range: String) {
        self._idPriceRange = idPriceRange
        self._range = range
    }
}

class EligeUnTransporte: NSObject {
    private var _transporteName: String
    private var _transporteID: String
    
    var transporteName: String {
        get {
            return _transporteName
        }
    }
    var transporteID: String {
        get {
            return _transporteID
        }
    }
    init(transporteName: String, transporteID: String) {
        self._transporteName = transporteName
        self._transporteID = transporteID
    }
}
class PaymentMethod: NSObject {
    private var _paymentMethodName: String
    
    var paymentMethodName: String {
        get {
            return _paymentMethodName
        }
    }
    init(paymentMethodName: String) {
        self._paymentMethodName = paymentMethodName
    }
}

class YearModel : NSObject {
    private var _year: Int
    
    var year: Int {
        get {
            return _year
        }
    }
    init(year: Int) {
        self._year = year
    }
}
class MonthModel : NSObject {
    private var _month: Int
    
    var month: Int {
        get {
            return _month
        }
    }
    init(month: Int) {
        self._month = month
    }
}
