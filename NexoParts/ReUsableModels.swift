//
//  NumberOfModels.swift
//  NexoParts
//
//  Created by Creativeitem on 6/20/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import Foundation
    class NumberOfModels {
        private var _idMarca: String
        private var _nombreMarca: String
        private var _numberOfModels: String
        
        var idMarca: String{
            get {
                return _idMarca
            }
        }
        
        var nombreMarca: String{
            get {
                return _nombreMarca
            }
        }

        var numberOfModels: String {
            get {
                return _numberOfModels
            }
        }
        
        init(idMarca: String, nombreMarca: String, numberOfModels: String) {
            self._idMarca = idMarca
            self._nombreMarca = nombreMarca
            self._numberOfModels = numberOfModels
        }
}

 class OffertaModel: NSObject {
    
    private var _offerID: String
    private var _adminName: String
    private var _price: String
    
    var offerID: String {
        get {
            return _offerID
        }
    }
    var adminName: String {
        get {
            return _adminName
        }
    }
    var price: String {
        get {
            return _price
        }
    }
    
    init(offerID: String, adminName: String, price: String) {
        self._offerID   = offerID
        self._adminName = adminName
        self._price      = price
    }
}
class selectOfferModel: NSObject {
    
    private var _carName: String
    private var _offerStatus: String
    private var _offerEstado: String
    private var _offerPieza: String
    private var _offerGarantia: String
    private var _offerPrice: String
    private var _articleTitle: String
    private var _cantidad: String
    private var _comentario: String
    private var _tiempoDeEntrega: String
    private var _articleImage: String
    private var _offerImageOne: String
    private var _offerImageTwo: String
    
    var carName: String {
        get {
            return _carName
        }
    }
    var offerStatus: String {
        get {
            return _offerStatus
        }
    }
    var offerEstado: String {
        get {
            return _offerEstado
        }
    }
    var offerPieza: String {
        get {
            return _offerPieza
        }
    }
    var offerGarantia: String {
        get {
            return _offerGarantia
        }
    }
    var offerPrice: String {
        get {
            return _offerPrice
        }
    }
    var articleTitle: String {
        get {
            return _articleTitle
        }
    }
    var cantidad: String {
        get {
            return _cantidad
        }
    }
    var comentario: String {
        get {
            return _comentario
        }
    }
    var tiempoDeEntrega: String {
        get {
            return _tiempoDeEntrega
        }
    }
    var articleImage: String {
        get {
            return _articleImage
        }
    }
    var offerImageOne: String {
        get {
            return _offerImageOne
        }
    }
    var offerImageTwo: String {
        get {
            return _offerImageTwo
        }
    }
    init(carName: String, offerStatus: String, offerPrice: String, offerEstado : String, offerPieza : String, offerGarantia : String, articleTitle : String, cantidad : String, comentario: String, tiempoDeEntrega: String, articleImage: String, offerImageOne: String, offerImageTwo: String) {
        self._carName     = carName
        self._offerStatus = offerStatus
        self._offerEstado = offerEstado
        self._offerPieza = offerPieza
        self._offerGarantia = offerGarantia
        self._offerPrice  = offerPrice
        self._articleTitle = articleTitle
        self._cantidad = cantidad
        self._comentario = comentario
        self._tiempoDeEntrega = tiempoDeEntrega
        self._articleImage = articleImage
        self._offerImageOne = offerImageOne
        self._offerImageTwo = offerImageTwo
    }
}

class ArticleModel : NSObject{
    private var _redNumber : String
    private var _detalleID : String
    private var _marca : String
    private var _modelo : String
    private var _year : String
    private var _article : String
    private var _chasis : String
    private var _valor : String
    
    var redNumber: String {
        get {
            return _redNumber
        }
    }
    var detalleID: String {
        get {
            return _detalleID
        }
    }
    var marca: String {
        get {
            return _marca
        }
    }
    var modelo: String {
        get {
            return _modelo
        }
    }
    var year: String {
        get {
            return _year
        }
    }
    var article: String {
        get {
            return _article
        }
    }
    var chasis: String {
        get {
            return _chasis
        }
    }
    var valor: String {
        get {
            return _valor
        }
    }
    init(redNumber: String, detalleID: String, marca: String, modelo: String, year:String, article: String, chasis:String, valor: String) {
        self._redNumber = redNumber
        self._detalleID = detalleID
        self._marca = marca
        self._modelo = modelo
        self._year = year
        self._article = article
        self._chasis = chasis
        self._valor = valor
    }
}

class DetailsAboutAnArticle: NSObject {
    
    private var _marca: String
    private var _modelo: String
    private var _details: String
    private var _year: String
    private var _atriculosTitle: String
    private var _chasisNumber: String
    private var _cantidad: String
    
    var marca: String {
        get {
            return _marca
        }
    }
    var modelo: String {
        get {
            return _modelo
        }
    }
    var details: String {
        get {
            return _details
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
    var cantidad: String {
        get {
            return _cantidad
        }
    }
    
    init(marca: String, details: String, year: String, articulosTitle: String, chasisNumber: String, modelo : String, cantidad : String) {
        self._marca     = marca
        self._modelo     = modelo
        self._details       = details
        self._year             = year
        self._atriculosTitle   = articulosTitle
        self._chasisNumber = chasisNumber
        self._cantidad = cantidad
    }
}

class ArticleWiseOfferModel: NSObject {
    private var _articleTitle: String
    private var _cantidad: String
    private var _price: String
    private var _detalle_id: String
    
    var articleTitle: String {
        get {
            return _articleTitle
        }
    }
    var cantidad: String {
        get {
            return _cantidad
        }
    }
    var price: String {
        get {
            return _price
        }
    }
    var detalle_id: String {
        get {
            return _detalle_id
        }
    }
    
    init(articleTitle: String, cantidad: String, price: String, detalle_id: String) {
        self._articleTitle = articleTitle
        self._cantidad     = cantidad
        self._price        = price
        self._detalle_id   = detalle_id
    }
}

