//
//  OfertasViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 7/9/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire

class OfertasViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var idDetalle : String!
    var selectedCotizacionID = ""
    //For refreshing the table with this array
    var offersData = [NSObject]()
    
    // For storing the data which are coming from api
    var offerArray = [OffertaModel]()
    
    let cotizacionNoTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Cotizacion No:"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var cotizacionNoLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let gotoCartButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ir al carrito", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor(red:0.26, green:0.26, blue:0.26, alpha:1.0)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCartButton), for: .touchUpInside)
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
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let cellId = "OfertaCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cotizacionNoLabel.text = "# \(self.selectedCotizacionID)"
        //customize the navigation bar
        customizeNavigationBar()
        
        //Setting up the UI
        setupUI()
        
        // registering the table view
        tableView.register(OfertaCell.self, forCellReuseIdentifier: cellId)
        
        //get offers
        self.getOfferats()
    }
    
    func customizeNavigationBar(){
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Ofertas"
        
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gotoCartButton.layer.cornerRadius = gotoCartButton.frame.height / 2
    }
    func setupUI(){
        setupCotizacionNumberTitleLabel()
        setupCotizacionNumberLabel()
        //setupGoToCartButton()
        setupTableView()
        setupActivityIndicator()
    }
    func setupCotizacionNumberTitleLabel(){
        view.addSubview(cotizacionNoTitleLabel)
        cotizacionNoTitleLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        cotizacionNoTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
    }
    func setupCotizacionNumberLabel(){
        view.addSubview(cotizacionNoLabel)
        cotizacionNoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cotizacionNoLabel.topAnchor.constraint(equalTo: cotizacionNoTitleLabel.bottomAnchor, constant: 5).isActive = true
    }
    func setupGoToCartButton(){
        view.addSubview(gotoCartButton)
        gotoCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gotoCartButton.topAnchor.constraint(equalTo: cotizacionNoLabel.bottomAnchor, constant: 10).isActive = true
        gotoCartButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        gotoCartButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    func setupTableView(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: cotizacionNoLabel.bottomAnchor, constant: 15).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    func getOfferats(){
        self.activityIndicator.startAnimating()
        //self.selectedCotizacionID = "27"
        guard let url = URL(string: "\(API_URL)getOferats/\(self.idDetalle!)") else { return }
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
            if !self.offerArray.isEmpty {
                self.offerArray.removeAll()
            }
            print(response)
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let offerDetails = OffertaModel(offerID: dict["id_oferta"].string!, adminName: dict["admin_name"].string!, price: dict["price"].string!)
                        self.offerArray.append(offerDetails)
                    }
                    self.refreshCarModelsTable(withData: self.offerArray)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    
    // Refresh Cotizacion Table
    func refreshCarModelsTable(withData tableData: [NSObject]){
        offersData = tableData
        tableView.reloadData()
    }
    
    // Delegate and Datasource functionalities
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersData.count
        //return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? OfertaCell {
            if let data = offersData as? [OffertaModel] {
                cell.idCard = #imageLiteral(resourceName: "id")
                cell.adminName = "\(data[indexPath.row].adminName)"
                cell.price = "\(data[indexPath.row].price)"
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = offersData as? [OffertaModel] {
            let selectedOfferVC = OfferDetailsViewController()
            selectedOfferVC.selectedOffer = data[indexPath.row].offerID
            selectedOfferVC.selcectedCotizacion = self.selectedCotizacionID
            selectedOfferVC.idDetalle = self.idDetalle!
            navigationController?.pushViewController(selectedOfferVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func handleCartButton(){
        print("Go to Cart")
    }
    
}

