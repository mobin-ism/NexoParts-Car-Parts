//
//  ListaDeComprasModel.swift
//  NexoParts
//
//  Created by Creativeitem on 8/1/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import Foundation

class ListaDeComprasModel: NSObject {
    
    private var _number: String
    private var _clientName: String
    private var _date: String
    private var _atricleTitle: String
    private var _status: String
    private var _totalBill: String
    
    var number: String {
        get {
            return _number
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
    var totalBill: String {
        get {
            return _totalBill
        }
    }
    
    init(number: String, clientName: String, date: String, atricleTitle: String, status: String, totalBill: String) {
        self._number     = number
        self._clientName       = clientName
        self._date             = date
        self._atricleTitle   = atricleTitle
        self._status = status
        self._totalBill = totalBill
    }
}
