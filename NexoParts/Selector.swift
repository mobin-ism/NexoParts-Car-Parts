//
//  Selector.swift
//  NexoParts
//
//  Created by Creativeitem on 6/7/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit

class Selector: NSObject {
    
    var selectorData = [NSObject]()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        view.alpha = 0
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.white
        table.allowsMultipleSelection = false
        table.clipsToBounds = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    let cellId = "selectorCell"
    var cotizacionesVC = CotizacionesViewController()
    var companyHomeVC  = CompanyHomeViewController()
    var editarDatosVC  = EditarDatosViewController()
    var registrationVC = RegisterViewController()
    var addOfferFormVC = AddOfferFormViewController()
    var listaDeAutoVC  = ListaDeAutos()
    var carBrandDetailsVC = CarBrandDetailsViewController()
    var datosDeEnvioVC = DatosDeEnvioViewController()
    var finalizarCompraVC = FinalizarCompraViewController()
    
    override init() {
        super.init()
        tableView.register(SelectorCell.self, forCellReuseIdentifier: cellId)
    }
    
    func show(withData tableData: [NSObject]) {
        selectorData = tableData
        setupSubViews()
        tableView.reloadData()
    }
    func setupSubViews() {
        // adding the background view
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 1
            })
            // constraints
            backgroundView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
            backgroundView.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
            backgroundView.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
            backgroundView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
            
            // adding the container view
            setupContainerView(window: window)
        }
    }
    
    func setupContainerView(window: UIWindow) {
        window.addSubview(containerView)
        let height = window.frame.height * 0.4
        let y = window.frame.height - height
        containerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        setupTableView()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.containerView.frame = CGRect(x: 0, y: y, width: self.containerView.frame.width, height: self.containerView.frame.height)
        }, completion: nil)
    }
    
    func setupTableView() {
        containerView.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
    }
    
    func hide() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
    
}

