//
//  CarBrandDetailsViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 7/4/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class CarBrandDetailsViewController : UIViewController{
    
    var selectedBrand : Int!
    let autos = [#imageLiteral(resourceName: "toyota"), #imageLiteral(resourceName: "KIA_motors"), #imageLiteral(resourceName: "Mazda_logo"), #imageLiteral(resourceName: "mitsubishi"), #imageLiteral(resourceName: "hyundai"), #imageLiteral(resourceName: "Nissan")]
    
    let brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
    let cellId = "CarBrandDetailsCell"
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // setting up the upper image
        self.brandImageView.image = self.autos[self.selectedBrand]
        
        //customize the navigation bar
        customizeNavigationBar()
        
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
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rangeButton.layer.cornerRadius = rangeButton.frame.height / 2
    }
    func setupUi(){
        setupBrnadImageView()
        setupRangeLabel()
        setupRangeSelector()
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
    }
    
    func setupRangeSelector(){
        view.addSubview(rangeButton)
        rangeButton.centerYAnchor.constraint(equalTo: rangoDePrecio.centerYAnchor).isActive = true
        rangeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        rangeButton.leftAnchor.constraint(equalTo: rangoDePrecio.rightAnchor, constant:10).isActive = true
    }
    func handleRange(){
        print("Range Button")
    }
}
