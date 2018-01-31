//
//  EditarDatosViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 7/11/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class EditarDatosViewController: UIViewController, UIScrollViewDelegate{
    
    var provinciaList = [Provincia]()
    var userEditedData = [String:String]()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
    let editarDatosTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Editar Datos"
        label.font = UIFont(name: TEXT_FONT, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.numberOfLines = 0
        return label
    }()
    
    let editarMessageLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "En esta pantalla puedes editar tus datos"
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let nombreLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Nombres"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var nombreTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Cranealo"
        field.text = ""
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.font = UIFont(name: TEXT_FONT, size: 14)
        return field
    }()
    
    let apellidosLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Apellidos"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var apellidosTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Agencia Creativa"
        field.text = ""
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.font = UIFont(name: TEXT_FONT, size: 14)
        return field
    }()
    
    let usuarioLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Usuario"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var usuarioTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Cranealo-User"
        field.text = ""
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.font = UIFont(name: TEXT_FONT, size: 14)
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
        button.setTitle("Selecciona   ▼", for: .normal)
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
    
    let celularLabel : UILabel = {
        let label = UILabel()
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
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Celular"
        field.text = ""
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.font = UIFont(name: TEXT_FONT, size: 14)
        return field
    }()
    
    let telefonoLabel : UILabel = {
        let label = UILabel()
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
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Telefono"
        field.text = ""
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.font = UIFont(name: TEXT_FONT, size: 14)
        return field
    }()
    
    let emailLabel : UILabel = {
        let label = UILabel()
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
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Email"
        field.text = ""
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.font = UIFont(name: TEXT_FONT, size: 14)
        return field
    }()
    
    let direccionLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Direccion"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var direccionTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.placeholder = "Direccion"
        field.text = ""
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        field.font = UIFont(name: TEXT_FONT, size: 14)
        return field
    }()
    
    lazy var actualizarDatosButton: UIButton = {
        let actualizar = UIButton(type: .system)
        actualizar.setTitle("Actualizar Datos", for: .normal)
        actualizar.setTitleColor(UIColor.white, for: .normal)
        actualizar.backgroundColor = DEEP_BLUE_COLOR
        actualizar.translatesAutoresizingMaskIntoConstraints = false
        actualizar.addTarget(self, action: #selector(handleActualizerDatos), for: .touchUpInside)
        actualizar.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        actualizar.layer.shadowRadius = 2
        actualizar.layer.shadowOpacity = 0.8
        actualizar.layer.shadowOffset = CGSize(width: 0, height: 3)
        return actualizar
    }()
    let copyRightLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(red:0.67, green:0.81, blue:0.24, alpha:1.0).cgColor
        label.text = "Powered By Cranealo | Agencia Creativa"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
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
        // Adding outside tap will dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //customize the navigation bar
        customizeNavigationBar()
        
        //setup Views
        setupUI()
        
        // Check if the user is logged in or not
        self.activityIndicator.startAnimating()
        self.isLoggedIn()
    }
    
    func customizeNavigationBar(){
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Datos De Usuario"
        
        // removes the back title from back button of navigation bar
        let barAppearace = UIBarButtonItem.appearance()
        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
    
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        if UserDefaults.standard.value(forKey: USER_ROLE) as! String == "3"{
            button.setImage(UIImage(named: "cart-white"), for: .normal)
        }
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
    
    // Checking if the user is logged in or not
    func isLoggedIn(){
        if UserDefaults.standard.bool(forKey: LOGGED_IN) {
            getLoggedInUserInfoFromAPI()        }
        else{
            return
        }
    }
    
    var idProvincia: String = "0"
    lazy var selector: Selector = {
        let select = Selector()
        select.editarDatosVC = self
        return select
    }()
    
    func changeSelectorTitle(withString title: String) {
        self.provinciaButton.setTitle(title, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.nombreTextField.layer.cornerRadius = nombreTextField.frame.height / 2
        self.apellidosTextField.layer.cornerRadius = apellidosTextField.frame.height / 2
        self.usuarioTextField.layer.cornerRadius = usuarioTextField.frame.height / 2
        self.provinciaButton.layer.cornerRadius = provinciaButton.frame.height / 2
        self.celularTextField.layer.cornerRadius = celularTextField.frame.height / 2
        self.telefonoTextField.layer.cornerRadius = telefonoTextField.frame.height / 2
        self.emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        self.direccionTextField.layer.cornerRadius = direccionTextField.frame.height / 2
        self.actualizarDatosButton.layer.cornerRadius = actualizarDatosButton.frame.height / 2
        
        // set scroll view's content size
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + (view.frame.height)
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
        
        if UserDefaults.standard.value(forKey: USER_ROLE) as! String == "2"{
            nombreTextField.isUserInteractionEnabled = false
            apellidosTextField.isUserInteractionEnabled = false
            usuarioTextField.isUserInteractionEnabled = false
        }
        view.layoutIfNeeded()
        print(UserDefaults.standard.value(forKey: USER_ID) as! String)
    }
    func setupUI(){
        setUpEditarDatosTitleLabel()
        setUpEditMessage()
        setupScrollView()
        setUpNombreLabel()
        setUpNombreTextField()
        setUpApellidosLabel()
        setUpApellidosTextField()
        setUpUsuarioLabel()
        setUpUsuarioTextField()
        setUpProvinciaLabel()
        setUpProvinciaButton()
        setUpCelularLabel()
        setUpCelularTextField()
        setUpTelefonoLabel()
        setUpTelefonoTextField()
        setUpEmailLabel()
        setUpEmailTextField()
        setUpDireccionLabel()
        setUpDireccionTextField()
        setUpActualizarDatosButton()
        setupCopyrightLabel()
        setupActivityIndicator()
        view.layoutIfNeeded()
    }
    func setUpEditarDatosTitleLabel(){
        view.addSubview(editarDatosTitleLabel)
        editarDatosTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editarDatosTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
    }
    
    func setUpEditMessage(){
        view.addSubview(editarMessageLabel)
        editarMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editarMessageLabel.topAnchor.constraint(equalTo: editarDatosTitleLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: editarMessageLabel.bottomAnchor, constant: 10).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setUpNombreLabel(){
        scrollView.addSubview(nombreLabel)
        nombreLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        nombreLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30).isActive = true
        nombreLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.30).isActive = true
        nombreLabel.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    func setUpNombreTextField(){
        scrollView.addSubview(nombreTextField)
        nombreTextField.centerYAnchor.constraint(equalTo: nombreLabel.centerYAnchor).isActive = true
        nombreTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        nombreTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60).isActive = true
        nombreTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setUpApellidosLabel(){
        scrollView.addSubview(apellidosLabel)
        apellidosLabel.topAnchor.constraint(equalTo: nombreLabel.bottomAnchor, constant: 10).isActive = true
        apellidosLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        apellidosLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        apellidosLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    func setUpApellidosTextField(){
        scrollView.addSubview(apellidosTextField)
        apellidosTextField.centerYAnchor.constraint(equalTo: apellidosLabel.centerYAnchor).isActive = true
        apellidosTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        apellidosTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60).isActive = true
        apellidosTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setUpUsuarioLabel(){
        scrollView.addSubview(usuarioLabel)
        usuarioLabel.topAnchor.constraint(equalTo: apellidosLabel.bottomAnchor, constant: 10).isActive = true
        usuarioLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        usuarioLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        usuarioLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    func setUpUsuarioTextField(){
        scrollView.addSubview(usuarioTextField)
        usuarioTextField.centerYAnchor.constraint(equalTo: usuarioLabel.centerYAnchor).isActive = true
        usuarioTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        usuarioTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60).isActive = true
        usuarioTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setUpProvinciaLabel(){
        scrollView.addSubview(provinciaLabel)
        provinciaLabel.topAnchor.constraint(equalTo: usuarioLabel.bottomAnchor, constant: 10).isActive = true
        provinciaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        provinciaLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        provinciaLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    func setUpProvinciaButton(){
        scrollView.addSubview(provinciaButton)
        provinciaButton.centerYAnchor.constraint(equalTo: provinciaLabel.centerYAnchor).isActive = true
        provinciaButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        provinciaButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60).isActive = true
        provinciaButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setUpCelularLabel(){
        scrollView.addSubview(celularLabel)
        celularLabel.topAnchor.constraint(equalTo: provinciaLabel.bottomAnchor, constant: 10).isActive = true
        celularLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        celularLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        celularLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    func setUpCelularTextField(){
        scrollView.addSubview(celularTextField)
        celularTextField.centerYAnchor.constraint(equalTo: celularLabel.centerYAnchor).isActive = true
        celularTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        celularTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60).isActive = true
        celularTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setUpTelefonoLabel(){
        scrollView.addSubview(telefonoLabel)
        telefonoLabel.topAnchor.constraint(equalTo: celularLabel.bottomAnchor, constant: 10).isActive = true
        telefonoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        telefonoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        telefonoLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    func setUpTelefonoTextField(){
        scrollView.addSubview(telefonoTextField)
        telefonoTextField.centerYAnchor.constraint(equalTo: telefonoLabel.centerYAnchor).isActive = true
        telefonoTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        telefonoTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60).isActive = true
        telefonoTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setUpEmailLabel(){
        scrollView.addSubview(emailLabel)
        emailLabel.topAnchor.constraint(equalTo: telefonoLabel.bottomAnchor, constant: 10).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        emailLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    func setUpEmailTextField(){
        scrollView.addSubview(emailTextField)
        emailTextField.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setUpDireccionLabel(){
        scrollView.addSubview(direccionLabel)
        direccionLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        direccionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        direccionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        direccionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        
    }
    
    func setUpDireccionTextField(){
        scrollView.addSubview(direccionTextField)
        direccionTextField.centerYAnchor.constraint(equalTo: direccionLabel.centerYAnchor).isActive = true
        direccionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        direccionTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60).isActive = true
        direccionTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setUpActualizarDatosButton(){
        scrollView.addSubview(actualizarDatosButton)
        actualizarDatosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actualizarDatosButton.topAnchor.constraint(equalTo: direccionTextField.bottomAnchor, constant: 35).isActive = true
        actualizarDatosButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        actualizarDatosButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupCopyrightLabel() {
        view.addSubview(copyRightLabel)
        // constranits
        copyRightLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        copyRightLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        copyRightLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        copyRightLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    func handleProvincia(){
        getProvinciaFromAPI()
    }
    // Get Logged In User Info
    func getLoggedInUserInfoFromAPI(){
        guard let url = URL(string: "\(API_URL)get_logged_in_user_info/\(UserDefaults.standard.value(forKey: USER_ID) as! String)") else { return }
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
            print(response)
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let userInfoArray = json.array {
                    for userData in userInfoArray {
                        self.nombreTextField.text = userData["firstname"].string!
                        self.apellidosTextField.text = userData["lastname"].string!
                        self.usuarioTextField.text = userData["user_name"].string!
                        self.celularTextField.text = userData["celular"].string!
                        self.telefonoTextField.text = userData["telefono"].string!
                        self.emailTextField.text = userData["email"].string!
                        self.direccionTextField.text = userData["direccion"].string!
                        self.idProvincia = userData["provincia_id"].string!
                        if self.idProvincia != "0"{
                         self.provinciaButton.setTitle("\(userData["provincia"].string!)  ▼", for: .normal)
                        }
                    }
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    // Get provincias
    func getProvinciaFromAPI(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)provincias") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                return
            }
            print(response)
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let provinciaArray = json.array {
                    for provincia in provinciaArray {
                        let provinciaData = Provincia(idProvincia: provincia["id_provincia"].string!, detalle: provincia["detalle"].string!)
                        self.provinciaList.append(provinciaData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.provinciaList)
                }
            }
        })
    }
    func handleActualizerDatos(){
        self.userEditedData["firstname"] = self.nombreTextField.text!
        self.userEditedData["lastname"]  = self.apellidosTextField.text!
        self.userEditedData["user_name"]  = self.usuarioTextField.text!
        self.userEditedData["provincia"] = self.idProvincia
        self.userEditedData["Celular"]  = self.celularTextField.text!
        self.userEditedData["Telefono_resid"]  = self.telefonoTextField.text!
        self.userEditedData["Direccion_user"] = self.direccionTextField.text!
        self.userEditedData["user_email"]  = self.emailTextField.text!
        
        if(self.userEditedData["firstname"]! != "" && self.userEditedData["lastname"]! != "" && self.userEditedData["user_name"]! != "" && self.userEditedData["provincia"]! != "" && self.userEditedData["Celular"]! != "" && self.userEditedData["Telefono_resid"]! != "" && self.userEditedData["Direccion_user"]! != "" && self.userEditedData["user_email"]! != ""){
            //Edit function
            updateUserData()
        }
        else{
            showAlert()
        }
        
    }
    func updateUserData(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)update_user_info") else { return }
        let params = ["auth_token"    : UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id"       : UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "firstname"     : self.userEditedData["firstname"]!,
                      "lastname"      : self.userEditedData["lastname"]!,
                      "user_name"     : self.userEditedData["user_name"]!,
                      "provincia"     : self.userEditedData["provincia"]!,
                      "Celular"       : self.userEditedData["Celular"]!,
                      "Telefono_resid": self.userEditedData["Telefono_resid"]!,
                      "Direccion_user": self.userEditedData["Direccion_user"]!,
                      "user_email"    : self.userEditedData["user_email"]!,
                      "authenticate"  : "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                return
            }
            if  response.result.value! == "done"{
                UserDefaults.standard.set(self.userEditedData["firstname"]!, forKey: FIRST_NAME)
                UserDefaults.standard.set(self.userEditedData["lastname"]!, forKey: LAST_NAME)
                UserDefaults.standard.set(self.userEditedData["user_email"]!, forKey: LOGGED_IN_USER_MAIL)
                UserDefaults.standard.set(self.userEditedData["Celular"]!, forKey: CELULAR)
                UserDefaults.standard.set(self.userEditedData["Telefono_resid"]!, forKey: TELEFONO)
                self.showSuccessAlert()
            }
            else{
                self.showDuplicationAlert()
            }
            self.activityIndicator.stopAnimating()
        })
    }
    func showAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "Los campos de texto no pueden estar vacíos", message: "", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Bueno", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("Okay Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSuccessAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "¡Felicitaciones!", message: "Perfil ha sido actualizado", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Cerca", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("Okay Pressed")
        }
        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    func showDuplicationAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "¡Error!", message: "La identificación del correo electrónico y el nombre de usuario deben ser únicos", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Cerca", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("Okay Pressed")
        }
        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)

    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
}

