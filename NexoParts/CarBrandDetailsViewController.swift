//
//  CarBrandDetailsViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 7/4/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class CarBrandDetailsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var priceRangeArray = [PriceRange]()
    var carModelsData = [NSObject]()
    var selectedBrand : Int!
    var selectedPriceRangeId : String!
    
    let autos = [#imageLiteral(resourceName: "toyota"), #imageLiteral(resourceName: "KIA_motors"), #imageLiteral(resourceName: "Mazda_logo"), #imageLiteral(resourceName: "mitsubishi"), #imageLiteral(resourceName: "hyundai"), #imageLiteral(resourceName: "Nissan"), #imageLiteral(resourceName: "chevrolet-logo"), #imageLiteral(resourceName: "ford-logo"), #imageLiteral(resourceName: "honda-logo")]
    let autoTitleArray = ["Toyota", "Kia", "Mazda", "Mitsubishi", "Hyundai", "Nissan", "Chevrolet", "Ford", "Honda"]
    var modelArray = [CarBrandDetailsModel]()
    let brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let rangoDePrecio : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Rango De Precio"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let rangeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Seleccionar Rango   ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRange), for: .touchUpInside)
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
    
    let cellId = "CarBrandDetailsCell"
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // setting up the upper image
        self.brandImageView.image = self.autos[self.selectedBrand]
        
        //customize the navigation bar
        customizeNavigationBar()
        
        // registering the table view
        tableView.register(CarBrandDetailsCell.self, forCellReuseIdentifier: cellId)
        
        // Setting up the UI
        setupUi()
        
    }
    
    func customizeNavigationBar(){
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Cotizado De Autos"
        
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //getAllModels()
        getAllModelsByPriceRange()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rangeButton.layer.cornerRadius = rangeButton.frame.height / 2
    }
    lazy var selector: Selector = {
        let select = Selector()
        select.carBrandDetailsVC = self
        return select
    }()
    func changeSelectorTitle(withString title: String) {
        rangeButton.setTitle(title, for: .normal)
        print(self.selectedPriceRangeId!)
    }
    func handleRange(){
        // Fetching the modelo datas
        activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)price_range") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response.result)
                self.activityIndicator.stopAnimating()
                return
            }
            //print(response)
            if !self.priceRangeArray.isEmpty{
                self.priceRangeArray.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let priceArray = json.array {
                    let noRange = PriceRange(idPriceRange: "0", range: "All")
                    self.priceRangeArray.append(noRange)
                    for price in priceArray {
                        let range = PriceRange(idPriceRange: price["id_rango"].string!, range: price["rango"].string!)
                        self.priceRangeArray.append(range)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.priceRangeArray)
                }
            }
        })
    }
    
    func setupUi(){
        setupBrnadImageView()
        setupRangeLabel()
        setupRangeSelector()
        setUpTableView()
        setupActivityIndicator()
    }
    func setupBrnadImageView(){
        view.addSubview(brandImageView)
        brandImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        brandImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        brandImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        brandImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    func setupRangeLabel(){
        view.addSubview(rangoDePrecio)
        rangoDePrecio.topAnchor.constraint(equalTo: brandImageView.bottomAnchor, constant: 15).isActive = true
        rangoDePrecio.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        rangoDePrecio.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    
    func setupRangeSelector(){
        view.addSubview(rangeButton)
        rangeButton.centerYAnchor.constraint(equalTo: rangoDePrecio.centerYAnchor).isActive = true
        rangeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        rangeButton.leftAnchor.constraint(equalTo: rangoDePrecio.rightAnchor, constant:10).isActive = true
    }
    func setUpTableView(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: rangeButton.bottomAnchor, constant:25).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    func getAllModels(){
        // Fetching the modelo datas
        //print(self.autoTitleArray[self.selectedBrand])
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)details_lista_de_autos/\(self.autoTitleArray[self.selectedBrand])") else { return }
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
            //print(response)
            if !self.modelArray.isEmpty{
                self.modelArray.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let brandDetails = CarBrandDetailsModel(modelTitle: dict["nombre_modelo"].string!, modelYear: dict["date_added"].string!, version: dict["version"].string!, modelStatus: dict["status"].string!, carImage: dict["image_url"].string!)
                        self.modelArray.append(brandDetails)
                    }
                    self.refreshCarModelsTable(withData: self.modelArray)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    //get models by price range
    func getAllModelsByPriceRange(){
        // Fetching the modelo datas
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)details_lista_de_autos_by_price_range/\(self.autoTitleArray[self.selectedBrand])/\(self.selectedPriceRangeId!)") else { return }
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
            //print(response)
            if !self.modelArray.isEmpty{
                self.modelArray.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let brandDetails = CarBrandDetailsModel(modelTitle: dict["nombre_modelo"].string!, modelYear: dict["date_added"].string!, version: dict["version"].string!, modelStatus: dict["status"].string!, carImage: dict["image_url"].string!)
                        self.modelArray.append(brandDetails)
                    }
                    self.refreshCarModelsTable(withData: self.modelArray)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    // Refresh Cotizacion Table
    func refreshCarModelsTable(withData tableData: [NSObject]){
        carModelsData = tableData
        tableView.reloadData()
    }
    // Delegate and Datasource functionalities
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carModelsData.count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CarBrandDetailsCell {
            if let data = carModelsData as? [CarBrandDetailsModel] {
                //cell.carImage     = #imageLiteral(resourceName: "carModelImage")
                cell.carModelImageView.sd_setImage(with: URL(string: data[indexPath.row].carImage), placeholderImage: #imageLiteral(resourceName: "carModelImage"), options: [.continueInBackground, .progressiveDownload])
                cell.carIcon      = #imageLiteral(resourceName: "car")
                cell.calenderIcon = #imageLiteral(resourceName: "calendar")
                cell.keyIcon      = #imageLiteral(resourceName: "car-key")
                cell.carTitle     = "\(data[indexPath.row].modelTitle)"
                cell.year         = "\(data[indexPath.row].modelYear)"
                cell.version       = "\(data[indexPath.row].version)"
                cell.status       = "\(data[indexPath.row].modelStatus)"
                cell.greenArrow   = "▶︎"
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Create the alert controller
        let alertController = UIAlertController(title: "¿Te interesa este auto?", message: "", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Llamar a Nexoparts", style: UIAlertActionStyle.default) {
            UIAlertAction in
            let phoneNumber = "60448260"
            print("Call Nexoparts")
            if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        //Cancel
        let cancelAction = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            print("Cancel")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
