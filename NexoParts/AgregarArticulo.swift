//
//  AgregarArticulo.swift
//  NexoParts
//
//  Created by Creativeitem on 6/17/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class AgregarArticulo : UIViewController {
    var selectedCotizacionId : String!
    var nombreArticulo       : String!
    var cantidad             : String!
    var selectedMarca        : String!
    var selectedModelo       : String!
    var ano                  : String!
    var chasisNumber         : String!
    var detalleAdicional     : String!
    let nombreArticuloLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Nombre Articulo"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var nombreArticuloTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Nombre De La Peiza", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    let cantidadLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Cantidad"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var cantidadTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    let marcaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Marca"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var marcaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Selecciona Marca   ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleMarca), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    let modeloLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Modelo"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var modeloButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Selecciona Modelo   ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleModelo), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    let anoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Año"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var anoTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Año del carro", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    let chasisLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "No. Chasis"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var chasisTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Chasis o VIN", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    let detalleAdicionaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Detalle Adicional"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var detalleAdicionaTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Detalle Adicional", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    let agregarArticuloImageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Agregar Imagen"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var agregarArticuloImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.image = #imageLiteral(resourceName: "placeholder")
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap)))
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0).cgColor
        return imageView
    }()
    let imagePlaceholderLabelForImageView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Image"
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    lazy var agregarArticulo: UIButton = {
        let agregarButton = UIButton(type: .system)
        agregarButton.setTitle("Agregar Artículo", for: .normal)
        agregarButton.setTitleColor(UIColor.white, for: .normal)
        agregarButton.backgroundColor = GREEN_COLOR
        agregarButton.translatesAutoresizingMaskIntoConstraints = false
        agregarButton.addTarget(self, action: #selector(handleAgregarArticulo), for: .touchUpInside)
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
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding outside tap will dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //customize the navigation bar
        customizeNavigationBar()
        
        // Setting up the UI
        setupUi()
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    func customizeNavigationBar(){
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Agregar Artículo"
        
        // removes the back title from back button of navigation bar
        //let barAppearace = UIBarButtonItem.appearance()
        //barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        
        // hide back button from navigation bar
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
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
        nombreArticuloTextField.layer.cornerRadius = nombreArticuloTextField.frame.height / 2
        cantidadTextField.layer.cornerRadius = cantidadTextField.frame.height / 2
        marcaButton.layer.cornerRadius = marcaButton.frame.height / 2
        modeloButton.layer.cornerRadius = modeloButton.frame.height / 2
        anoTextField.layer.cornerRadius = anoTextField.frame.height / 2
        chasisTextField.layer.cornerRadius = chasisTextField.frame.height / 2
        detalleAdicionaTextField.layer.cornerRadius = detalleAdicionaTextField.frame.height / 2
        agregarArticulo.layer.cornerRadius = agregarArticulo.frame.height / 2
    }
    
    lazy var marcaSelctor: MarcaSelector = {
        let marcaSelect = MarcaSelector()
        marcaSelect.agregarArticuloObj = self
        return marcaSelect
    }()
    
    var marca = [Marca]()
    var modelo = [Modelo]()
    func setupUi(){
        setUpNombreArticuloLabel()
        setUpNombreArticuloTextField()
        setUpCantidadLabel()
        setUpCantidadTextField()
        setUpMarcaLabel()
        setUpMarcaButton()
        setUpModeloLabel()
        setUpModeloButton()
        setUpAnoLabel()
        setUpAnoTextField()
        setUpChasisLabel()
        setUpChasisTextField()
        setUpDetalleAdicionalLabel()
        setUpDetalleAdicionalTextField()
        setUpAgregarArticuloImageLabel()
        setUpAgregarArticuloImageView()
        setupImagePlaceholderLabel()
        setUpAgregarArticuloButton()
        setupActivityIndicator()
    }
    func setUpNombreArticuloLabel(){
        view.addSubview(nombreArticuloLabel)
        nombreArticuloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        nombreArticuloLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        nombreArticuloLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
    }
    func setUpNombreArticuloTextField(){
        view.addSubview(nombreArticuloTextField)
        nombreArticuloTextField.centerYAnchor.constraint(equalTo: nombreArticuloLabel.centerYAnchor).isActive = true
        nombreArticuloTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-10).isActive = true
        nombreArticuloTextField.leftAnchor.constraint(equalTo: nombreArticuloLabel.rightAnchor, constant: 5).isActive = true
        nombreArticuloTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpCantidadLabel(){
        view.addSubview(cantidadLabel)
        cantidadLabel.topAnchor.constraint(equalTo: nombreArticuloLabel.bottomAnchor, constant: 25).isActive = true
        cantidadLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        cantidadLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
    }
    func setUpCantidadTextField(){
        view.addSubview(cantidadTextField)
        cantidadTextField.centerYAnchor.constraint(equalTo: cantidadLabel.centerYAnchor).isActive = true
        cantidadTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-10).isActive = true
        cantidadTextField.leftAnchor.constraint(equalTo: cantidadLabel.rightAnchor, constant: 5).isActive = true
        cantidadTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpMarcaLabel(){
        view.addSubview(marcaLabel)
        marcaLabel.topAnchor.constraint(equalTo: cantidadLabel.bottomAnchor, constant: 25).isActive = true
        marcaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        marcaLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
    }
    func setUpMarcaButton(){
        view.addSubview(marcaButton)
        marcaButton.centerYAnchor.constraint(equalTo: marcaLabel.centerYAnchor).isActive = true
        marcaButton.leftAnchor.constraint(equalTo: marcaLabel.rightAnchor, constant: 5).isActive = true
        marcaButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        marcaButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpModeloLabel(){
        view.addSubview(modeloLabel)
        modeloLabel.topAnchor.constraint(equalTo: marcaLabel.bottomAnchor, constant: 25).isActive = true
        modeloLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        modeloLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
    }
    func setUpModeloButton(){
        view.addSubview(modeloButton)
        modeloButton.centerYAnchor.constraint(equalTo: modeloLabel.centerYAnchor).isActive = true
        modeloButton.leftAnchor.constraint(equalTo: modeloLabel.rightAnchor, constant: 5).isActive = true
        modeloButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        modeloButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        
    }
    func setUpAnoLabel(){
        view.addSubview(anoLabel)
        anoLabel.topAnchor.constraint(equalTo: modeloLabel.bottomAnchor, constant: 25).isActive = true
        anoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        anoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
    }
    func setUpAnoTextField(){
        view.addSubview(anoTextField)
        anoTextField.centerYAnchor.constraint(equalTo: anoLabel.centerYAnchor).isActive = true
        anoTextField.leftAnchor.constraint(equalTo: anoLabel.rightAnchor, constant: 5).isActive = true
        anoTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        anoTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpChasisLabel(){
        view.addSubview(chasisLabel)
        chasisLabel.topAnchor.constraint(equalTo: anoLabel.bottomAnchor, constant: 25).isActive = true
        chasisLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        chasisLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
    }
    func setUpChasisTextField(){
        view.addSubview(chasisTextField)
        chasisTextField.centerYAnchor.constraint(equalTo: chasisLabel.centerYAnchor).isActive = true
        chasisTextField.leftAnchor.constraint(equalTo: chasisLabel.rightAnchor, constant: 5).isActive = true
        chasisTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        chasisTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpDetalleAdicionalLabel(){
        view.addSubview(detalleAdicionaLabel)
        detalleAdicionaLabel.topAnchor.constraint(equalTo: chasisLabel.bottomAnchor, constant: 25).isActive = true
        detalleAdicionaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        detalleAdicionaLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
    }
    func setUpDetalleAdicionalTextField(){
        view.addSubview(detalleAdicionaTextField)
        detalleAdicionaTextField.centerYAnchor.constraint(equalTo: detalleAdicionaLabel.centerYAnchor).isActive = true
        detalleAdicionaTextField.leftAnchor.constraint(equalTo: detalleAdicionaLabel.rightAnchor, constant: 5).isActive = true
        detalleAdicionaTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        detalleAdicionaTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setUpAgregarArticuloImageLabel(){
        view.addSubview(agregarArticuloImageLabel)
        agregarArticuloImageLabel.topAnchor.constraint(equalTo: detalleAdicionaTextField.bottomAnchor, constant: 60).isActive = true
        agregarArticuloImageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        agregarArticuloImageLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
    }
    func setUpAgregarArticuloImageView(){
        view.addSubview(agregarArticuloImageView)
        agregarArticuloImageView.centerYAnchor.constraint(equalTo: agregarArticuloImageLabel.centerYAnchor).isActive = true
        agregarArticuloImageView.leftAnchor.constraint(equalTo: agregarArticuloImageLabel.rightAnchor, constant: 25).isActive = true
        agregarArticuloImageView.heightAnchor.constraint(equalTo:view.widthAnchor, multiplier: 0.25).isActive = true
        agregarArticuloImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func handleImageViewTap() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    func setupImagePlaceholderLabel(){
        agregarArticuloImageView.addSubview(imagePlaceholderLabelForImageView)
        imagePlaceholderLabelForImageView.centerXAnchor.constraint(equalTo: agregarArticuloImageView.centerXAnchor).isActive = true
        imagePlaceholderLabelForImageView.centerYAnchor.constraint(equalTo: agregarArticuloImageView.centerYAnchor).isActive = true
    }
    func setUpAgregarArticuloButton(){
        view.addSubview(agregarArticulo)
        agregarArticulo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        agregarArticulo.topAnchor.constraint(equalTo: agregarArticuloImageView.bottomAnchor, constant: 30).isActive = true
        agregarArticulo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        agregarArticulo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func changeMarcaSelectorTitle(withString title: String) {
        marcaButton.setTitle(title, for: .normal)
    }
    func changeModeloSelectorTitle(withString title: String) {
        modeloButton.setTitle(title, for: .normal)
    }
    func handleMarca(){
        self.dismissKeyboard()
        
        // refreshing modelo button
        self.selectedModelo = nil
        self.modeloButton.setTitle("Selecciona Modelo   ▼", for: .normal)
        // end refreshing
        
        activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_marca") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                return
            }
            if !self.marca.isEmpty {
                self.marca.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let marcaData = Marca(idMarca: dict["id_marca"].string!, nombreMarca: dict["nombre_marca"].string!)
                        self.marca.append(marcaData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.marcaSelctor.show(withData: self.marca)
                }
            }
        })
    }
    
    func handleModelo(){
        self.dismissKeyboard()
        guard let marcaValue = self.selectedMarca else{
            print("Select Marca First")
            return
        }
        // Fetching the modelo datas
        activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_models/\(marcaValue)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                return
            }
            if !self.modelo.isEmpty {
                self.modelo.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let modeloData = Modelo(idModel: dict["id_model"].string!, nombreModelo: dict["nombre_modelo"].string!)
                        self.modelo.append(modeloData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.marcaSelctor.show(withData: self.modelo)
                }
            }
        })
    }
    func handleAgregarArticulo(){
        guard let checkNombre = nombreArticuloTextField.text, let checkCantidad = cantidadTextField.text, let checkMarca = self.selectedMarca, let checkModelo = self.selectedModelo, let checkAno = anoTextField.text, let checkChasisNumber = chasisTextField.text, let checkDetalleAdicional = detalleAdicionaTextField.text  else {
            self.showEmptyAlert()
            print("Can not be empty")
            return
        }
        if(nombreArticuloTextField.text != "" && cantidadTextField.text != "" && anoTextField.text != "" && chasisTextField.text != "" && detalleAdicionaTextField.text != ""){
            self.nombreArticulo = checkNombre
            self.cantidad       = checkCantidad
            self.selectedMarca  = checkMarca
            self.selectedModelo = checkModelo
            self.ano            = checkAno
            self.chasisNumber     = checkChasisNumber
            self.detalleAdicional = checkDetalleAdicional
            
            //Add Article Function Calling
            addArticle()
        }
        else{
            self.showEmptyAlert()
        }
    }
    func addArticle(){
        // Fetching the modelo datas
        activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)agregar_articulo") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true",
                      "id_cotizacion"       : self.selectedCotizacionId!,
                      "articulo_cotizacion" : self.nombreArticulo,
                      "cantidad_producto"   : self.cantidad,
                      "id_marca"            : self.selectedMarca,
                      "id_modelo"           : self.selectedModelo,
                      "year_producto"       : self.ano,
                      "chasis"              : self.chasisNumber,
                      "nota_detalle"        : self.detalleAdicional] as [String: Any]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response.result)
                self.activityIndicator.stopAnimating()
                return
            }
            self.sendImageToServer(detalleCotizacionID: response.result.value!)
        })
    }
    func makeEmptyForm(){
        self.nombreArticuloTextField.text = ""
        self.cantidadTextField.text = ""
        //self.anoTextField.text = ""
        //self.chasisTextField.text = ""
        self.detalleAdicionaTextField.text = ""
        //self.selectedMarca = nil
        //self.selectedModelo = nil
        //self.marcaButton.setTitle("Selecciona Marca   ▼", for: .normal)
        //self.modeloButton.setTitle("Selecciona Modelo   ▼", for: .normal)
        self.agregarArticuloImageView.image = nil
        self.imagePlaceholderLabelForImageView.alpha = 1
    }
    func showAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "¿Que Deseas Hacer?", message: "", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Agregar Otra Pieza", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.makeEmptyForm()
        }
        //Cancel
        let cancelAction = UIAlertAction(title: "Cotizar", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            self.makeEmptyForm()
            let articleOfCotizavionVC = ArticlesOfCotizacionesViewController()
            articleOfCotizavionVC.cotizacionId = self.selectedCotizacionId!
            self.navigationController?.pushViewController(articleOfCotizavionVC, animated: true)
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
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
}

extension AgregarArticulo: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if agregarArticuloImageView.image != nil {
            agregarArticuloImageView.image = nil
        }
        imagePlaceholderLabelForImageView.alpha = 0
        agregarArticuloImageView.contentMode = .scaleAspectFit
        agregarArticuloImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AgregarArticulo{
    func sendImageToServer(detalleCotizacionID: String!){
        if agregarArticuloImageView.image != nil {
            let imageName = "article_image_no_\(detalleCotizacionID!).jpg"
            let image = self.agregarArticuloImageView.image!
            let imgData = UIImageJPEGRepresentation(image, 0.2)!
            
            let parameters = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                              "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                              "authenticate": "true",
                              "detalle_cotizacion_id" : detalleCotizacionID!,
                              "image_source" : "article_image"] as [String: Any]
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "fileset",fileName: imageName, mimeType: "image/jpg")
                for (key, value) in parameters {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            },
            
            to:"\(API_URL)uploadimage")
                
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        print(response.result.value!)
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        }
        self.activityIndicator.stopAnimating()
        self.showAlert()
    }
}

