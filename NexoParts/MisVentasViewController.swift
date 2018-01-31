//
//  MisVentasViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 8/29/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire

class MisVentasViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var from_date : String! = "0"
    var to_date   : String! = "0"
    
    var ListaDeComprasData = [NSObject]()
    var listaDeComprasModelData = [ListaDeComprasModel]()
    var selctedMenuItem : String!
    let cellId = "ListaDeComprasCellForAdmin"
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.misVentasViewComtroller = self
        return slideMenu
    }()
    let fromDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "From"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var fromDatePicker: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("From Date ▼", for: .normal)
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
        label.text = "To"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var toDatePicker: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("To Date ▼", for: .normal)
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
    lazy var cotizacionesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"padnote-small"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 5)
        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 0)
        button.setTitle("Cotizaciones", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = GRAY_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCotizacionButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    lazy var misVentasButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"presentation-small"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 5)
        button.titleEdgeInsets = UIEdgeInsets(top: 5,left: 0,bottom: 0,right: 0)
        button.setTitle("Mis Ventas", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = GREEN_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleMisVentasButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavBar()
        
        //customize the navigation bar
        customizeNavigationBar()
        
        // registering the table view
        tableView.register(ListaDeComprasCellForAdmin.self, forCellReuseIdentifier: cellId)
        
        //setup view
        setUpUI()
        
        //get the data from api
        getSelectedOfferCotizaciones()
    }
    
    func setupNavBar() {
        // setup the left menu icon inside nav bar and place a right blank menu item to center the logo image (if the logo is 44x44, there will be no need of placing a right bar item)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "company_menu"), style: .plain, target: self, action: #selector(handleMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menuBlank"), style: .plain, target: nil, action: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fromDatePicker.setTitle("From Date ▼", for: .normal)
        self.toDatePicker.setTitle("To Date ▼", for: .normal)
        self.from_date = "0"
        self.to_date = "0"
    }
    func handleMenuButton() {
        menu.show()
    }
    func customizeNavigationBar(){
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Mis Ventas"
        
        //hiding the back button on navigation bar
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fromDatePicker.layer.cornerRadius = fromDatePicker.frame.height / 2
        toDatePicker.layer.cornerRadius = toDatePicker.frame.height / 2
        searchByNumber.layer.cornerRadius = searchByNumber.frame.height / 2
    }
    lazy var calendarSelector: CalendarSelector = {
        let calendar = CalendarSelector()
        calendar.misVentasVC = self
        return calendar
    }()
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
                        let selectedCotizacionesDetails = ListaDeComprasModel(number: cotizacion["cotizacion_id"].string!, clientName: cotizacion["client_name"].string!, date: cotizacion["date"].string!, atricleTitle: "Articlus: \(cotizacion["number_of_articles"])", status: cotizacion["status_cotizacion"].string!, totalBill: cotizacion["total_bill"].string!)
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
    func setUpUI(){
        setUpFromDateLabel()
        setUpFromDatePicker()
        setUpToDateLabel()
        setUpToDatePicker()
        setupSearchByNumberLabel()
        setupSearchByNumber()
        setupCotizacionesButton()
        setupMisVentasButton()
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
    func setupCotizacionesButton(){
        view.addSubview(cotizacionesButton)
        cotizacionesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cotizacionesButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cotizacionesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        cotizacionesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    func setupMisVentasButton(){
        view.addSubview(misVentasButton)
        misVentasButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        misVentasButton.leftAnchor.constraint(equalTo: cotizacionesButton.rightAnchor).isActive = true
        misVentasButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        misVentasButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    func setupTableView(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchByNumber.bottomAnchor, constant: 30).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: cotizacionesButton.topAnchor).isActive = true
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
    
    func handleCotizacionButton(){
        self.navigationController?.pushViewController(CompanyHomeViewController(), animated: false)
    }
    func handleMisVentasButton(){
        self.navigationController?.pushViewController(MisVentasViewController(), animated: false)
    }
    func handleFromDateRange(){
        view.endEditing(true)
        calendarSelector.show(caller: "misVentas", dateStatus : "fromDate")
    }
    func handleToDateRange(){
        calendarSelector.show(caller: "misVentas", dateStatus : "toDate")
    }
    func changeFromDateButtonTitle(withString title: String) {
        DispatchQueue.main.async {
            self.fromDatePicker.setTitle(title, for: .normal)
        }
        if(title == "From Date ▼"){
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
        if(title == "To Date ▼"){
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
    func showCompanyAlertView(){
        let modalController = CompanyAlertView()
        modalController.alertMessage.text = "Si desea ver más detalle sobre esta venta, ingrese a nuestra plataforma web. Gracias"
        modalController.modalPresentationStyle = .overCurrentContext
        present(modalController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.dismiss(animated: true, completion: nil)
        })
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ListaDeComprasCellForAdmin {
            if let data = ListaDeComprasData as? [ListaDeComprasModel] {
                cell.clipboardIcon   = #imageLiteral(resourceName: "clipboard")
                cell.calendarIcon    = #imageLiteral(resourceName: "calendar")
                cell.idCardIcon      = #imageLiteral(resourceName: "id")
                cell.number          = "#\(data[indexPath.row].number)"
                cell.userName        = "\(data[indexPath.row].clientName)"
                cell.date            = "\(data[indexPath.row].date)"
                cell.articleTitle    = "\(data[indexPath.row].atricleTitle)"
                //cell.status          = "\(data[indexPath.row].status)"
                //cell.totalTitle      = "Total"
                //cell.totalBill       = "\(data[indexPath.row].totalBill)"
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showCompanyAlertView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    //Table delegate and datasource methods Ends
    
    func action() {
        if(self.selctedMenuItem == "Cotizaciones"){
            navigationController?.pushViewController(CompanyHomeViewController(), animated: false)
        }
        if(self.selctedMenuItem == "Mis Ventas"){
            navigationController?.pushViewController(MisVentasViewController(), animated: false)
        }
        if(self.selctedMenuItem == "Datos de Usuario"){
            navigationController?.pushViewController(EditarDatosViewController(), animated: true)
        }
        if(self.selctedMenuItem == "log out"){
            UserDefaults.standard.set(false, forKey: LOGGED_IN)
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

