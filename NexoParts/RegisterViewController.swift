//
//  RegisterViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 6/5/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class RegisterViewController : UIViewController, UIScrollViewDelegate{
    
    var provinciaList = [ProvinciaForRegister]()
    var userList = [userRole]()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "login")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let registerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Registrarse"
        label.font = UIFont(name: TEXT_FONT, size: 18)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var userTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Client ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(handleUserType), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    lazy var firstnameTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "First Name"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    lazy var lastnameTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Last Name"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    lazy var usernameTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "El nombre de usuario debe ser único"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    lazy var TelefonoResidTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Telefono Resid"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    lazy var CelularTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Celular"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    lazy var DireccionUserTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Direccion User"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    lazy var emailTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Email"
        field.keyboardType = .emailAddress
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    
    lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Password"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    let provinciaLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Provincia"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var provinciaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Selecciona Provincia ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleProvincia), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hecho", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = FACEBOOK_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = GOOGLE_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding outside tap will dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        setupUI()
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    var idProvincia: String = "0"
    var idUser: String = "0"
    lazy var selector: Selector = {
        let select = Selector()
        select.registrationVC = self
        return select
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        firstnameTextField.layer.cornerRadius = firstnameTextField.frame.height / 2
        firstnameTextField.font = UIFont(name: TEXT_FONT, size: firstnameTextField.frame.height * 0.35)
        
        lastnameTextField.layer.cornerRadius = lastnameTextField.frame.height / 2
        lastnameTextField.font = UIFont(name: TEXT_FONT, size: lastnameTextField.frame.height * 0.35)
        
        usernameTextField.layer.cornerRadius = usernameTextField.frame.height / 2
        usernameTextField.font = UIFont(name: TEXT_FONT, size: usernameTextField.frame.height * 0.35)
        
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        emailTextField.font = UIFont(name: TEXT_FONT, size: emailTextField.frame.height * 0.35)
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        passwordTextField.font = UIFont(name: TEXT_FONT, size: passwordTextField.frame.height * 0.35)
        
        TelefonoResidTextField.layer.cornerRadius = TelefonoResidTextField.frame.height / 2
        TelefonoResidTextField.font = UIFont(name: TEXT_FONT, size: TelefonoResidTextField.frame.height * 0.35)
        
        CelularTextField.layer.cornerRadius = CelularTextField.frame.height / 2
        CelularTextField.font = UIFont(name: TEXT_FONT, size: CelularTextField.frame.height * 0.35)
        
        DireccionUserTextField.layer.cornerRadius = DireccionUserTextField.frame.height / 2
        DireccionUserTextField.font = UIFont(name: TEXT_FONT, size: DireccionUserTextField.frame.height * 0.35)
        
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
        doneButton.titleLabel?.font = UIFont(name: TEXT_FONT, size: doneButton.frame.height * 0.4)
        
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
        cancelButton.titleLabel?.font = UIFont(name: TEXT_FONT, size: cancelButton.frame.height * 0.4)
        
        provinciaButton.layer.cornerRadius = provinciaButton.frame.height / 2
        userTypeButton.layer.cornerRadius = userTypeButton.frame.height / 2
        
        // set scroll view's content size
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + (view.frame.height)
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
    }
    
    func setupUI() {
        setupBackgroundImageView()
        setupLogoImageView()
        setupregisterLabel()
        setupScrollView()
        setupFirstNameTextField()
        setupLastNameTextField()
        setupUserNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupTelefonoResidTextField()
        setupCelularTextField()
        setupDireccionUserTextField()
        setupUserTypeButton()
        setUpProvinciaButton()
        setupDoneButton()
        setupCancelButton()
        setupActivityIndicator()
        view.layoutIfNeeded()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        // constraints
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setupLogoImageView() {
        view.addSubview(logoImageView)
        // constraints
        let width = view.frame.width * 0.55
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    func setupregisterLabel(){
        view.addSubview(registerLabel)
        // constraints
        registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant : 5).isActive = true
        registerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
    }
    func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 5).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setupFirstNameTextField(){
        scrollView.addSubview(firstnameTextField)
        // constraints
        firstnameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        firstnameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        firstnameTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7).isActive = true
        firstnameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupLastNameTextField(){
        scrollView.addSubview(lastnameTextField)
        // constraints
        lastnameTextField.topAnchor.constraint(equalTo: firstnameTextField.bottomAnchor, constant: 10).isActive = true
        lastnameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        lastnameTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7).isActive = true
        lastnameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        
    }
    func setupUserNameTextField(){
        scrollView.addSubview(usernameTextField)
        // constraints
        usernameTextField.topAnchor.constraint(equalTo: lastnameTextField.bottomAnchor, constant: 10).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7).isActive = true
        usernameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        
    }
    func setupEmailTextField(){
        scrollView.addSubview(emailTextField)
        // constraints
        emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupPasswordTextField(){
        scrollView.addSubview(passwordTextField)
        // constraints
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupTelefonoResidTextField(){
        scrollView.addSubview(TelefonoResidTextField)
        // constraints
        TelefonoResidTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        TelefonoResidTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        TelefonoResidTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7).isActive = true
        TelefonoResidTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupCelularTextField(){
        scrollView.addSubview(CelularTextField)
        // constraints
        CelularTextField.topAnchor.constraint(equalTo: TelefonoResidTextField.bottomAnchor, constant: 10).isActive = true
        CelularTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        CelularTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7).isActive = true
        CelularTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupDireccionUserTextField(){
        scrollView.addSubview(DireccionUserTextField)
        // constraints
        DireccionUserTextField.topAnchor.constraint(equalTo: CelularTextField.bottomAnchor, constant: 10).isActive = true
        DireccionUserTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        DireccionUserTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7).isActive = true
        DireccionUserTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupUserTypeButton(){
        scrollView.addSubview(userTypeButton)
        userTypeButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        userTypeButton.topAnchor.constraint(equalTo: DireccionUserTextField.bottomAnchor, constant: 10).isActive = true
        userTypeButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7).isActive = true
        userTypeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpProvinciaButton(){
        scrollView.addSubview(provinciaButton)
        provinciaButton.topAnchor.constraint(equalTo: userTypeButton.bottomAnchor, constant: 10).isActive = true
        provinciaButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        provinciaButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7).isActive = true
        provinciaButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupDoneButton() {
        scrollView.addSubview(doneButton)
        // constraints
        doneButton.topAnchor.constraint(equalTo: provinciaButton.bottomAnchor, constant: 10).isActive = true
        doneButton.leftAnchor.constraint(equalTo: DireccionUserTextField.leftAnchor).isActive = true
        doneButton.widthAnchor.constraint(equalTo: DireccionUserTextField.widthAnchor, multiplier: 0.48).isActive = true
        doneButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    func setupCancelButton() {
        scrollView.addSubview(cancelButton)
        // constraints
        cancelButton.topAnchor.constraint(equalTo: provinciaButton.bottomAnchor, constant: 10).isActive = true
        cancelButton.rightAnchor.constraint(equalTo: DireccionUserTextField.rightAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: DireccionUserTextField.widthAnchor, multiplier: 0.48).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    func handleProvincia(){
        self.dismissKeyboard()
        getProvinciaFromAPI()
    }
    func handleUserType(){
        self.dismissKeyboard()
        getUserTypeFromAPI()
    }
    func handleDoneButton(){
        if(self.firstnameTextField.text! != "" && self.lastnameTextField.text! != "" && self.usernameTextField.text! != "" && self.emailTextField.text! != "" && self.passwordTextField.text! != "" && self.DireccionUserTextField.text! != "" && self.idProvincia != "0"){
            if self.TelefonoResidTextField.text == "" && self.CelularTextField.text! == ""{
                self.showEmptyAlert()
            }
            else{
                self.idUser = "3"
                registerUser()
            }
        }
        else{
            self.showEmptyAlert()
        }
    }
    func handleCancelButton(){
        self.dismiss(animated: true, completion: nil)
    }
    func changeSelectorTitle(withString title: String) {
        self.provinciaButton.setTitle(title, for: .normal)
    }
    func changeSelectorTitleForUserRole(withString title: String){
        self.userTypeButton.setTitle(title, for: .normal)
    }
    // Get provincias
    func getProvinciaFromAPI(){
        self.activityIndicator.startAnimating()
        let params = ["authenticate": "false"] as [String: Any]
        guard let url = URL(string: "\(API_URL)provincias") else { return }
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                //print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            print(response)
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let provinciaArray = json.array {
                    for provincia in provinciaArray {
                        let provinciaData = ProvinciaForRegister(idProvincia: provincia["id_provincia"].string!, detalle: provincia["detalle"].string!)
                        self.provinciaList.append(provinciaData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.provinciaList)
                }
            }
        })
    }
    // GET USER TYPE
    func getUserTypeFromAPI(){
        self.activityIndicator.startAnimating()
        let params = ["authenticate": "false"] as [String: Any]
        guard let url = URL(string: "\(API_URL)user_role") else { return }
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                //print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            print(response)
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let userRoleArray = json.array {
                    for user in userRoleArray {
                        let userData = userRole(idUser: user["id_role"].string!, userType: user["name_role"].string!)
                        self.userList.append(userData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.userList)
                }
            }
        })
    }
    func registerUser(){
        //self.activityIndicator.startAnimating()
        let params = ["authenticate": "false",
                      "firstname"         : self.firstnameTextField.text!,
                      "lastname"          : self.lastnameTextField.text!,
                      "username"          : self.usernameTextField.text!,
                      "user_email"        : self.emailTextField.text!,
                      "user_password_hash": self.passwordTextField.text!,
                      "user_role"         : self.idUser,
                      "Telefono_resid"    : self.TelefonoResidTextField.text!,
                      "Celular"           : self.CelularTextField.text!,
                      "provincia"         : self.idProvincia,
                      "Direccion_user"    : self.DireccionUserTextField.text!] as [String: Any]
        guard let url = URL(string: "\(API_URL)register") else { return }
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                //self.activityIndicator.stopAnimating()
                return
            }
            if(response.result.value! == "user_already_exists"){
                self.showDuplicationAlert()
            }
            else if(response.result.value! == "success"){
                self.showRegistrationDoneAlert()
            }
        })
    }
    func showEmptyAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "Campos no pueden estar vacíos", message: "Rellenar los campos", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Cerca", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("Okay Pressed on empty alert")
        }
        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    func showDuplicationAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "¡Registro fallido!", message: "La identificación del correo electrónico y el nombre de usuario deben ser únicos", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Cerca", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //self.dismiss(animated: true, completion: nil)
        }
        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    func showRegistrationDoneAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "¡¡Felicitaciones!!", message: "Tu cuenta ha sido creada", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Cerca", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.dismiss(animated: true, completion: nil)
        }
        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}

