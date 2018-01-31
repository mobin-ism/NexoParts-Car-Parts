//
//  OfertaArticulosViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 8/3/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class OfertaArticulosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedCotizacionID = ""
    var articleArray = [OffertaArticulosModel]()
    var detailsArticleForAlert = [DetailsAboutAnArticle]()
    var cotizacionDetalleId = [String]()
    var detalleCotizacionId : String!
    
    var addOfferVC = AddOfferFormViewController()
    //For refreshing the table with this array
    var articleData = [NSObject]()
    var articleDetails : String!
    
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
    let enviarOfertaButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enviar Oferta", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = GREEN_COLOR
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleEnviarOfertaButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
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
    
    let cellId = "OffertaArticulosCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cotizacionNoLabel.text = "# \(self.selectedCotizacionID)"
        //customize the navigation bar
        customizeNavigationBar()
        
        //Setting up the UI
        setupUI()
        
        // registering the table view
        tableView.register(OfertaArticulosCell.self, forCellReuseIdentifier: cellId)
        
        //get offers
        self.get_article_details_from_api()
    }
    func customizeNavigationBar(){
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Ofertar Artículos"
        
            // removes the back title from back button of navigation bar
            let barAppearace = UIBarButtonItem.appearance()
            barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        }
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            enviarOfertaButton.layer.cornerRadius = enviarOfertaButton.frame.height / 2
        }
        func setupUI(){
            setupCotizacionNumberTitleLabel()
            setupCotizacionNumberLabel()
            //setupEnviarOfertaButton()
            //setupTotalBillTitleLabel()
            //setupTotalBillLabel()
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
        func setupEnviarOfertaButton(){
            view.addSubview(enviarOfertaButton)
            enviarOfertaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            enviarOfertaButton.topAnchor.constraint(equalTo: cotizacionNoLabel.bottomAnchor, constant: 10).isActive = true
            enviarOfertaButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
            enviarOfertaButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
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
        totalBillLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        totalBillLabel.leftAnchor.constraint(equalTo: totalBillTitleLabel.rightAnchor).isActive = true
    }
        func setupTableView(){
            view.addSubview(tableView)
            tableView.topAnchor.constraint(equalTo: cotizacionNoLabel.bottomAnchor, constant: 30).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        func setupActivityIndicator() {
            view.addSubview(activityIndicator)
            activityIndicator.stopAnimating()
            activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        }
    
    //Api Calls
    func get_article_details_from_api(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_articulos_alpha/\(self.selectedCotizacionID)") else {return}
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
            if !self.articleArray.isEmpty {
                self.articleArray.removeAll()
            }
            if !self.cotizacionDetalleId.isEmpty {
                self.cotizacionDetalleId.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let articleDetailsArray = json.array {
                    for articleDetails in articleDetailsArray {
                        let data = OffertaArticulosModel(marca: articleDetails["marca"].string!, state: articleDetails["modelo"].string!, year: articleDetails["year"].string!, articulosTitle: articleDetails["article"].string!, chasisNumber: articleDetails["chasis"].string!, idDetalle: articleDetails["id_detalle"].string!, articleImage: articleDetails["article_image"].string!)
                        self.articleArray.append(data)
                        self.cotizacionDetalleId.append(articleDetails["id_detalle"].string!)
                    }
                    self.refreshTable(withData: self.articleArray)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    
    //Api Call For Single Article Details
    func getSingleArticleDetails(detalleCotizacionId : String){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_single_article_details_from_api/\(detalleCotizacionId)") else {return}
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
            if !self.detailsArticleForAlert.isEmpty {
                self.detailsArticleForAlert.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let singleArticleDetailsArray = json.array {
                    for singleArticleDetails in singleArticleDetailsArray {
                        let data = DetailsAboutAnArticle(marca: singleArticleDetails["marca"].string!, details: singleArticleDetails["details"].string!, year: singleArticleDetails["year"].string!, articulosTitle: singleArticleDetails["title"].string!, chasisNumber: singleArticleDetails["chasis"].string!, modelo: singleArticleDetails["modelo"].string!, cantidad: singleArticleDetails["cantidad"].string!)
                        
                        self.detailsArticleForAlert.append(data)
                    }
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    
    
    //alert fuctions
    func showDetailsAlert(){
    // Create the alert controller
    let alertController = UIAlertController(title: "¿Que deseas hacer?", message: "", preferredStyle: .alert)

    // Create the actions
    let verDetalleAction = UIAlertAction(title: "Ver Detalle", style: UIAlertActionStyle.default) {
        UIAlertAction in
        self.showArticleDetailsAlert()
        print("Ver Detalle Pressed")
    }
    let aplicarAction = UIAlertAction(title: "Aplicar", style: UIAlertActionStyle.default) {
        UIAlertAction in
        print("Aplicar Pressed")
        self.addOfferVC.selectedCotizacionId = self.selectedCotizacionID
        self.addOfferVC.selectedDetalleCotizacionId = self.detalleCotizacionId
        self.navigationController?.pushViewController(self.addOfferVC, animated: true)
    }

    // Add the actions
    alertController.addAction(verDetalleAction)
    alertController.addAction(aplicarAction)

    // Present the controller
    self.present(alertController, animated: true, completion: nil)
    }
    
    
    //alert fuctions
    func showArticleDetailsAlert(){
        // Create the alert controller
        var detailsAboutArticle : String!
        for details in self.detailsArticleForAlert{
            detailsAboutArticle = "Article Title: " + details.atriculosTitle + "\nMarca: " + details.marca + "\nModelo: " + details.modelo + "\nYear: " + details.year + "\nCantidad: " + details.cantidad + "\nChasis Number: " + details.chasisNumber + "\n Details: " + details.details
        }
        let alertController = UIAlertController(title: "Detalle", message: detailsAboutArticle, preferredStyle: .alert)
        
        // Create the actions
        let verDetalleAction = UIAlertAction(title: "Salir", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("Salir Pressed")
        }
        let aplicarAction = UIAlertAction(title: "Aplicar", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.addOfferVC.selectedCotizacionId = self.selectedCotizacionID
            self.addOfferVC.selectedDetalleCotizacionId = self.detalleCotizacionId
            self.navigationController?.pushViewController(self.addOfferVC, animated: true)
            print("Aplicar Pressed")
        }
        
        // Add the actions
        alertController.addAction(verDetalleAction)
        alertController.addAction(aplicarAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
            // Refresh Cotizacion Table
            func refreshTable(withData tableData: [NSObject]){
                articleData = tableData
                tableView.reloadData()
            }
            // Delegate and Datasource functionalities
            func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return articleData.count
            //return 10
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? OfertaArticulosCell {
                if let data = articleData as? [OffertaArticulosModel] {
                    //let imageurl = "\(BASE_URL)uploads/article_image_no_\(data[indexPath.row].idDetalle).jpg"
                    //cell.carImageView.sd_setImage(with: URL(string: imageurl), placeholderImage: #imageLiteral(resourceName: "carModelImage"), options: [.continueInBackground, .progressiveDownload])
                    
                    let imageData = NSData(base64Encoded: data[indexPath.row].articleImage, options: NSData.Base64DecodingOptions(rawValue: 0))
                    cell.carImage = UIImage(data:imageData! as Data,scale:1.0)
                    cell.carIcon = #imageLiteral(resourceName: "company_car")
                    cell.searchCarIcon = #imageLiteral(resourceName: "company_car_search")
                    cell.calendarIcon = #imageLiteral(resourceName: "company_calendar")
                    cell.marcaNameText = "\(data[indexPath.row].marca)"
                    cell.stateNameText = "\(data[indexPath.row].state)"
                    cell.yearTxt = "\(data[indexPath.row].year)"
                    cell.articuloTitleText = "\(data[indexPath.row].atriculosTitle)"
                    cell.chasisNumberText = "\(data[indexPath.row].chasisNumber)"
                }
                return cell
            } else {
                let cell = tableView.cellForRow(at: indexPath)!
                return cell
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.detalleCotizacionId = self.cotizacionDetalleId[indexPath.row]
            showDetailsAlert()
            self.articleDetails = cotizacionDetalleId[indexPath.row]
            self.getSingleArticleDetails(detalleCotizacionId: self.articleDetails)
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90
        }
    
    
        func handleEnviarOfertaButton(){
            print("Enviar Oferta Button Pressed")
        }
        
    }

