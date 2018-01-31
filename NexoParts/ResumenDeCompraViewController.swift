//
//  ResumenDeCompraViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 8/2/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire

class ResumenDeCompraViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var resumenDeCompraData = [NSObject]()
    var resumenDeCompraModelData = [ResumenDeComprarModel]()
    let cellId = "resumenDeCompraCell"
    var selectedCotizacionNumber : String!
    var totalBill : Float! = 0.00
    let resumenDeCompraLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:1.0)
        label.font = UIFont(name: BOLD_TEXT_FONT, size: 16)
        label.text = "Resumen De Compra:"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let comprarButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Comprar", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = GREEN_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleComprarButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
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
    let totalBillTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Total Neto B/.   "
        label.textColor = UIColor.white
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:1.0).cgColor
        label.numberOfLines = 0
        return label
    }()
    lazy var totalBillLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "0.00"
        label.textColor = GREEN_COLOR
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:1.0).cgColor
        label.numberOfLines = 0
        return label
    }()
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var resumenCell: ResumenDeCompraCell = {
        let cell = ResumenDeCompraCell()
        cell.resumenVC = self
        return cell
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //customize the navigation bar
        customizeNavigationBar()
        
        // registering the table view
        tableView.register(ResumenDeCompraCell.self, forCellReuseIdentifier: cellId)
        
        //setup view
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //get data from api
        getOffersFromSelectedCotizacion()
    }
    func reloadTableData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.tableView.reloadData()
            print(123456778)
        })
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
        comprarButton.layer.cornerRadius = comprarButton.frame.height / 2
    }
    func getOffersFromSelectedCotizacion(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)getOffersFromSelectedCotizacion/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(UserDefaults.standard.value(forKey: COTIZACION_NUMBER) as! String)") else { return }
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
            if !self.resumenDeCompraModelData.isEmpty {
                self.resumenDeCompraModelData.removeAll()
            }
            if(self.totalBill > 0){
                self.totalBill = 0.00
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let offerDetailsArray = json.array {
                    for offer in offerDetailsArray {
                        let offerDetails = ResumenDeComprarModel(offerId: offer["offer_id"].string!, marca: offer["marca_name"].string!, model: offer["model_name"].string!, year: offer["year"].string!, atricleTitle: offer["article_title"].string!, status: offer["offer_status"].string!, valor: offer["price"].string!)
                        self.resumenDeCompraModelData.append(offerDetails)
                        self.totalBill = self.totalBill + Float(offer["price"].string!)!
                    }
                    self.refreshCotizacionTable(withData: self.resumenDeCompraModelData)
                    self.activityIndicator.stopAnimating()
                    self.totalBillLabel.text = "\(self.totalBill!)"
                }
            }
        })
    }
    func setUpUI(){
        setupResumenDeCompraLabel()
        setupNumberLabel()
        setupComprarButton()
        setupTotalBillTitleLabel()
        setupTotalBillLabel()
        setupTableView()
        setupActivityIndicator()
    }
    func setupResumenDeCompraLabel(){
        view.addSubview(resumenDeCompraLabel)
        resumenDeCompraLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resumenDeCompraLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
    }
    func setupNumberLabel(){
        view.addSubview(numberLabel)
        numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numberLabel.topAnchor.constraint(equalTo: resumenDeCompraLabel.bottomAnchor, constant: 10).isActive = true
    }
    func setupComprarButton(){
        view.addSubview(comprarButton)
        comprarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        comprarButton.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10).isActive = true
        comprarButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        comprarButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    func setupTotalBillTitleLabel(){
        view.addSubview(totalBillTitleLabel)
        totalBillTitleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        totalBillTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        totalBillTitleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        totalBillTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    func setupTotalBillLabel(){
        view.addSubview(totalBillLabel)
        totalBillLabel.heightAnchor.constraint(equalTo: totalBillTitleLabel.heightAnchor, multiplier: 1).isActive = true
        totalBillLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        totalBillLabel.bottomAnchor.constraint(equalTo: totalBillTitleLabel.bottomAnchor).isActive = true
        totalBillLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    func setupTableView(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: comprarButton.bottomAnchor, constant: 15).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: totalBillTitleLabel.topAnchor).isActive = true
    }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    func handleComprarButton(){
        if self.resumenDeCompraModelData.count > 0{
            let datosDeEnvioVC = DatosDeEnvioViewController()
            datosDeEnvioVC.selectedCotozaciones = self.selectedCotizacionNumber
            self.navigationController?.pushViewController(datosDeEnvioVC, animated: true)
        }
        else{
            self.showAlertView()
        }
    }
    func showAlertView(){
        // Create the alert controller
        let alertController = UIAlertController(title: "No tienes ningún articulo para comprar", message: "", preferredStyle: .alert)
        
        // Create the actions
        let agregarArticuloAction = UIAlertAction(title: "Agregar Articulo", style: UIAlertActionStyle.default) {
            UIAlertAction in
            // Popping To view controller
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: CotizacionesViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
            self.navigationController?.pushViewController(CotizacionesViewController(), animated: true)
        }
        // Create the actions
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        // Add the actions
        alertController.addAction(agregarArticuloAction)
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Table delegate and datasource methods
    //delete offer by tapping cross
    func removeItemFromCart(tapGestureRecognizer: TapGesture){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)remove_item_from_cart/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(tapGestureRecognizer.tappedOfferId)") else {return}
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            self.activityIndicator.startAnimating()
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                print(response.result)
                return
            }
            print(response)
            
            //refresh the table
            self.getOffersFromSelectedCotizacion()
        })
    }
    // Refresh Cotizacion Table
    func refreshCotizacionTable(withData tableData: [NSObject]){
        resumenDeCompraData = tableData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print(resumenDeCompraData.count)
        
    }
    
    // Delegate and Datasource functionalities
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resumenDeCompraData.count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ResumenDeCompraCell {
            if let data = resumenDeCompraData as? [ResumenDeComprarModel] {
                cell.carIcon       = #imageLiteral(resourceName: "car")
                cell.calendarIcon  = #imageLiteral(resourceName: "calendar")
                cell.keyIcon       = #imageLiteral(resourceName: "car-key")
                cell.crossIcon     = #imageLiteral(resourceName: "minus-black")
                cell.marca         = "\(data[indexPath.row].marca)"
                cell.model         = "\(data[indexPath.row].model)"
                cell.year          = "\(data[indexPath.row].year)"
                cell.articleTitle  = "\(data[indexPath.row].atricleTitle)"
                cell.status        = "\(data[indexPath.row].status)"
                cell.valor         = "\(data[indexPath.row].valor)"
                cell.hiddenOfferId = "\(data[indexPath.row].offerId)"
                let tapGestureRecognizer = TapGesture(target: self, action: #selector(removeItemFromCart(tapGestureRecognizer:)))
                tapGestureRecognizer.tappedOfferId = "\(data[indexPath.row].offerId)"
                cell.crossIconView.isUserInteractionEnabled = true
                cell.crossIconView.addGestureRecognizer(tapGestureRecognizer)
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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

