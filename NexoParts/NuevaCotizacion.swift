//
//  NuevaCotizacion.swift
//  NexoParts
//
//  Created by Creativeitem on 6/12/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class NuevaCotizacion : UIViewController{
    
    let agrerarArticulo = AgregarArticulo()
    
    let nombreClientLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Nombre/Clientes"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var nombreClienteTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = ""
        field.text = "\(UserDefaults.standard.value(forKey: FIRST_NAME) as! String) \(UserDefaults.standard.value(forKey: LAST_NAME) as! String)"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    let celularLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Celular"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var celularTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0)
        field.textAlignment = .center
        field.placeholder = ""
        field.text = UserDefaults.standard.value(forKey: CELULAR) as? String
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.isUserInteractionEnabled = false
        field.isEnabled = false
        //field.delegate = self
        return field
    }()
    let empresaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Empresa"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var empresaTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0)
        field.textAlignment = .center
        field.placeholder = ""
        field.text = "\(UserDefaults.standard.value(forKey: FIRST_NAME) as! String) \(UserDefaults.standard.value(forKey: LAST_NAME) as! String)"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.isEnabled = false
        field.isUserInteractionEnabled = false
        //field.delegate = self
        return field
    }()
    let telefonoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Telefono"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var telefonoTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0)
        field.textAlignment = .center
        field.placeholder = ""
        field.text = UserDefaults.standard.value(forKey: TELEFONO) as? String
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.isEnabled = false
        field.isUserInteractionEnabled = false
        //field.delegate = self
        return field
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Email"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var emailTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0)
        field.textAlignment = .center
        field.placeholder = ""
        field.text = UserDefaults.standard.value(forKey: LOGGED_IN_USER_MAIL) as? String
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.isEnabled = false
        field.isUserInteractionEnabled = false
        //field.delegate = self
        return field
    }()
    
    lazy var agregarProductos: UIButton = {
        let agregarButton = UIButton(type: .system)
        agregarButton.setTitle("Agregar Productos", for: .normal)
        agregarButton.setTitleColor(UIColor.white, for: .normal)
        agregarButton.backgroundColor = GREEN_COLOR
        agregarButton.translatesAutoresizingMaskIntoConstraints = false
        agregarButton.addTarget(self, action: #selector(handleAgregarProductos), for: .touchUpInside)
        agregarButton.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        agregarButton.layer.shadowRadius = 2
        agregarButton.layer.shadowOpacity = 0.8
        agregarButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        return agregarButton
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        activityIndicator.stopAnimating()
        
        // Adding outside tap will dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.value(forKey: USER_ID) as! String)
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Nueva Cotizaciònes"
        
        // removes the back title from back button of navigation bar
        let barAppearace = UIBarButtonItem.appearance()
        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        // Setting up the UI
        setupUi()
        
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
        nombreClienteTextField.layer.cornerRadius = nombreClienteTextField.frame.height / 2
        celularTextField.layer.cornerRadius = celularTextField.frame.height / 2
        empresaTextField.layer.cornerRadius = empresaTextField.frame.height / 2
        telefonoTextField.layer.cornerRadius = telefonoTextField.frame.height / 2
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        agregarProductos.layer.cornerRadius = agregarProductos.frame.height / 2
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //function for dismissing the keyboard
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func setupUi(){
        setUpNombreClienteLabel()
        setUpNombreClienteTextField()
        setUpCelularLabel()
        setUpCelularTextField()
        setUpEmpresaLabel()
        setUpEmpresaTextField()
        setUpTelefonoLabel()
        setUpTelefonoTextField()
        setUpEmailLabel()
        setUpEmailTextField()
        setUpAgregarProductos()
        setupActivityIndicator()
    }
    
    func setUpNombreClienteLabel(){
        view.addSubview(nombreClientLabel)
        //constraints
        nombreClientLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        nombreClientLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        //nombreClientLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        nombreClientLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
    }
    func setUpNombreClienteTextField(){
        view.addSubview(nombreClienteTextField)
        //constraints
        nombreClienteTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        nombreClienteTextField.centerYAnchor.constraint(equalTo: nombreClientLabel.centerYAnchor).isActive = true
        //nombreClienteTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        nombreClienteTextField.leftAnchor.constraint(equalTo: nombreClientLabel.rightAnchor, constant: 10).isActive = true
        nombreClienteTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpCelularLabel(){
        view.addSubview(celularLable)
        //constraints
        celularLable.topAnchor.constraint(equalTo: nombreClientLabel.topAnchor, constant: 50).isActive = true
        celularLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        celularLable.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
    }
    func setUpCelularTextField(){
        view.addSubview(celularTextField)
        //constraints
        celularTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        celularTextField.centerYAnchor.constraint(equalTo: celularLable.centerYAnchor).isActive = true
        celularTextField.leftAnchor.constraint(equalTo: celularLable.rightAnchor, constant: 10).isActive = true
        celularTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpEmpresaLabel(){
        view.addSubview(empresaLabel)
        //constraints
        empresaLabel.topAnchor.constraint(equalTo: celularLable.topAnchor, constant: 50).isActive = true
        empresaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        empresaLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        
    }
    func setUpEmpresaTextField(){
        view.addSubview(empresaTextField)
        //constraints
        empresaTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        empresaTextField.centerYAnchor.constraint(equalTo: empresaLabel.centerYAnchor).isActive = true
        empresaTextField.leftAnchor.constraint(equalTo: empresaLabel.rightAnchor, constant: 10).isActive = true
        empresaTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpTelefonoLabel(){
        view.addSubview(telefonoLabel)
        //constraints
        telefonoLabel.topAnchor.constraint(equalTo: empresaLabel.topAnchor, constant: 50).isActive = true
        telefonoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        telefonoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        
    }
    func setUpTelefonoTextField(){
        view.addSubview(telefonoTextField)
        //constraints
        telefonoTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        telefonoTextField.centerYAnchor.constraint(equalTo: telefonoLabel.centerYAnchor).isActive = true
        telefonoTextField.leftAnchor.constraint(equalTo: telefonoLabel.rightAnchor, constant: 10).isActive = true
        telefonoTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpEmailLabel(){
        view.addSubview(emailLabel)
        //constraints
        emailLabel.topAnchor.constraint(equalTo: telefonoLabel.topAnchor, constant: 50).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
    }
    func setUpEmailTextField(){
        view.addSubview(emailTextField)
        //constraints
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: emailLabel.rightAnchor, constant: 10).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpAgregarProductos(){
        view.addSubview(agregarProductos)
        //constraints
        agregarProductos.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        agregarProductos.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 70).isActive = true
        agregarProductos.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        agregarProductos.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    // handle Agregar Productos button
    func handleAgregarProductos(){
        createNewCotizaciones()
    }
    
    // Create a new cotizaciones
    func createNewCotizaciones(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)create_new_cotizaciones/\(UserDefaults.standard.value(forKey: USER_ID) as! String)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                return
            }
            //print(response)
            self.agrerarArticulo.selectedCotizacionId = response.result.value
            self.navigationController?.pushViewController(self.agrerarArticulo, animated: true)
            self.activityIndicator.stopAnimating()
        })
    }
}

