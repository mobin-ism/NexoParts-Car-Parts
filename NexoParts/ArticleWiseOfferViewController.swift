//
//  ArticleWiseOfferViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 12/14/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire

class ArticleWiseOfferViewController: UIViewController {
    var selectedCotizacionID = ""
    var articleWiseOffersData = [NSObject]()
    var articleWiseOffersArray = [ArticleWiseOfferModel]()
    
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
    
    let cellId = "ArticleWiseOfferCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cotizacionNoLabel.text = "# \(self.selectedCotizacionID)"
        //customize the navigation bar
        customizeNavigationBar()
        
        //Setting up the UI
        setupUI()
        
        // registering the table view
        tableView.register(ArticleWiseOfferCell.self, forCellReuseIdentifier: cellId)
        
        // api call
        getArticlesFromAPI()
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
    func setupUI(){
        setupCotzacionTitleLabel()
        setupCotzacionLabel()
        setupTableView()
        setupActivityIndicator()
    }
    
    func setupCotzacionTitleLabel(){
        view.addSubview(cotizacionNoTitleLabel)
        cotizacionNoTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cotizacionNoTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
    }
    func setupCotzacionLabel(){
        view.addSubview(cotizacionNoLabel)
        cotizacionNoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cotizacionNoLabel.topAnchor.constraint(equalTo: cotizacionNoTitleLabel.bottomAnchor, constant: 5).isActive = true
    }
    func setupTableView(){
        view.addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: cotizacionNoLabel.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
}

// api calls
extension ArticleWiseOfferViewController {
    func getArticlesFromAPI(){
        // Fetching the modelo datas
        activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_articles_using_cotizacion_id/\(self.selectedCotizacionID)") else { return }
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
            if !self.articleWiseOffersData.isEmpty{
                self.articleWiseOffersData.removeAll()
            }
            print(response)
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let articlesArray = json.array {
                    for article in articlesArray {
                        //print(marca)
                        let articleDetails = ArticleWiseOfferModel(articleTitle: article["article_title"].string!, cantidad: article["cantidad"].string!, price: article["price"].string!, detalle_id: article["id_detalle"].string!)
                        self.articleWiseOffersArray.append(articleDetails)
                    }
                    
                    self.activityIndicator.stopAnimating()
                    self.refreshCarModelsTable(withData: self.articleWiseOffersArray)
                }
            }
        })
    }
}

extension ArticleWiseOfferViewController : UITableViewDelegate, UITableViewDataSource{
    // Refresh Cotizacion Table
    func refreshCarModelsTable(withData tableData: [NSObject]){
        articleWiseOffersData = tableData
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleWiseOffersData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ArticleWiseOfferCell {
            if let data = articleWiseOffersData as? [ArticleWiseOfferModel] {
                cell.article = "\(data[indexPath.row].articleTitle)"
                cell.cantidad = "\(data[indexPath.row].cantidad)"
                cell.price = "\(data[indexPath.row].price)"
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = articleWiseOffersData as? [ArticleWiseOfferModel] {
            let ofertasVC = OfertasViewController()
            ofertasVC.selectedCotizacionID = self.selectedCotizacionID
            ofertasVC.idDetalle = data[indexPath.row].detalle_id
            navigationController?.pushViewController(ofertasVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
