//
//  ListaDeComprasViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 7/9/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire

class ListaDeComprasViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var from_date : String! = "0"
    var to_date   : String! = "0"
    
    var ListaDeComprasData = [NSObject]()
    var listaDeComprasModelData = [ListaDeComprasModel]()
    
    let cellId = "listaDeComprasCell"
    
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
    let searchLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Atención:"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var searchByNumber: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Atención o Empresa 🔍", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 12)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.addTarget(self, action: #selector(handleSearchByCotizacionNumber), for: .editingChanged)
        //field.delegate = self
        return field
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
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //customize the navigation bar
        customizeNavigationBar()
        
        // registering the table view
        tableView.register(ListaDeComprasCell.self, forCellReuseIdentifier: cellId)
        
        //setup view
        setUpUI()
        
        //get the data from api
        getSelectedOfferCotizaciones()
    }
    func customizeNavigationBar(){
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Lista De Compras"
        
        // removes the back title from back button of navigation bar
        let barAppearace = UIBarButtonItem.appearance()
        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fromDatePicker.layer.cornerRadius = fromDatePicker.frame.height / 2
        toDatePicker.layer.cornerRadius = toDatePicker.frame.height / 2
        searchByNumber.layer.cornerRadius = searchByNumber.frame.height / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fromDatePicker.setTitle("Desde ▼", for: .normal)
        self.toDatePicker.setTitle("Hasta ▼", for: .normal)
        self.from_date = "0"
        self.to_date = "0"
        //get the data from api
        getSelectedOfferCotizaciones()
    }
    lazy var calendarSelector: CalendarSelector = {
        let calendar = CalendarSelector()
        calendar.listaDeCompras = self
        return calendar
    }()
    func handleFromDateRange(){
        calendarSelector.show(caller: "listaDeCompras", dateStatus : "fromDate")
    }
    func handleToDateRange(){
        calendarSelector.show(caller: "listaDeCompras", dateStatus : "toDate")
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
        get_cart_details_by_date_range()
    }
    func get_cart_details_by_date_range(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_cart_details_by_date_range/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(self.from_date!)/\(self.to_date!)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            self.activityIndicator.startAnimating()
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                print(response.result)
                return
            }
            print(response)
            if !self.listaDeComprasModelData.isEmpty {
                self.listaDeComprasModelData.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let cotizacionArray = json.array {
                    for cotizacion in cotizacionArray {
                        let selectedCotizacionesDetails = ListaDeComprasModel(number: cotizacion["cotizacion_id"].string!, clientName: cotizacion["client_name"].string!, date: cotizacion["date"].string!, atricleTitle: "Articlus: \(cotizacion["number_of_articles"])", status: cotizacion["status_cotizacion"].string!, totalBill: cotizacion["total_bill"].string!)
                        self.listaDeComprasModelData.append(selectedCotizacionesDetails)
                    }
                    self.refreshCotizacionTable(withData: self.listaDeComprasModelData)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    func getSelectedOfferCotizaciones(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)getSelectedOfferCotizaciones/\(UserDefaults.standard.value(forKey: USER_ID) as! String)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            self.activityIndicator.startAnimating()
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                print(response.result)
                return
            }
            print(response)
            if !self.listaDeComprasModelData.isEmpty {
                self.listaDeComprasModelData.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let cotizacionArray = json.array {
                    for cotizacion in cotizacionArray {
                        let selectedCotizacionesDetails = ListaDeComprasModel(number: cotizacion["cotizacion_id"].string!, clientName: cotizacion["client_name"].string!, date: cotizacion["date"].string!, atricleTitle: "Articulos en cotización: \(cotizacion["number_of_articles"])", status: cotizacion["status_cotizacion"].string!, totalBill: cotizacion["total_bill"].string!)
                        self.listaDeComprasModelData.append(selectedCotizacionesDetails)
                    }
                    self.refreshCotizacionTable(withData: self.listaDeComprasModelData)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    func getSelectedOfferCotizacionesByCotizacionesId(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)getSelectedOfferCotizacionesByCotizacionesId/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(self.searchByNumber.text!)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            self.activityIndicator.startAnimating()
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                print(response.result)
                return
            }
            print(response)
            if !self.listaDeComprasModelData.isEmpty {
                self.listaDeComprasModelData.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let cotizacionArray = json.array {
                    for cotizacion in cotizacionArray {
                        let selectedCotizacionesDetails = ListaDeComprasModel(number: cotizacion["cotizacion_id"].string!, clientName: cotizacion["client_name"].string!, date: cotizacion["date"].string!, atricleTitle: "Articlus: \(cotizacion["number_of_articles"])", status: cotizacion["status_cotizacion"].string!, totalBill: cotizacion["total_bill"].string!)
                        self.listaDeComprasModelData.append(selectedCotizacionesDetails)
                    }
                    self.refreshCotizacionTable(withData: self.listaDeComprasModelData)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    func setUpUI(){
        setUpFromDateLabel()
        setUpFromDatePicker()
        setUpToDateLabel()
        setUpToDatePicker()
        setupSearchByNumberLabel()
        setupSearchByNumber()
        setupTableView()
        setupActivityIndicator()
    }
    func setUpFromDateLabel(){
        view.addSubview(fromDateLabel)
        //constraint
        fromDateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
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
    func setupSearchByNumberLabel(){
        view.addSubview(searchLabel)
        searchLabel.topAnchor.constraint(equalTo: fromDatePicker.bottomAnchor, constant: 15).isActive = true
        searchLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35).isActive = true
        searchLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    func setupSearchByNumber(){
        view.addSubview(searchByNumber)
        searchByNumber.centerYAnchor.constraint(equalTo: searchLabel.centerYAnchor).isActive = true
        searchByNumber.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35).isActive = true
        searchByNumber.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        searchByNumber.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.045).isActive = true
    }
    func setupTableView(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchByNumber.bottomAnchor, constant: 30).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    func handleSearchByCotizacionNumber(){
        if(searchByNumber.text != ""){
            getSelectedOfferCotizacionesByCotizacionesId()
        }
        else{
            getSelectedOfferCotizaciones()
        }
    }
    func handleDateRange(){
        
    }
    
    //Table delegate and datasource methods
    
    // Refresh Cotizacion Table
    func refreshCotizacionTable(withData tableData: [NSObject]){
        ListaDeComprasData = tableData
        tableView.reloadData()
    }
    
    // Delegate and Datasource functionalities
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListaDeComprasData.count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ListaDeComprasCell {
            if let data = ListaDeComprasData as? [ListaDeComprasModel] {
                print("Here is dumb\(data[indexPath.row].atricleTitle)")
                cell.clipboardIcon   = #imageLiteral(resourceName: "clipboard")
                cell.calendarIcon    = #imageLiteral(resourceName: "calendar")
                cell.idCardIcon      = #imageLiteral(resourceName: "id")
                cell.number          = "#\(data[indexPath.row].number)"
                cell.userName        = "\(data[indexPath.row].clientName)"
                cell.date            = "\(data[indexPath.row].date)"
                cell.articleTitle    = "\(data[indexPath.row].atricleTitle)"
                cell.status          = "\(data[indexPath.row].status)"
                cell.totalTitle      = "Total"
                cell.totalBill       = "\(data[indexPath.row].totalBill)"
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resumenDeCompraVC = ResumenDeCompraViewController()
        resumenDeCompraVC.selectedCotizacionNumber = listaDeComprasModelData[indexPath.row].number
        resumenDeCompraVC.numberLabel.text = "#\(listaDeComprasModelData[indexPath.row].number)"
        UserDefaults.standard.set("\(listaDeComprasModelData[indexPath.row].number)", forKey: COTIZACION_NUMBER)
        self.navigationController?.pushViewController(resumenDeCompraVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    //Table delegate and datasource methods Ends
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

