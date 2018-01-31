//
//  ConfirmacionViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 8/2/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class ConfirmacionViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var resumenDeCompraData = [NSObject]()
    var resumenDeCompraModelData = [ResumenDeComprarModel]()
    
    var totalBill: Float! = 0.00
    var selectedCotozaciones: String!
    let cellId = "resumenDeCompraCell"
    let resumenDeCompraVC = ResumenDeCompraViewController()
    
    let shippingCartIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "shipping-cart")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let enlightenedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(red:0.63, green:0.78, blue:0.21, alpha:1.0).cgColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nonEnlightenedLabelOne: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0).cgColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let shippingDoneIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "shipping-cart-done")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nonEnlightenedLabelTwo: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0).cgColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let walletIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "wallet")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let confirmacionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = DEEP_BLUE_COLOR
        label.font = UIFont(name: TEXT_FONT, size: 28)
        label.text = "Confirmación"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let horizontalLineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(red:0.02, green:0.09, blue:0.31, alpha:1.0).cgColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let goToPageButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Siguiente > Paso 3", for: .normal)
        button.setTitleColor(DEEP_BLUE_COLOR, for: .normal)
        button.backgroundColor = GREEN_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleGoToPage), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 22)
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
    let itbmsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = ""
        label.textColor = .white
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
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //customize the navigation bar
        customizeNavigationBar()
        
        // registering the table view
        tableView.register(ResumenDeCompraCell.self, forCellReuseIdentifier: cellId)
        
        //setup view
        setUpUI()

        //get data from api
        getOffersFromSelectedCotizacion()
    }
    func customizeNavigationBar(){
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Proceso De Compra"
        
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
        enlightenedLabel.layer.cornerRadius = enlightenedLabel.frame.height / 2
        nonEnlightenedLabelOne.layer.cornerRadius = nonEnlightenedLabelOne.frame.height / 2
        nonEnlightenedLabelTwo.layer.cornerRadius = nonEnlightenedLabelTwo.frame.height / 2
    }
    func handleGoToPage(){
        let finalizarVC = FinalizarCompraViewController()
        finalizarVC.totalBill = self.totalBill!
        finalizarVC.selectedCotizacionID = self.selectedCotozaciones!
        self.navigationController?.pushViewController(finalizarVC, animated: true)
    }
    func getOffersFromSelectedCotizacion(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)getOffersFromSelectedCotizacion/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(self.selectedCotozaciones!)") else { return }
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
            self.totalBill = 0.0
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
        setupEnlightenedLabel()
        setupShipphingCartDoneIconView()
        setupNonEnlightenedLabelOne()
        setupShipphingCartIconView()
        setupNonEnlightenedLabelTwo()
        setupWalletIconView()
        setupConfirmacionLabel()
        setupGoToPageButton()
        setupHorizontalLineLabel()
        setupTotalBillTitleLabel()
        setupTotalBillLabel()
        setupITBMSLabel()
        setupTableView()
        setupActivityIndicator()
    }
    func setupEnlightenedLabel(){
        view.addSubview(enlightenedLabel)
        enlightenedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        enlightenedLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        enlightenedLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20).isActive = true
        enlightenedLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20).isActive = true
    }
    func setupShipphingCartDoneIconView(){
        view.addSubview(shippingDoneIconView)
        shippingDoneIconView.topAnchor.constraint(equalTo: enlightenedLabel.topAnchor, constant: 12).isActive = true
        shippingDoneIconView.leftAnchor.constraint(equalTo: enlightenedLabel.leftAnchor, constant: 15).isActive = true
        shippingDoneIconView.rightAnchor.constraint(equalTo: enlightenedLabel.rightAnchor, constant: -9).isActive = true
        shippingDoneIconView.bottomAnchor.constraint(equalTo: enlightenedLabel.bottomAnchor, constant: -12).isActive = true
    }
    func setupNonEnlightenedLabelOne(){
        view.addSubview(nonEnlightenedLabelOne)
        nonEnlightenedLabelOne.centerYAnchor.constraint(equalTo: enlightenedLabel.centerYAnchor).isActive = true
        nonEnlightenedLabelOne.rightAnchor.constraint(equalTo: enlightenedLabel.leftAnchor, constant: -15).isActive = true
        nonEnlightenedLabelOne.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        nonEnlightenedLabelOne.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
    }
    func setupShipphingCartIconView(){
        view.addSubview(shippingCartIconView)
        shippingCartIconView.topAnchor.constraint(equalTo: nonEnlightenedLabelOne.topAnchor, constant: 7).isActive = true
        shippingCartIconView.leftAnchor.constraint(equalTo: nonEnlightenedLabelOne.leftAnchor, constant: 7).isActive = true
        shippingCartIconView.rightAnchor.constraint(equalTo: nonEnlightenedLabelOne.rightAnchor, constant: -7).isActive = true
        shippingCartIconView.bottomAnchor.constraint(equalTo: nonEnlightenedLabelOne.bottomAnchor, constant: -7).isActive = true
    }
    func setupNonEnlightenedLabelTwo(){
        view.addSubview(nonEnlightenedLabelTwo)
        nonEnlightenedLabelTwo.centerYAnchor.constraint(equalTo: enlightenedLabel.centerYAnchor).isActive = true
        nonEnlightenedLabelTwo.leftAnchor.constraint(equalTo: enlightenedLabel.rightAnchor, constant: 15).isActive = true
        nonEnlightenedLabelTwo.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        nonEnlightenedLabelTwo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
    }
    func setupWalletIconView(){
        view.addSubview(walletIconView)
        walletIconView.topAnchor.constraint(equalTo: nonEnlightenedLabelTwo.topAnchor, constant: 7).isActive = true
        walletIconView.leftAnchor.constraint(equalTo: nonEnlightenedLabelTwo.leftAnchor, constant: 7).isActive = true
        walletIconView.rightAnchor.constraint(equalTo: nonEnlightenedLabelTwo.rightAnchor, constant: -7).isActive = true
        walletIconView.bottomAnchor.constraint(equalTo: nonEnlightenedLabelTwo.bottomAnchor, constant: -7).isActive = true
    }
    func setupConfirmacionLabel(){
        view.addSubview(confirmacionLabel)
        confirmacionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmacionLabel.topAnchor.constraint(equalTo: enlightenedLabel.bottomAnchor, constant: 15).isActive = true
    }
    
    func setupGoToPageButton(){
        view.addSubview(goToPageButton)
        goToPageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        goToPageButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        goToPageButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        goToPageButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    func setupHorizontalLineLabel(){
        view.addSubview(horizontalLineLabel)
        horizontalLineLabel.bottomAnchor.constraint(equalTo: goToPageButton.topAnchor).isActive = true
        horizontalLineLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalLineLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalLineLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.006).isActive = true
    }
    func setupTotalBillTitleLabel(){
        view.addSubview(totalBillTitleLabel)
        totalBillTitleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        totalBillTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        totalBillTitleLabel.bottomAnchor.constraint(equalTo: horizontalLineLabel.topAnchor).isActive = true
        totalBillTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    func setupTotalBillLabel(){
        view.addSubview(totalBillLabel)
        totalBillLabel.heightAnchor.constraint(equalTo: totalBillTitleLabel.heightAnchor, multiplier: 1).isActive = true
        totalBillLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        totalBillLabel.bottomAnchor.constraint(equalTo: horizontalLineLabel.topAnchor).isActive = true
        totalBillLabel.leftAnchor.constraint(equalTo: totalBillTitleLabel.rightAnchor).isActive = true
    }
    func setupITBMSLabel(){
        view.addSubview(itbmsLabel)
        itbmsLabel.heightAnchor.constraint(equalTo: totalBillTitleLabel.heightAnchor, multiplier: 1).isActive = true
        itbmsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        itbmsLabel.bottomAnchor.constraint(equalTo: horizontalLineLabel.topAnchor).isActive = true
        itbmsLabel.leftAnchor.constraint(equalTo: totalBillLabel.rightAnchor).isActive = true
    }
    func setupTableView(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: confirmacionLabel.bottomAnchor, constant: 15).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: itbmsLabel.topAnchor).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
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
 
    //Table delegate and datasource methods
    
    // Refresh Cotizacion Table
    func refreshCotizacionTable(withData tableData: [NSObject]){
        resumenDeCompraData = tableData
        tableView.reloadData()
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
                cell.carIcon      = #imageLiteral(resourceName: "car")
                cell.calendarIcon = #imageLiteral(resourceName: "calendar")
                cell.keyIcon      = #imageLiteral(resourceName: "car-key")
                cell.crossIcon    = #imageLiteral(resourceName: "minus-black")
                cell.marca        = "\(data[indexPath.row].marca)"
                cell.model        = "\(data[indexPath.row].model)"
                cell.year         = "\(data[indexPath.row].year)"
                cell.articleTitle = "\(data[indexPath.row].atricleTitle)"
                cell.status       = "\(data[indexPath.row].status)"
                cell.valor        = "\(data[indexPath.row].valor)"
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

