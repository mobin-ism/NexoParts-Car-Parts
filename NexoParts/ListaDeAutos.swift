//
//  Lista_De_Autos.swift
//  NexoParts
//
//  Created by Creativeitem on 6/20/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class ListaDeAutos:UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var priceRangeArray = [PriceRange2]()
    var idPriceRange : String! = "0"
    var collectionViewData = [NSObject]()
    
    var numberOfModelsArray = [NumberOfModels]()
    var selectedBrand : Int!
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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = true
        collection.alwaysBounceVertical = true
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.register(AutoCell.self, forCellWithReuseIdentifier: cellId)
        
        //customize the navigation bar
        customizeNavigationBar()
        
        //Get the value from API
        get_number_of_models()
        
        // Setting up the UI
        setupUi()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //self.idPriceRange = "0"
    }
    
    let auto_array = ["Toyota", "KIA", "Mazda", "Mitsubishi", "Hyundai", "Nissan", "Chevrolet", "Ford", "Honda"]
    
    var auto_array_with_number = [String!](repeating: nil, count: 9)
    let autos = [#imageLiteral(resourceName: "toyota"), #imageLiteral(resourceName: "KIA_motors"), #imageLiteral(resourceName: "Mazda_logo"), #imageLiteral(resourceName: "mitsubishi"), #imageLiteral(resourceName: "hyundai"), #imageLiteral(resourceName: "Nissan"), #imageLiteral(resourceName: "chevrolet-logo"), #imageLiteral(resourceName: "ford-logo"), #imageLiteral(resourceName: "honda-logo")]
    let cellId = "AutoCell"
    
    // values are coming from API
    func get_number_of_models(){
        // Fetching the modelo datas
        activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)lista_de_autos/\(self.idPriceRange!)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true",
                      "auto_array" : auto_array] as [String: Any]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response.result)
                self.activityIndicator.stopAnimating()
                return
            }
            print(response)
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let marcaArray = json.array {
                    for marca in marcaArray {
                        //print(marca)
                        let number = NumberOfModels(idMarca:marca["id_marca"].string!, nombreMarca: marca["nombre_marca"].string!, numberOfModels: marca["number_of_models"].string!)
                        self.numberOfModelsArray.append(number)
                    }
                    var flag : Int
                    for cell in self.numberOfModelsArray{
                        flag = self.auto_array.index(of: cell.nombreMarca)!
                        print(flag)
                        self.auto_array_with_number[flag] = cell.numberOfModels
                    }
                    self.activityIndicator.stopAnimating()
                    self.refreshListaDeAutosCollectionView(withData: self.collectionViewData)
                }
            }
        })
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rangeButton.layer.cornerRadius = rangeButton.frame.height / 2
    }
    lazy var selector: Selector = {
        let select = Selector()
        select.listaDeAutoVC = self
        return select
    }()
    func setupUi(){
        setupRangeLabel()
        setupRangeSelector()
        setupCollectionView()
        setupActivityIndicator()
    }
    
    func setupRangeLabel(){
        view.addSubview(rangoDePrecio)
        rangoDePrecio.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        rangoDePrecio.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        rangoDePrecio.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    
    func setupRangeSelector(){
        view.addSubview(rangeButton)
        rangeButton.centerYAnchor.constraint(equalTo: rangoDePrecio.centerYAnchor).isActive = true
        rangeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        rangeButton.leftAnchor.constraint(equalTo: rangoDePrecio.rightAnchor, constant:10).isActive = true
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: rangeButton.bottomAnchor, constant: 30).isActive = true
        //collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    func changeSelectorTitle(withString title: String) {
        rangeButton.setTitle(title, for: .normal)
        print(self.idPriceRange!)
        self.get_number_of_models()
    }
    func handleRange(){
        // Fetching the modelo datas
        activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)price_range") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true",
                      "auto_array" : auto_array] as [String: Any]
        
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
                    let noRange = PriceRange2(idPriceRange: "0", range: "All")
                    self.priceRangeArray.append(noRange)
                    for price in priceArray {
                        let range = PriceRange2(idPriceRange: price["id_rango"].string!, range: price["rango"].string!)
                        self.priceRangeArray.append(range)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.priceRangeArray)
                }
            }
        })
    }
    
    // Refresh Lista De Autos Table
    func refreshListaDeAutosCollectionView(withData tableData: [NSObject]){
        collectionViewData = tableData
        collectionView.reloadData()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return autos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AutoCell {
            
            var modelNumber : String
            if let variableName = self.auto_array_with_number[indexPath.item] { // If casting, use, eg, if let var = abc as? NSString
                modelNumber = variableName
            }
            else{
                //self.activityIndicator.startAnimating()
                modelNumber = "Loading..."
            }
            cell.image = autos[indexPath.item]
            cell.text = "(\(modelNumber) Modelos)"
            return cell
        } else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedBrand = indexPath.item
        let carBrandDetailsVC = CarBrandDetailsViewController()
        carBrandDetailsVC.selectedBrand = selectedBrand
        carBrandDetailsVC.selectedPriceRangeId = self.idPriceRange
        carBrandDetailsVC.rangeButton.setTitle(self.rangeButton.title(for: .normal), for: .normal)
        navigationController?.pushViewController(carBrandDetailsVC, animated: true)
    }
}

extension ListaDeAutos: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width * 0.5) - 10
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}
