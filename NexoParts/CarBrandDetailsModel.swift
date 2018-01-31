//
//  CarBrandDetailsModel.swift
//  NexoParts
//
//  Created by Creativeitem on 7/4/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import Foundation
class CarBrandDetailsModel: NSObject {
    
    private var _modelTitle: String
    private var _modelYear: String
    private var _version: String
    private var _modelStatus: String
    private var _carImage: String
    
    var modelTitle: String {
        get {
            return _modelTitle
        }
    }
    var modelYear: String {
        get {
            return _modelYear
        }
    }
    var version: String {
        get {
            return _version
        }
    }
    var modelStatus: String {
        get {
            return _modelStatus
        }
    }
    var carImage: String {
        get {
            return _carImage
        }
    }
    
    init(modelTitle: String, modelYear: String, version: String, modelStatus: String, carImage: String) {
        self._modelTitle  = modelTitle
        self._modelYear   = modelYear
        self._version     = version
        self._modelStatus = modelStatus
        self._carImage    = carImage
    }
    
}

