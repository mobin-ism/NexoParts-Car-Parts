//
//  ArticlesOfCotizacionesViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 7/15/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire

class ArticlesOfCotizacionesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var articleData = [NSObject]()
    let cellId = "ArticleCell"
    var articleArray = [ArticleModel]()
    var  cotizacionId : String!
    lazy var agregarOtraPieza: UIButton = {
        let agregar = UIButton(type: .system)
        agregar.setTitle("Agregar Otra Pieza", for: .normal)
        agregar.setTitleColor(UIColor.white, for: .normal)
        agregar.backgroundColor = DEEP_BLUE_COLOR
        agregar.translatesAutoresizingMaskIntoConstraints = false
        agregar.addTarget(self, action: #selector(handleAgregarOtraPieza), for: .touchUpInside)
        agregar.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        agregar.layer.shadowRadius = 2
        agregar.layer.shadowOpacity = 0.8
        agregar.layer.shadowOffset = CGSize(width: 0, height: 3)
        return agregar
    }()
    lazy var cotizarButton: UIButton = {
        let cotizar = UIButton(type: .system)
        cotizar.setTitle("Cotizar", for: .normal)
        cotizar.setTitleColor(UIColor.white, for: .normal)
        cotizar.backgroundColor = GREEN_COLOR
        cotizar.translatesAutoresizingMaskIntoConstraints = false
        cotizar.addTarget(self, action: #selector(handleCotizarButton), for: .touchUpInside)
        cotizar.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        cotizar.layer.shadowRadius = 2
        cotizar.layer.shadowOpacity = 0.8
        cotizar.layer.shadowOffset = CGSize(width: 0, height: 3)
        return cotizar
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
        tableView.register(ArticleCell.self, forCellReuseIdentifier: cellId)
        
        //setupui
        setupUI()
    }
    func customizeNavigationBar(){
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Resumen De Cotizacíon"
        
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
        agregarOtraPieza.layer.cornerRadius = agregarOtraPieza.frame.height / 2
        cotizarButton.layer.cornerRadius = cotizarButton.frame.height / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        get_article_details_from_api()
    }
    func setupUI(){
        setupAgregarOtraPieza()
        setupCotizarButton()
        setupTableView()
        setupActivityIndicator()
    }
    
    func setupAgregarOtraPieza(){
        view.addSubview(agregarOtraPieza)
        agregarOtraPieza.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        agregarOtraPieza.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        agregarOtraPieza.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
    }
    func setupCotizarButton(){
        view.addSubview(cotizarButton)
        cotizarButton.centerYAnchor.constraint(equalTo: agregarOtraPieza.centerYAnchor).isActive = true
        cotizarButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        cotizarButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
    }
    func setupTableView(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: agregarOtraPieza.bottomAnchor, constant: 15).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    func handleAgregarOtraPieza(){
        /*let agregarArticulo = AgregarArticulo()
        agregarArticulo.selectedCotizacionId = self.cotizacionId!
        self.navigationController?.pushViewController(agregarArticulo, animated: true)*/
        self.navigationController?.popViewController(animated: true)
    }
    func handleCotizarButton(){
        self.sendMailAndNotification()
        showSuccessAlert()
    }
    func showSuccessAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "¡¡Felicitaciones!!", message: "Exito, Su Cotización se ha enviado", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Listo", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    //API calls
    func get_article_details_from_api(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_articulos_alpha/\(self.cotizacionId!)") else {return}
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
            if !self.articleArray.isEmpty {
                self.articleArray.removeAll()
            }
            print(response)
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let articleDetailsArray = json.array {
                    for articleDetails in articleDetailsArray {
                        let data = ArticleModel(redNumber: "1", detalleID: articleDetails["id_detalle"].string!, marca: articleDetails["marca"].string! , modelo: articleDetails["modelo"].string!, year: articleDetails["year"].string!, article: articleDetails["article"].string!, chasis: articleDetails["chasis"].string!, valor: articleDetails["year"].string!)
                        self.articleArray.append(data)
                    }
                    self.refreshTable(withData: self.articleArray)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    
    //delete article by tapping cross
    func removeArticleFromCotizacion(tapGestureRecognizer: TapGesture){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)remove_article_from_cotizacion/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(tapGestureRecognizer.tappedOfferId)") else {return}
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
            self.get_article_details_from_api()
        })
    }
    
    // send mail and notifications
    func sendMailAndNotification(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)send_mail_and_push_notification/\(self.cotizacionId!)") else {return}
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
            self.popToCotizacionViewController()
        })
    }
    
    func popToCotizacionViewController(){
        // Popping To view controller
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: CotizacionesViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ArticleCell {
            if let data = articleData as? [ArticleModel] {
                cell.carIcon = #imageLiteral(resourceName: "car")
                cell.keyIcon = #imageLiteral(resourceName: "car-key")
                cell.calendarIcon = #imageLiteral(resourceName: "calendar")
                cell.marca = "\(data[indexPath.row].marca)"
                cell.model = "\(data[indexPath.row].modelo)"
                cell.year = "\(data[indexPath.row].year)"
                cell.articleTitle = "\(data[indexPath.row].article)"
                cell.chasisNumber = "\(data[indexPath.row].chasis)"
                cell.valorTitle = "Valor"
                cell.valor = "N/A"
                cell.crossIcon = #imageLiteral(resourceName: "minus-black")
                cell.redNumber = "\(indexPath.row + 1)"
                let tapGestureRecognizer = TapGesture(target: self, action: #selector(removeArticleFromCotizacion(tapGestureRecognizer:)))
                tapGestureRecognizer.tappedOfferId = "\(data[indexPath.row].detalleID)"
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
}

