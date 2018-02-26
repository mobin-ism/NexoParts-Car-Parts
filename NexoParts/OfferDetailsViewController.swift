//
//  OfferDetailsViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 7/10/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class OfferDetailsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // new variables for green dot button
    var selectedPrice : String!
    var isSelectedButton : Int! = 0
    var toggleButton : Int! = 0
    
    var addedFlag: Bool = false
    var isSelected : Int!
    var offerId : String?
    var selectedOffer : String!
    var selcectedCotizacion : String!
    var offerDetails = [NSObject]()
    var offerArray   = [selectOfferModel]()
    
    var idDetalle : String!
    // ooferIDTrack is an array for tracking if the offer is already added or not
    var offerIDTrack = [String]()
    var checkStatus:String!
    let yeah:String = "Not Exists"
    var somestring: String? = "0.00" {
        didSet {
            adapt()
        }
    }
    var buttoncolor: UIColor? = UIColor(red:0.26, green:0.26, blue:0.26, alpha:1.0) {
        didSet {
            adapt()
        }
    }
    
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
    let addButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Agregar", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        //button.backgroundColor = UIColor(red:0.26, green:0.26, blue:0.26, alpha:1.0)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showAddedModal), for: .touchUpInside)
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
    let totalBillLabel: UILabel = {
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
    
    lazy var selectOfferCell: SelectOfferCell = {
        let cell = SelectOfferCell()
        cell.offerDetailsVC = self
        return cell
    }()
    
    func assign( bill : String!){
        let bill = bill
        DispatchQueue.main.async(execute: {
            self.totalBillLabel.text = bill!
            //print("total Bill: \(self.totalBillLabel.text!)")
        })
    }
    func adapt() {
        DispatchQueue.main.async(execute: {
            //self.totalBillLabel.text = "\(self.somestring!)"
            self.addButton.backgroundColor = self.buttoncolor
        })
    }
    
    let cellId = "SelectOfferCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapt()
        self.cotizacionNoLabel.text = "# \(self.selcectedCotizacion!)"
        
        //customize the navigation bar
        customizeNavigationBar()
        
        // registering the table view
        tableView.register(SelectOfferCell.self, forCellReuseIdentifier: cellId)
        
        //seting up the sub views
        setupUI()
        
        // Get the offer details data
        getOfferDetailsFromApi()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.layer.cornerRadius = addButton.frame.height / 2
    }
    func setupUI(){
        setupCotizacionTitleLabel()
        setupCotizacionNumberLabel()
        setupAddButton()
        setupTableView()
        setupTotalBillTitleLabel()
        setupTotalBillLabel()
        setupActivityIndicator()
    }
    
    func setupCotizacionTitleLabel(){
        view.addSubview(cotizacionNoTitleLabel)
        cotizacionNoTitleLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        cotizacionNoTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
    }
    func setupCotizacionNumberLabel(){
        view.addSubview(cotizacionNoLabel)
        cotizacionNoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cotizacionNoLabel.topAnchor.constraint(equalTo: cotizacionNoTitleLabel.bottomAnchor, constant: 5).isActive = true
    }
    func setupAddButton(){
        view.addSubview(addButton)
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: cotizacionNoLabel.bottomAnchor, constant: 10).isActive = true
        addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        addButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    func setupTableView(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 15).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    // Fetching data from API
    func getOfferDetailsFromApi(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)offerDetails/\(self.selectedOffer!)") else { return }
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
            //print(response)
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let offerDetailsArray = json.array {
                    for offer in offerDetailsArray {
                        let offerDetails = selectOfferModel(carName: offer["car_name"].string!, offerStatus: offer["offer_status"].string!, offerPrice: offer["price"].string!, offerEstado: offer["estado"].string!, offerPieza: offer["pieza"].string!, offerGarantia: offer["garantia"].string!, articleTitle: offer["article_title"].string!, cantidad: offer["cantidad"].string!, comentario: offer["comentario"].string!, tiempoDeEntrega: offer["tiempo_entrega"].string!, articleImage: offer["article_image"].string!, offerImageOne: offer["offer_image_1"].string!, offerImageTwo: offer["offer_image_2"].string!)
                        self.offerArray.append(offerDetails)
                        self.offerIDTrack.append(offer["offer_id"].string!)
                        // asigning selected offer id on session value
                        UserDefaults.standard.set(offer["offer_id"].string, forKey: OFFER_ID)
                        UserDefaults.standard.set(self.selcectedCotizacion, forKey: SELECTED_COTIZACION)
                    }
                    self.refreshCarModelsTable(withData: self.offerArray)
                    self.activityIndicator.stopAnimating()
                    
                    self.isAdded(_offerId: UserDefaults.standard.value(forKey: OFFER_ID) as! String)
                }
            }
        })
    }
    
    func handleAddButton(){
        if(self.isSelectedButton == 1){
            self.showAddedModal()
        }
    }
    
    func changeTotalBillLabel(withString price: String) {
        totalBillLabel.text = price
        print("Total Price is: ")
        print(price)
    }
    
    func showAddedModal(){
        if(self.toggleButton == 1){
            self.addToCart()
            let modalController = AddedToMisComprasAlertViewController()
            modalController.modalPresentationStyle = .overCurrentContext
            present(modalController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    // Tasks after clicking green dot button starts from here
    func handleGreenbutton(){
        if(self.toggleButton == 0){
            self.addButton.backgroundColor = UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0)
            self.totalBillLabel.text = self.selectedPrice
            self.toggleButton = 1
        }
        else{
            self.addButton.backgroundColor = UIColor(red:0.26, green:0.26, blue:0.26, alpha:1.0)
            self.toggleButton = 0
            self.totalBillLabel.text = "0.00"
            self.removeFromCart()
        }
    }
    
    func addToCart(){
        guard let url = URL(string: "\(API_URL)add_to_cart/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(UserDefaults.standard.value(forKey: OFFER_ID) as! String)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                return
            }
            print(response)
        })
    }
    
    func removeFromCart(){
        guard let url = URL(string: "\(API_URL)remove_from_cart/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(UserDefaults.standard.value(forKey: OFFER_ID) as! String)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                return
            }
            print(response)
        })
    }
    // Tasks after clicking green dot button ends here
    
    
    // Refresh Cotizacion Table
    func refreshCarModelsTable(withData tableData: [NSObject]){
        offerDetails = tableData
        tableView.reloadData()
    }
    // Delegate and Datasource functionalities
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offerDetails.count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SelectOfferCell {
            if let data = offerDetails as? [selectOfferModel] {
                //let imageurl = "\(BASE_URL)uploads/article_image_no_\(self.idDetalle!).jpg"
                //cell.carImageView.sd_setImage(with: URL(string: imageurl), placeholderImage: #imageLiteral(resourceName: "carModelImage"), options: [.continueInBackground, .progressiveDownload])
                //cell.carModelImage = #imageLiteral(resourceName: "carModelImage")
                
                let imageData = NSData(base64Encoded: data[indexPath.row].articleImage, options: NSData.Base64DecodingOptions(rawValue: 0))
                cell.carModelImage = UIImage(data:imageData! as Data,scale:1.0)
                cell.carIcon       = #imageLiteral(resourceName: "car")
                cell.carModelName  = "\(data[indexPath.row].carName)"
                cell.offerPrice    = "\(data[indexPath.row].offerPrice)"
                cell.offerStatus   = "\(data[indexPath.row].offerStatus)"
                cell.estado        = "\(data[indexPath.row].offerEstado)"
                cell.pieza         = "\(data[indexPath.row].offerPieza)"
                cell.garantia      = "\(data[indexPath.row].offerGarantia)"
                self.selectedPrice = "\(data[indexPath.row].offerPrice)"
                
                if addedFlag {
                    cell.selectGreenDotButton.setTitleColor(UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0), for: .normal)
                    self.toggleButton = 1
                } else {
                    cell.selectGreenDotButton.setTitleColor(GRAY_COLOR, for: .normal)
                    self.toggleButton = 0
                }
                cell.selectGreenDotButton.addTarget(self, action: #selector(self.handleGreenbutton), for: .touchUpInside)
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = "Articulo: " + self.offerArray[indexPath.row].articleTitle + "\nPrecio: " + self.offerArray[indexPath.row].offerPrice + "\nEstado: " + self.offerArray[indexPath.row].offerEstado + "\nGarantía: " + self.offerArray[indexPath.row].offerGarantia + "\nPieza: " + self.offerArray[indexPath.row].offerPieza + "\nCantidad: " + self.offerArray[indexPath.row].cantidad + "\nComentarios: " + self.offerArray[indexPath.row].comentario + "\nTiempo De Entrega: " + self.offerArray[indexPath.row].tiempoDeEntrega
        self.showAlert(mesage: message)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    //the details showing alert
    func showAlert(mesage : String!){
        let showMessage : String! = mesage
        // Create the alert controller
        let alertController = UIAlertController(title: "Seleccionar", message: "", preferredStyle: .alert)
        
        // Create the actions
        let verDetalleAction = UIAlertAction(title: "Ver Imagen", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.showImageAlert()
            print("Ver Imagen")
        }
        let aplicarAction = UIAlertAction(title: "Detalles", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("Detalles")
            self.showDetailsAlert(showMesage: showMessage)
        }
        
        // Add the actions
        alertController.addAction(verDetalleAction)
        alertController.addAction(aplicarAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    //the details showing alert
    func showDetailsAlert(showMesage : String!){
        // Create the alert controller
        let alertController = UIAlertController(title: "Detalle", message: showMesage, preferredStyle: .alert)
        
        // Create the actions
        let OkayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        
        // Add the actions
        alertController.addAction(OkayAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    //show image alert
    func showImageAlert(){
        // Create the alert controller
        /*let imageurl1 = "\(BASE_URL)uploads/offer_image_no_\(self.selectedOffer!)_1.jpg"
        let imageurl2 = "\(BASE_URL)uploads/offer_image_no_\(self.selectedOffer!)_2.jpg"
        print(imageurl1)
        print(imageurl2)*/
        let modalController = OfferImageOnAlert()
        /*modalController.imageViewOne.sd_setImage(with: URL(string: imageurl1), placeholderImage: #imageLiteral(resourceName: "noImagePlaceHolder"), options: [.continueInBackground, .progressiveDownload])
        modalController.imageViewTwo.sd_setImage(with: URL(string: imageurl2), placeholderImage: #imageLiteral(resourceName: "noImagePlaceHolder"), options: [.continueInBackground, .progressiveDownload])*/
        let imageData1 = NSData(base64Encoded: self.offerArray[0].offerImageOne, options: NSData.Base64DecodingOptions(rawValue: 0))
        modalController.imageViewOne.image = UIImage(data:imageData1! as Data,scale:1.0)
        let imageData2 = NSData(base64Encoded: self.offerArray[0].offerImageTwo, options: NSData.Base64DecodingOptions(rawValue: 0))
        modalController.imageViewTwo.image = UIImage(data:imageData2! as Data,scale:1.0)
        modalController.modalPresentationStyle = .overCurrentContext
        present(modalController, animated: true, completion: nil)
    }
    
    //checking if the offer is added
    func isAdded(_offerId : String!){
        guard let url = URL(string: "\(API_URL)is_added_to_cart/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(self.selcectedCotizacion!)/\(_offerId!)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response.result)
                return
            }
            self.checkStatus = response.result.value!
            if self.checkStatus == "Exists" {
                self.toggleButton = 1
                self.selectOfferCell.toggleColor = 1
                self.addButton.backgroundColor = UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0)
                self.totalBillLabel.text = self.selectedPrice
                self.addedFlag = true
                self.tableView.reloadData()
            }
            else{
                print("Not Added")
                print(self.selcectedCotizacion!)
                print(_offerId!)
            }
        })
    }
    
    
}

