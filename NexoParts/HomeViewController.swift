//
//  ViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 5/29/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	
	var navBounds: CGRect!
	var selctedMenuItem : String!
	
	
	
	lazy var topButton: ImageLabelView = {
		let view = ImageLabelView()
		view.bgColor = GREEN_COLOR
		view.image = #imageLiteral(resourceName: "clipboard")
		view.title = "Cotizar"
		view.titleColor = .black
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTopButton)))
		return view
	}()
	
	lazy var leftButton: ImageLabelView = {
		let view = ImageLabelView()
		view.bgColor = GRAY_COLOR
		view.image = #imageLiteral(resourceName: "shopping-cart")
		view.title = "Mis Compras"
		view.titleColor = .black
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLeftButton)))
		return view
	}()
	
	lazy var rightButton: ImageLabelView = {
		let view = ImageLabelView()
		view.bgColor = GRAY_COLOR
		view.image = #imageLiteral(resourceName: "car")
		view.title = "Lista de Autos"
		view.titleColor = .black
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRightButton)))
		return view
	}()
	
	lazy var supportButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Soporte y Ayuda", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.backgroundColor = DEEP_BLUE_COLOR
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(handleSupportButton), for: .touchUpInside)
		return button
	}()
	
	let welcomeLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = UIColor.black
		label.text = "Bienvenido/a"
		label.font = UIFont(name: TEXT_FONT, size: 20)
		label.clipsToBounds = true
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = UIColor.black
		label.font = UIFont(name: BOLD_TEXT_FONT, size: 24)
		label.clipsToBounds = true
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var menu: Menu = {
		let slideMenu = Menu()
		slideMenu.homeController = self
		return slideMenu
	}()
	
	var selector = Selector()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print(UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String)
		print(UserDefaults.standard.value(forKey: USER_ID) as! String)
		print(UserDefaults.standard.value(forKey: FIRST_NAME) as! String)
		print(UserDefaults.standard.value(forKey: LAST_NAME) as! String)
		print(UserDefaults.standard.value(forKey: LOGGED_IN_USER_MAIL) as! String)
		print(UserDefaults.standard.value(forKey: USER_ROLE) as! String)
		print(UserDefaults.standard.value(forKey: CELULAR) as! String)
		print(UserDefaults.standard.value(forKey: TELEFONO) as! String)
		view.backgroundColor = BG_COLOR
		navBounds = navigationController!.navigationBar.bounds
		setupUI()
		
		if isLoggedIn() {
			print("logged in")
			return
		}
		DispatchQueue.main.async {
			self.navigationController?.pushViewController(LoginViewController(), animated: true)
			//self.present(LoginViewController(), animated: true, completion: nil)
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		supportButton.titleLabel?.font = UIFont(name: TEXT_FONT, size: supportButton.frame.height * 0.2)
		setupNavBar()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.barTintColor = UIColor.white
		if UserDefaults.standard.bool(forKey: LOGGED_IN) {
			nameLabel.text = "\(UserDefaults.standard.value(forKey: FIRST_NAME) as! String) \(UserDefaults.standard.value(forKey: LAST_NAME) as! String)"
		}
	}
	
	func isLoggedIn() -> Bool {
		if UserDefaults.standard.bool(forKey: LOGGED_IN) {
			return true
		}
		else{
				print("not Looged")
				return false
		}
	}
	
	func setupNavBar() {
		// replacing the center title label of nav bar with an uiimage
		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: (navBounds.height) * 2, height: (navBounds.height)))
		imageView.image = #imageLiteral(resourceName: "logoNav")
		imageView.contentMode = .scaleAspectFit
		navigationItem.titleView = imageView
		// setup the left menu icon inside nav bar and place a right blank menu item to center the logo image (if the logo is 44x44, there will be no need of placing a right bar item)
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleMenuButton))
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menuBlank"), style: .plain, target: nil, action: nil)
	}
	
	func setupUI() {
		setupWelcomeLabel()
		setupNameLabel()
		setupTopButton()
		setupLeftButton()
		setupRightButton()
		setupSupportButton()
	}
	
	func setupWelcomeLabel() {
		view.addSubview(welcomeLabel)
		// constraints
		welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (navBounds.height + 40)).isActive = true
		welcomeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
	}
	
	func setupNameLabel() {
		view.addSubview(nameLabel)
		// constraints
		nameLabel.centerXAnchor.constraint(equalTo: welcomeLabel.centerXAnchor).isActive = true
		nameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 0).isActive = true
		nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
	}
	
	func setupTopButton() {
		view.addSubview(topButton)
		// constraints
		topButton.centerXAnchor.constraint(equalTo: welcomeLabel.centerXAnchor).isActive = true
		topButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 54).isActive = true
		topButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
		topButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18).isActive = true
	}
	
	func setupLeftButton() {
		view.addSubview(leftButton)
		// constraints
		leftButton.leftAnchor.constraint(equalTo: topButton.leftAnchor).isActive = true
		leftButton.topAnchor.constraint(equalTo: topButton.bottomAnchor, constant: 10).isActive = true
		leftButton.widthAnchor.constraint(equalTo: topButton.widthAnchor, multiplier: 0.48).isActive = true
		leftButton.heightAnchor.constraint(equalTo: topButton.widthAnchor, multiplier: 0.48).isActive = true
	}
	
	func setupRightButton() {
		view.addSubview(rightButton)
		// constraints
		rightButton.rightAnchor.constraint(equalTo: topButton.rightAnchor).isActive = true
		rightButton.topAnchor.constraint(equalTo: topButton.bottomAnchor, constant: 10).isActive = true
		rightButton.widthAnchor.constraint(equalTo: topButton.widthAnchor, multiplier: 0.48).isActive = true
		rightButton.heightAnchor.constraint(equalTo: topButton.widthAnchor, multiplier: 0.48).isActive = true
	}
	
	func setupSupportButton() {
		view.addSubview(supportButton)
		// constranits
		supportButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		supportButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		supportButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		supportButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
	}
	
	func handleMenuButton() {
		menu.show()
	}
	
	func handleTopButton() {
		navigationController?.pushViewController(CotizacionesViewController(), animated: true)
		//selector.show()
	}
	
	func handleLeftButton() {
		navigationController?.pushViewController(ListaDeComprasViewController(), animated: true)
	}
	
	func handleRightButton() {
		navigationController?.pushViewController(ListaDeAutos(), animated: true)
	}
	
	func handleSupportButton() {
		guard let url = URL(string: "http://www.nexoparts.com/contacto.php") else {
			return
		}
		if UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		}
	}
	
	func action() {
		if(self.selctedMenuItem == "Cotizaciones"){
			navigationController?.pushViewController(CotizacionesViewController(), animated: true)
		}
		if(self.selctedMenuItem == "Mis Compras"){
			navigationController?.pushViewController(ListaDeComprasViewController(), animated: true)
		}
		if(self.selctedMenuItem == "Datos de Usuario"){
			navigationController?.pushViewController(EditarDatosViewController(), animated: true)
		}
		if(self.selctedMenuItem == "Lista de Autos"){
			navigationController?.pushViewController(ListaDeAutos(), animated: true)
		}
		if(self.selctedMenuItem == "Log out"){
			UserDefaults.standard.set(false, forKey: LOGGED_IN)
			self.navigationController?.pushViewController(LoginViewController(), animated: true)
		}
	}
}

