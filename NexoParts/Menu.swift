//
//  Menu.swift
//  NexoParts
//
//  Created by Creativeitem on 5/29/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit

class Menu: NSObject {
    
    var homeController = HomeViewController()
    var companyHomeController = CompanyHomeViewController()
    var misVentasViewComtroller = MisVentasViewController()
    var loggedInUserType : String!
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.9)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = MENU_BG_COLOR
        view.clipsToBounds = true
        return view
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: BOLD_TEXT_FONT, size: 22)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let copyrightLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let copyrightLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
        table.separatorColor = UIColor.black
        table.clipsToBounds = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    let cellId = "MenuCell"
    let clientMenuItems = ["Cotizaciones", "Mis Compras", "Datos de Usuario", "Lista de Autos", "Log out"]
    let clientMenuIcons = [#imageLiteral(resourceName: "clipboard"), #imageLiteral(resourceName: "shopping-cart"), #imageLiteral(resourceName: "settings"), #imageLiteral(resourceName: "car"), #imageLiteral(resourceName: "logout")]
    let companyMenuItems = ["Cotizaciones", "Mis Ventas", "Datos de Usuario", "log out"]
    let companyMenuIcons = [#imageLiteral(resourceName: "padnote"), #imageLiteral(resourceName: "presentation"), #imageLiteral(resourceName: "profile"), #imageLiteral(resourceName: "power")]
    
    override init() {
        self.loggedInUserType = UserDefaults.standard.value(forKey: USER_ROLE) as! String
        super.init()
        tableView.register(MenuCell.self, forCellReuseIdentifier: cellId)
    }
    
    func show() {
        setupSubViews()
    }
    
    func setupSubViews() {
        // adding the background view
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 1
            })
            // constraints
            backgroundView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
            backgroundView.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
            backgroundView.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
            backgroundView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
            
            // adding the container view
            setupContainerView(window: window)
        }
    }
    
    func setupContainerView(window: UIWindow) {
        window.addSubview(containerView)
        let width = window.frame.width * 0.85
        containerView.frame = CGRect(x: -window.frame.width, y: 0, width: width, height: window.frame.height)
        
        setupLogoImageView()
        setupNameLabel()
        setupCopyrightLabels()
        setupTableView()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.containerView.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height)
        }, completion: nil)
    }
    
    func setupLogoImageView() {
        containerView.addSubview(logoImageView)
        let width = containerView.frame.width * 0.55
        logoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: width / 1.43).isActive = true
    }
    
    func setupNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.text = "\(UserDefaults.standard.value(forKey: FIRST_NAME) as! String) \(UserDefaults.standard.value(forKey: LAST_NAME) as! String)"
        nameLabel.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 0).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    func setupCopyrightLabels() {
        containerView.addSubview(copyrightLabel2)
        copyrightLabel2.text = "Centro de soporte y ayuda"
        copyrightLabel2.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
        copyrightLabel2.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        copyrightLabel2.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9).isActive = true
        copyrightLabel2.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        containerView.addSubview(copyrightLabel1)
        copyrightLabel1.text = "Todos los derechos reservados   |   2017"
        copyrightLabel1.centerXAnchor.constraint(equalTo: copyrightLabel2.centerXAnchor).isActive = true
        copyrightLabel1.bottomAnchor.constraint(equalTo: copyrightLabel2.topAnchor, constant: -10).isActive = true
        copyrightLabel1.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9).isActive = true
        copyrightLabel1.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    func setupTableView() {
        containerView.addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: copyrightLabel1.topAnchor, constant: -20).isActive = true
        tableView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    func hide() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.containerView.frame = CGRect(x: -window.frame.width, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
    
}

extension Menu: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.loggedInUserType == "3"){
            return clientMenuItems.count
        }
        else{
            return companyMenuItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MenuCell {
            if(self.loggedInUserType == "3"){
                cell.icon = clientMenuIcons[indexPath.row]
                cell.titleText = clientMenuItems[indexPath.row]
            }
            if(self.loggedInUserType == "1" || self.loggedInUserType == "2"){
                cell.icon = companyMenuIcons[indexPath.row]
                cell.titleText = companyMenuItems[indexPath.row]
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hide()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            if(self.loggedInUserType == "1" || self.loggedInUserType == "2"){
                self.companyHomeController.selctedMenuItem = self.companyMenuItems[indexPath.row]
                self.companyHomeController.action()
                self.misVentasViewComtroller.selctedMenuItem = self.companyMenuItems[indexPath.row]
                self.misVentasViewComtroller.action()
            }
            else{
                self.homeController.selctedMenuItem = self.clientMenuItems[indexPath.row]
                self.homeController.action()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.15
    }
    
}