extension Selector: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectorData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SelectorCell {
            if let data = selectorData as? [Estado] {
                cell.titleText = "\(data[indexPath.row].detalle)"
            }
            if let data = selectorData as? [Provincia] {
                cell.titleText = "\(data[indexPath.row].detalle)"
            }
            if let data = selectorData as? [ProvinciaForRegister] {
                cell.titleText = "\(data[indexPath.row].detalle)"
            }
            if let data = selectorData as? [userRole] {
                cell.titleText = "\(data[indexPath.row].userType)"
            }
            if let data = selectorData as? [Ubicacion] {
                cell.titleText = "\(data[indexPath.row].detalle)"
            }
            if let data = selectorData as? [Garantia] {
                cell.titleText = "\(data[indexPath.row].nombre)"
            }
            if let data = selectorData as? [TiempoDeEntrega] {
                cell.titleText = "\(data[indexPath.row].detalle)"
            }
            if let data = selectorData as? [Pieza] {
                cell.titleText = "\(data[indexPath.row].nombre)"
            }
            if let data = selectorData as? [PriceRange2] {
                cell.titleText = "\(data[indexPath.row].range)"
            }
            if let data = selectorData as? [PriceRange] {
                cell.titleText = "\(data[indexPath.row].range)"
            }
            if let data = selectorData as? [EligeUnTransporte] {
                cell.titleText = "\(data[indexPath.row].transporteName)"
            }
            if let data = selectorData as? [PaymentMethod] {
                cell.titleText = "\(data[indexPath.row].paymentMethodName)"
            }
            if let data = selectorData as? [YearModel] {
                cell.titleText = "\(data[indexPath.row].year)"
            }
            if let data = selectorData as? [MonthModel] {
                cell.titleText = "\(data[indexPath.row].month)"
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hide()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            if let data = self.selectorData as? [Estado] {
                if(UserDefaults.standard.value(forKey: USER_ROLE) as! String == "1" || UserDefaults.standard.value(forKey: USER_ROLE) as! String == "2"){
                    self.companyHomeVC.changeSelectorTitle(withString: "\(data[indexPath.row].detalle)    ▼")
                    self.companyHomeVC.idEstado = data[indexPath.row].idEstado
                    self.companyHomeVC.getEstadoId()
                    
                    self.addOfferFormVC.changeStateSelectorTitle(withString: "\(data[indexPath.row].detalle) ▼")
                    self.addOfferFormVC.idEstado = data[indexPath.row].idEstado
                }
                if(UserDefaults.standard.value(forKey: USER_ROLE) as! String == "3"){
                    self.cotizacionesVC.changeSelectorTitle(withString: "\(data[indexPath.row].detalle)    ▼")
                    self.cotizacionesVC.idEstado = data[indexPath.row].idEstado
                    self.cotizacionesVC.getEstadoId()
                }
            }
            if let data = self.selectorData as? [Provincia] {
                self.editarDatosVC.changeSelectorTitle(withString: "\(data[indexPath.row].detalle)    ▼")
                self.editarDatosVC.idProvincia = data[indexPath.row].idProvincia
            }
            if let data = self.selectorData as? [ProvinciaForRegister] {
                self.registrationVC.changeSelectorTitle(withString: "\(data[indexPath.row].detalle)    ▼")
                self.registrationVC.idProvincia = data[indexPath.row].idProvincia
            }
            
            if let data = self.selectorData as? [Ubicacion] {
                self.addOfferFormVC.changeUbicacionSelectorTitle(withString: "\(data[indexPath.row].detalle)    ▼")
                self.addOfferFormVC.idUbicacion = data[indexPath.row].idUbicacion
            }
            
            if let data = self.selectorData as? [TiempoDeEntrega] {
                self.addOfferFormVC.changeTiempoDeEntregaSelectorTitle(withString: "\(data[indexPath.row].detalle)    ▼")
                self.addOfferFormVC.idTiempoDeEntrega = data[indexPath.row].idTiempoDeEntrega
            }
            if let data = self.selectorData as? [Garantia] {
                self.addOfferFormVC.changeGarantiaSelectorTitle(withString: "\(data[indexPath.row].nombre)    ▼")
                self.addOfferFormVC.idGranatia = data[indexPath.row].idGranatia
            }
            if let data = self.selectorData as? [Pieza] {
                self.addOfferFormVC.changePiezaSelectorTitle(withString: "\(data[indexPath.row].nombre)    ▼")
                self.addOfferFormVC.idPieza = data[indexPath.row].idPieza
            }
            
            if let data = self.selectorData as? [userRole] {
                self.registrationVC.changeSelectorTitleForUserRole(withString: "\(data[indexPath.row].userType)    ▼")
                self.registrationVC.idUser = data[indexPath.row].idUser
            }
            if let data = self.selectorData as? [PriceRange2] {
                self.listaDeAutoVC.idPriceRange = data[indexPath.row].idPriceRange
                self.listaDeAutoVC.changeSelectorTitle(withString: "\(data[indexPath.row].range)    ▼")
            }
            if let data = self.selectorData as? [PriceRange] {
                self.carBrandDetailsVC.selectedPriceRangeId = data[indexPath.row].idPriceRange
                self.carBrandDetailsVC.changeSelectorTitle(withString: "\(data[indexPath.row].range) ▼")
                self.carBrandDetailsVC.getAllModelsByPriceRange()
            }
            if let data = self.selectorData as? [EligeUnTransporte] {
                self.datosDeEnvioVC.changeSelectorTitleForTransport(withString: "\(data[indexPath.row].transporteName) ▼")
                self.datosDeEnvioVC.transportID = data[indexPath.row].transporteID
            }
            if let data = self.selectorData as? [PaymentMethod] {
                self.finalizarCompraVC.changeSelectorTitleForPaymentMethod(withString: "\(data[indexPath.row].paymentMethodName) ▼")
                if indexPath.row == 2{
                    self.finalizarCompraVC.showBankInfoAlert()
                }
            }
            if let data = self.selectorData as? [YearModel] {
                self.finalizarCompraVC.changeSelectorTitleForYear(withString: "\(data[indexPath.row].year) ▼")
                self.finalizarCompraVC.selectedYear = data[indexPath.row].year
            }
            if let data = self.selectorData as? [MonthModel] {
                self.finalizarCompraVC.changeSelectorTitleForMonth(withString: "\(data[indexPath.row].month) ▼")
                self.finalizarCompraVC.selectedMonth = data[indexPath.row].month
            }
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
    
}
