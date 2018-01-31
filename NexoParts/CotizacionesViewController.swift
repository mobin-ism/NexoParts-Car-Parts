//
//  CotizacionesViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 6/7/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire

class CotizacionesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    var cotizacionesData = [NSObject]()
    var from_date : String! = "0"
    var to_date   : String! = "0"
    
    
    lazy var cotizacionCell: CotizacionCell = {
        let cell = CotizacionCell()
        cell.cvc = self
        return cell
    }()
    
    //let dateRangePicker: UIDatePicker = UIDatePicker()
    
    lazy var nuevaCotizacion: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"plus-circle"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 5)
        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 0)
        button.setTitle("COTIZAR", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = GREEN_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNuevaCotizacion), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 29)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: (button.titleLabel?.font.pointSize)!)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        return button
    }()
    let horizontalLineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:0.7)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let misCotizacionesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Mi Historial"
        label.font = UIFont(name: TEXT_FONT, size: 19)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let fromDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Fecha"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var fromDatePicker: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Desde ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFromDateRange), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    
    let toDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Hasta"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var toDatePicker: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hasta ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleToDateRange), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    let stateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Estado"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var statePicker: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Estado   ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleState), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    
    lazy var searchByNumber: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "#Cotizaciòn o Nombre"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.addTarget(self, action: #selector(handleSearchByCotizacionNumber), for: .editingChanged)
        //field.delegate = self
        return field
    }()
    let searchLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Buscar por"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = BG_COLOR
        table.allowsMultipleSelection = false
        table.clipsToBounds = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    let cellId = "cotizacionCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.title = "Cotizaciones"
        
        // removes the back title from back button of navigation bar
        let barAppearace = UIBarButtonItem.appearance()
        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        
        // registering the table view
        tableView.register(CotizacionCell.self, forCellReuseIdentifier: cellId)
        
        // Setting up the UI
        setupUi()
        
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "cart-white"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(goToCart), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    func goToCart(){
        self.navigationController?.pushViewController(ListaDeComprasViewController(), animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nuevaCotizacion.layer.cornerRadius = nuevaCotizacion.frame.height / 4
        
        fromDatePicker.layer.cornerRadius = fromDatePicker.frame.height / 2
        
        toDatePicker.layer.cornerRadius = toDatePicker.frame.height / 2
        
        statePicker.layer.cornerRadius = statePicker.frame.height / 2
        
        searchByNumber.layer.cornerRadius = searchByNumber.frame.height / 2
        searchByNumber.font = UIFont(name: TEXT_FONT, size: searchByNumber.frame.height * 0.35)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(UserDefaults.standard.value(forKey: USER_ID) as! String)
        self.fromDatePicker.setTitle("Desde ▼", for: .normal)
        self.toDatePicker.setTitle("Hasta ▼", for: .normal)
        self.from_date = "0"
        self.to_date = "0"
        self.searchByNumber.text = ""
        get_cotizaciones_from_api()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var selector: Selector = {
        let select = Selector()
        select.cotizacionesVC = self
        return select
    }()
    
    lazy var calendarSelector: CalendarSelector = {
        let calendar = CalendarSelector()
        calendar.cotizacionesVC = self
        return calendar
    }()
    
    var states = [Estado]()
    var estimation = [Cotizacion]()
    var idEstado: String = "0"
    var estimationId = [String]()
    func setupUi(){
        setUpNuevaCotizacion()
        setupHorizontalLineLabel()
        setupMisCotizacionesLabel()
        setUpFromDateLabel()
        setUpFromDatePicker()
        setUpToDateLabel()
        setUpToDatePicker()
        setupStateLabel()
        setUpStatePicker()
        //setUpSearchLabel()
        //setUpSearchByNumber()
        setUpTableView()
        setupActivityIndicator()
    }
    func setUpNuevaCotizacion(){
        view.addSubview(nuevaCotizacion)
        //constraints
        nuevaCotizacion.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nuevaCotizacion.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        nuevaCotizacion.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        nuevaCotizacion.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    func setupHorizontalLineLabel(){
        view.addSubview(horizontalLineLabel)
        horizontalLineLabel.topAnchor.constraint(equalTo: nuevaCotizacion.bottomAnchor, constant: 20).isActive = true
        horizontalLineLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        horizontalLineLabel.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    func setupMisCotizacionesLabel(){
        view.addSubview(misCotizacionesLabel)
        misCotizacionesLabel.topAnchor.constraint(equalTo: horizontalLineLabel.bottomAnchor, constant: 15).isActive = true
        misCotizacionesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func setUpFromDateLabel(){
        view.addSubview(fromDateLabel)
        //constraint
        fromDateLabel.topAnchor.constraint(equalTo: misCotizacionesLabel.bottomAnchor, constant: 25).isActive = true
        fromDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant:10).isActive = true
        fromDateLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        fromDateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
    }
    func setUpFromDatePicker(){
        view.addSubview(fromDatePicker)
        //constraint
        fromDatePicker.centerYAnchor.constraint(equalTo: fromDateLabel.centerYAnchor).isActive = true
        fromDatePicker.leftAnchor.constraint(equalTo: fromDateLabel.rightAnchor, constant: 10).isActive = true
        fromDatePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        fromDatePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    func setUpToDateLabel(){
        view.addSubview(toDateLabel)
        //constraint
        toDateLabel.centerYAnchor.constraint(equalTo: fromDateLabel.centerYAnchor).isActive = true
        toDateLabel.leftAnchor.constraint(equalTo: fromDatePicker.rightAnchor).isActive = true
        toDateLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        toDateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
    }
    func setUpToDatePicker(){
        view.addSubview(toDatePicker)
        //constraint
        toDatePicker.centerYAnchor.constraint(equalTo: toDateLabel.centerYAnchor).isActive = true
        toDatePicker.leftAnchor.constraint(equalTo: toDateLabel.rightAnchor, constant: 5).isActive = true
        toDatePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        toDatePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    func setupStateLabel(){
        view.addSubview(stateLabel)
        stateLabel.topAnchor.constraint(equalTo: fromDatePicker.bottomAnchor, constant: 15).isActive = true
        stateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20).isActive = true
    }
    func setUpStatePicker(){
        view.addSubview(statePicker)
        //Constraints
        statePicker.centerYAnchor.constraint(equalTo: stateLabel.centerYAnchor).isActive = true
        statePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-10).isActive = true
        statePicker.leftAnchor.constraint(equalTo: stateLabel.rightAnchor, constant:10).isActive = true
        statePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    func setUpSearchLabel(){
        view.addSubview(searchLabel)
        //constraints
        searchLabel.topAnchor.constraint(equalTo: statePicker.bottomAnchor, constant: 15).isActive = true
        searchLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        searchLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20).isActive = true
    }
    func setUpSearchByNumber(){
        view.addSubview(searchByNumber)
        // constraints
        searchByNumber.centerYAnchor.constraint(equalTo: searchLabel.centerYAnchor).isActive = true
        searchByNumber.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        searchByNumber.leftAnchor.constraint(equalTo: searchLabel.rightAnchor, constant: 10).isActive = true
        searchByNumber.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func setUpTableView(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: statePicker.bottomAnchor, constant:25).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        //tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    func handleNuevaCotizacion(){
        self.navigationController?.pushViewController(NuevaCotizacion(), animated: true)
    }
    func handleFromDateRange(){
        calendarSelector.show(caller: "client", dateStatus : "fromDate")
    }
    func handleToDateRange(){
        calendarSelector.show(caller: "client", dateStatus : "toDate")
    }
    func changeFromDateButtonTitle(withString title: String) {
        DispatchQueue.main.async {
            self.fromDatePicker.setTitle(title, for: .normal)
        }
        if(title == "Desde ▼"){
            self.from_date = "0"
        }
        else{
            self.from_date = title
        }
        self.callAPIFunction()
    }
    func changeToDateButtonTitle(withString title: String) {
        DispatchQueue.main.async {
            self.toDatePicker.setTitle(title, for: .normal)
        }
        if(title == "Hasta ▼"){
            self.to_date = "0"
        }
        else{
            self.to_date = title
        }
        self.callAPIFunction()
    }
    func callAPIFunction(){
        get_cotizaciones_by_date_range_from_api()
    }
    func handleState(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_estados") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                return
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let statesData = Estado(idEstado: dict["id_estado"].string!, detalle: dict["detalle"].string!)
                        self.states.append(statesData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.states)
                }
            }
        })
    }
    func getEstadoId(){
        get_cotizaciones_by_estado_from_api()
    }
    // search by number
    func handleSearchByCotizacionNumber(){
        if(searchByNumber.text != ""){
            get_cotizaciones_by_number_from_api()
        }
        else{
            get_cotizaciones_from_api()
        }
    }
    
    func changeSelectorTitle(withString title: String) {
        statePicker.setTitle(title, for: .normal)
    }
    
    // Cotizaciones data from API
    func get_cotizaciones_from_api(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_cotizacion/\(UserDefaults.standard.value(forKey: USER_ID) as! String)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                print(response.result)
                return
            }
            if !self.estimation.isEmpty {
                self.estimation.removeAll()
            }
            if !self.estimationId.isEmpty {
                self.estimationId.removeAll()
            }
            //print(response)
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let cotizacionData = Cotizacion(idCotizacion: dict["id_cotizacion"].string!, clientName: dict["client_name"].string!, date: dict["date_added"].string!, articulosTitle: dict["number_of_articles"].string!, statusCotizacion: dict["status"].string! )
                        self.estimation.append(cotizacionData)
                        self.estimationId.append(cotizacionData.idCotizacion)
                    }
                    self.refreshCotizacionTable(withData: self.estimation)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    
    // Cotizacion filtered by id
    func get_cotizaciones_by_number_from_api(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_cotizacion_by_number/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(searchByNumber.text!)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                print(response.result)
                self.estimation.removeAll()
                self.refreshCotizacionTable(withData: self.estimation)
                return
            }
            if !self.estimation.isEmpty {
                self.estimation.removeAll()
            }
            if !self.estimationId.isEmpty {
                self.estimationId.removeAll()
            }
            print(response)
            self.activityIndicator.stopAnimating()
            
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let cotizacionData = Cotizacion(idCotizacion: dict["id_cotizacion"].string!, clientName: dict["client_name"].string!, date: dict["date_added"].string!, articulosTitle: dict["number_of_articles"].string!, statusCotizacion: dict["status"].string! )
                        self.estimation.append(cotizacionData)
                        self.estimationId.append(cotizacionData.idCotizacion)
                    }
                    self.refreshCotizacionTable(withData: self.estimation)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    
    // Get the cotizaciones filtered by estado
    func get_cotizaciones_by_estado_from_api(){
        
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_cotizacion_by_estado/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(self.idEstado)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                //print(response.result)
                self.estimation.removeAll()
                self.refreshCotizacionTable(withData: self.estimation)
                return
            }
            if !self.estimation.isEmpty {
                self.estimation.removeAll()
            }
            if !self.estimationId.isEmpty {
                self.estimationId.removeAll()
            }
            //print(response)
            self.activityIndicator.stopAnimating()
            
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let cotizacionData = Cotizacion(idCotizacion: dict["id_cotizacion"].string!, clientName: dict["client_name"].string!, date: dict["date_added"].string!, articulosTitle: dict["number_of_articles"].string!, statusCotizacion: dict["status"].string! )
                        self.estimation.append(cotizacionData)
                        self.estimationId.append(cotizacionData.idCotizacion)
                    }
                    self.refreshCotizacionTable(withData: self.estimation)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    // Cotizaciones data from API
    func get_cotizaciones_by_date_range_from_api(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_cotizacion_by_date_range/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(self.from_date!)/\(self.to_date!)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                print(response.result)
                self.estimation.removeAll()
                self.refreshCotizacionTable(withData: self.estimation)
                return
            }
            if !self.estimation.isEmpty {
                self.estimation.removeAll()
            }
            if !self.estimationId.isEmpty {
                self.estimationId.removeAll()
            }
            //print(response)
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let cotizacionData = Cotizacion(idCotizacion: dict["id_cotizacion"].string!, clientName: dict["client_name"].string!, date: dict["date_added"].string!, articulosTitle: dict["number_of_articles"].string!, statusCotizacion: dict["status"].string! )
                        self.estimation.append(cotizacionData)
                        self.estimationId.append(cotizacionData.idCotizacion)
                    }
                    self.refreshCotizacionTable(withData: self.estimation)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    // Refresh Cotizacion Table
    func refreshCotizacionTable(withData tableData: [NSObject]){
        cotizacionesData = tableData
        tableView.reloadData()
    }
    // Delegate and Datasource functionalities
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cotizacionesData.count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CotizacionCell {
            if let data = cotizacionesData as? [Cotizacion] {
                cell.cotizacionImage = #imageLiteral(resourceName: "placeholder")
                cell.clipboardIcon   = #imageLiteral(resourceName: "clipboard")
                cell.calendarIcon    = #imageLiteral(resourceName: "calendar")
                cell.idCardIcon      = #imageLiteral(resourceName: "id")
                cell.cotizacionNumberText = "#\(data[indexPath.row].idCotizacion)"
                cell.clientNameText = "\(data[indexPath.row].clientName)"
                cell.dateText = "\(data[indexPath.row].date)"
                cell.articuloTitleText = "Articulos: \(data[indexPath.row].atriculosTitle)"
                cell.statusText = "\(data[indexPath.row].statusCotizacion)"
                cell.greenIconNuevaCotizacionButton.addTarget(self, action: #selector(handleNuevaCotizacion), for: .touchUpInside)
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("selected row")
        //print(self.estimationId[indexPath.row])
        
        /*let ofertaVC = OfertasViewController()
        ofertaVC.selectedCotizacionID = self.estimationId[indexPath.row]
        navigationController?.pushViewController(ofertaVC, animated: true)*/
        
        let articleWiseOffer = ArticleWiseOfferViewController()
        articleWiseOffer.selectedCotizacionID = self.estimation[indexPath.row].idCotizacion
        navigationController?.pushViewController(articleWiseOffer, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


