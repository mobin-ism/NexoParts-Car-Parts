//
//  AddOfferFormVIewController.swift
//  NexoParts
//
//  Created by Creativeitem on 8/3/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class AddOfferFormViewController: UIViewController , UIScrollViewDelegate{
    
    var imagePicked : Int = 0
    var states = [Estado]()
    var ubicacion = [Ubicacion]()
    var tiempoDeEntrega = [TiempoDeEntrega]()
    var garantia = [Garantia]()
    var pieza = [Pieza]()
    var idEstado : String!
    var idUbicacion : String!
    var idTiempoDeEntrega : String!
    var idGranatia : String!
    var idPieza : String!
    
    //variable for storing data
    var cantidad : String!
    var precioUnitario : String!
    var comentario : String!
    var selectedCotizacionId : String!
    var selectedDetalleCotizacionId : String!
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        scrollView.backgroundColor = BG_COLOR
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var upperButtonOne: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Oferta 1", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = GREEN_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleOne), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    lazy var upperButtonTwo: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = GRAY_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTwo), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    lazy var upperButtonThree: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = GRAY_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleThree), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    let cantidadLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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
        field.attributedPlaceholder = NSAttributedString(string: "Escriba La Cantidad", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    let precioUnitarioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Precio Unitario"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var precioUnitarioTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Coloque El Precio", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    let estadoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Estado"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var estadoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Estado ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleEstado), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    let ubicacionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Ubicacíon"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var ubicacionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Panama Centro", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(handleUbicacionButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    let tiempoDeEntregaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Tiempo De Entrega"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var tiempoDeEntregaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tiempo De Entrega ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTiempoDeEntregaButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    
    let comentarioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Comentario"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var comentarioTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Escriba Un Comentario", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        //field.delegate = self
        return field
    }()
    let granatiaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Garantía"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var granatiaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Garantía ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleGarantiaButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    
    let peizaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Pieza"
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var piezaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pieza ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePiezaButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 12)
        return button
    }()
    
    lazy var agregarOfertaImageViewOne: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 1
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.image = #imageLiteral(resourceName: "placeholder")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0).cgColor
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleImageViewOneTap)))
        return imageView
    }()
    lazy var agregarOfertaImageViewTwo: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.image = #imageLiteral(resourceName: "placeholder")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0).cgColor
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleImageViewTwoTap)))
        return imageView
    }()
    let imagePlaceholderLabelForImageViewOne: UILabel = {
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
    let imagePlaceholderLabelForImageViewTwo: UILabel = {
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
    lazy var agregarOferta: UIButton = {
        let agregarButton = UIButton(type: .system)
        agregarButton.setTitle("Agregar Oferta", for: .normal)
        agregarButton.setTitleColor(UIColor.white, for: .normal)
        agregarButton.backgroundColor = GREEN_COLOR
        agregarButton.translatesAutoresizingMaskIntoConstraints = false
        agregarButton.addTarget(self, action: #selector(handleAgregarButton), for: .touchUpInside)
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
        
        //customization the navigation bar
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
        self.title = "Oferta Artículo"
        
        // removes the back title from back button of navigation bar
        let barAppearace = UIBarButtonItem.appearance()
        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cantidadTextField.layer.cornerRadius = cantidadTextField.frame.height / 2
        precioUnitarioTextField.layer.cornerRadius = precioUnitarioTextField.frame.height / 2
        estadoButton.layer.cornerRadius = estadoButton.frame.height / 2
        ubicacionButton.layer.cornerRadius = ubicacionButton.frame.height / 2
        tiempoDeEntregaButton.layer.cornerRadius = tiempoDeEntregaButton.frame.height / 2
        comentarioTextField.layer.cornerRadius = comentarioTextField.frame.height / 2
        granatiaButton.layer.cornerRadius = granatiaButton.frame.height / 2
        piezaButton.layer.cornerRadius = piezaButton.frame.height / 2
        agregarOferta.layer.cornerRadius = agregarOferta.frame.height / 2
        
        // set scroll view's content size
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + (view.frame.height)
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
    }
    
    lazy var selector: Selector = {
        let select = Selector()
        select.addOfferFormVC = self
        return select
    }()
    func changeStateSelectorTitle(withString title: String) {
        estadoButton.setTitle(title, for: .normal)
    }
    func changeUbicacionSelectorTitle(withString title: String) {
        ubicacionButton.setTitle(title, for: .normal)
    }
    func changeTiempoDeEntregaSelectorTitle(withString title: String) {
        tiempoDeEntregaButton.setTitle(title, for: .normal)
    }
    func changeGarantiaSelectorTitle(withString title: String) {
        granatiaButton.setTitle(title, for: .normal)
    }
    func changePiezaSelectorTitle(withString title: String) {
        piezaButton.setTitle(title, for: .normal)
    }
    
    func handleEstado(){
        view.endEditing(true)
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_status") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                return
            }
            if !self.states.isEmpty {
                self.states.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let statesData = Estado(idEstado: dict["id_estado"].string!, detalle: dict["detalle"].string!)
                        self.states.append(statesData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.states)
                }
            }
        })
    }
    func handleUbicacionButton(){
        view.endEditing(true)
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_ubicacion") else { return }
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
            if !self.ubicacion.isEmpty {
                self.ubicacion.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let ubicacionData = Ubicacion(idUbicacion: dict["id_provincia"].string!, detalle: dict["detalle"].string!)
                        self.ubicacion.append(ubicacionData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.ubicacion)
                }
            }
        })
    }
    
    func handleTiempoDeEntregaButton(){
        view.endEditing(true)
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_tiempo_de_entrega") else { return }
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
            if !self.tiempoDeEntrega.isEmpty {
                self.tiempoDeEntrega.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let tiempoDeEntregaData = TiempoDeEntrega(idTiempoDeEntrega: dict["tiempo_de_entrega_id"].string!, title: dict["title"].string!)
                        self.tiempoDeEntrega.append(tiempoDeEntregaData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.tiempoDeEntrega)
                }
            }
        })
    }
    
    func handleGarantiaButton(){
        view.endEditing(true)
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_garantia") else { return }
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
            if !self.garantia.isEmpty {
                self.garantia.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let garantiaData = Garantia(idGranatia: dict["id_garantia"].string!, nombre: dict["nombre"].string!)
                        self.garantia.append(garantiaData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.garantia)
                }
            }
        })
    }
    
    func handlePiezaButton(){
        view.endEditing(true)
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_pieza") else { return }
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
            if !self.pieza.isEmpty {
                self.pieza.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let piezaData = Pieza(idPieza: dict["id_pieza"].string!, nombre: dict["nombre"].string!)
                        self.pieza.append(piezaData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.pieza)
                }
            }
        })
    }
    
    func handleAgregarButton(){
        if self.cantidadTextField.text! != "" && self.precioUnitarioTextField.text! != "" && self.idEstado  != "0" && self.idTiempoDeEntrega != "0" && self.comentarioTextField.text! != "" && self.idGranatia != "0" && self.idPieza != "0"{
            self.cantidad = self.cantidadTextField.text!
            self.precioUnitario = self.precioUnitarioTextField.text!
            self.comentario = self.comentarioTextField.text!
            
            self.addOffer()
        }
        else{
            self.showEmptyAlert()
        }
    }
    
    func addOffer(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)add_offer_on_cotizacion") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true",
                      "cotizacion_id" : self.selectedCotizacionId,
                      "detalle_cotizacion_id" : self.selectedDetalleCotizacionId,
                      "cantidad" : self.cantidad,
                      "precio_unitario" : self.precioUnitario,
                      "estado" : self.idEstado,
                      "ubicacion" : self.ubicacionButton.title(for: .normal)!,
                      "tiempo_de_entrega" : self.idTiempoDeEntrega,
                      "comentario" : self.comentario,
                      "granatia" : self.idGranatia,
                      "pieza" : self.idPieza] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                return
            }
            print(response.result.value!)
            if(response.result.value! == "failed"){
                self.activityIndicator.stopAnimating()
                self.showFailedAlert()
            }
            else{
                let insertedOfferId = response.result.value!
                self.addImageOnOffer(insertedOfferId: insertedOfferId)
            }
        })
    }
    func addImageOnOffer(insertedOfferId: String!){
        var imageView : UIImageView!
        for i in (0...1){
            if(i == 0){
                imageView = agregarOfertaImageViewOne
            }
            if(i == 1){
                imageView = agregarOfertaImageViewTwo
            }
            
            // checking if the image view has no image
            if  imageView.image != nil{
                let imageName = "offer_image_no_\(insertedOfferId!)_\(i+1).jpg"
                let image = imageView.image!
                let imgData = UIImageJPEGRepresentation(image, 0.2)!
                
                let parameters = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                                  "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                                  "authenticate": "true",
                                  "id_oferta" : insertedOfferId!,
                                  "image_source" : "offer_image"] as [String: Any]
                
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
        }
        self.activityIndicator.stopAnimating()
        self.showSuccessAlert()
    }
    func handleOne(){
        self.makeTheFormEmpty()
        self.upperButtonOne.backgroundColor = GREEN_COLOR
        self.upperButtonTwo.backgroundColor = GRAY_COLOR
        self.upperButtonThree.backgroundColor = GRAY_COLOR
        
        self.upperButtonOne.setTitle("Oferta 1", for: .normal)
        self.upperButtonTwo.setTitle("+", for: .normal)
        self.upperButtonThree.setTitle("+", for: .normal)
    }
    func handleTwo(){
        self.makeTheFormEmpty()
        self.upperButtonOne.backgroundColor = GRAY_COLOR
        self.upperButtonTwo.backgroundColor = GREEN_COLOR
        self.upperButtonThree.backgroundColor = GRAY_COLOR
        
        self.upperButtonOne.setTitle("+", for: .normal)
        self.upperButtonTwo.setTitle("Oferta 2", for: .normal)
        self.upperButtonThree.setTitle("+", for: .normal)
    }
    func handleThree(){
        self.makeTheFormEmpty()
        self.upperButtonOne.backgroundColor = GRAY_COLOR
        self.upperButtonTwo.backgroundColor = GRAY_COLOR
        self.upperButtonThree.backgroundColor = GREEN_COLOR
        
        self.upperButtonOne.setTitle("+", for: .normal)
        self.upperButtonTwo.setTitle("+", for: .normal)
        self.upperButtonThree.setTitle("Oferta 3", for: .normal)
    }
    func handleImageViewOneTap() {
        self.imagePicked = agregarOfertaImageViewOne.tag
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    func handleImageViewTwoTap() {
        self.imagePicked = agregarOfertaImageViewTwo.tag
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
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
    func showSuccessAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "¡Felicitaciones!", message: "Su oferta ha sido añadida correctamente", preferredStyle: .alert)
        
        // Create the actions
        let otraOferta = UIAlertAction(title: "¿Otra Oferta?", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.makeTheFormEmpty()
        }
        
        // Create the actions
        let finalizarAction = UIAlertAction(title: "Finalizar", style: UIAlertActionStyle.default) {
            UIAlertAction in
            // sending an offer creation message to client
            self.sendMailToClient()
            // Popping To a specific view controller
            self.navigationController?.popViewController(animated: true);
            /*for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: CompanyHomeViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }*/
        }
        
        // Add the actions
        alertController.addAction(otraOferta)
        alertController.addAction(finalizarAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    func sendMailToClient(){
        // send mail and notifications
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)send_offer_creation_mail_to_client/\(self.selectedCotizacionId!)") else {return}
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
        })
    }
    func showFailedAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "¡Lo siento!", message: "Un administrador no puede ofrecer un artículo más de 3 veces.", preferredStyle: .alert)
        
        // Create the actions
        let finalizarAction = UIAlertAction(title: "Cerca", style: UIAlertActionStyle.default) {
            UIAlertAction in
            // Popping To a specific view controller
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: CompanyHomeViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }
        
        // Add the actions
        alertController.addAction(finalizarAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    func makeTheFormEmpty(){
        self.cantidadTextField.text = ""
        self.precioUnitarioTextField.text = ""
        self.estadoButton.setTitle("Estado ▼", for: .normal)
        self.ubicacionButton.setTitle("Panama Centro", for: .normal)
        self.tiempoDeEntregaButton.setTitle("Tiempo De Entrega ▼", for: .normal)
        self.comentarioTextField.text = ""
        self.granatiaButton.setTitle("Granatia ▼", for: .normal)
        self.piezaButton.setTitle("Pieza ▼", for: .normal)
        self.idEstado = "0"
        self.idUbicacion = "0"
        self.idTiempoDeEntrega = "0"
        self.idGranatia = "0"
        self.idPieza = "0"
        self.agregarOfertaImageViewOne.image = nil
        self.agregarOfertaImageViewTwo.image = nil
        self.imagePlaceholderLabelForImageViewOne.alpha = 1
        self.imagePlaceholderLabelForImageViewTwo.alpha = 1
    }
    func setupUi(){
        //setupUpperButtonOne()
        //setupUpperButtonTwo()
        //setupUpperButotnThree()
        setupScrollView()
        setupCantidadlabel()
        setUpCantidadTextField()
        setupPrecioUnitarioLabel()
        setupPrecioUnitarioTextField()
        setupEstadoLabel()
        setupEstadoButton()
        setupUbicacionLabel()
        setupUbicacionButton()
        setupTiempoDeEntregaLabel()
        setupTiempoDeEntregaButton()
        setupComentarioLabel()
        setupComentarionTextField()
        setupGranatiaLabel()
        setupGranatiaButton()
        setupPeizaLabel()
        setupPeizaButton()
        setupAgregarOfertaImageViewOne()
        setupAgregarOfertaImageViewTwo()
        setupFirstImageViewPlaceholderLabel()
        setupSecondImageViewPlaceholderLabel()
        setupAgregarOfertaButton()
        setupActivityIndicator()
    }
    func setupUpperButtonOne(){
        view.addSubview(upperButtonOne)
        upperButtonOne.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        upperButtonOne.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        upperButtonOne.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        upperButtonOne.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
    }
    func setupUpperButtonTwo(){
        view.addSubview(upperButtonTwo)
        upperButtonTwo.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        upperButtonTwo.leftAnchor.constraint(equalTo: upperButtonOne.rightAnchor).isActive = true
        upperButtonTwo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        upperButtonTwo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
    }
    func setupUpperButotnThree(){
        view.addSubview(upperButtonThree)
        upperButtonThree.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        upperButtonThree.leftAnchor.constraint(equalTo: upperButtonTwo.rightAnchor).isActive = true
        upperButtonThree.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.34).isActive = true
        upperButtonThree.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
    }
    func setupScrollView(){
        self.view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setupCantidadlabel(){
        scrollView.addSubview(cantidadLabel)
        cantidadLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 25).isActive = true
        cantidadLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        cantidadLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5).isActive = true
    }
    func setUpCantidadTextField(){
        scrollView.addSubview(cantidadTextField)
        cantidadTextField.centerYAnchor.constraint(equalTo: cantidadLabel.centerYAnchor).isActive = true
        cantidadTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        cantidadTextField.leftAnchor.constraint(equalTo: cantidadLabel.rightAnchor, constant: 10).isActive = true
        cantidadTextField.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupPrecioUnitarioLabel(){
        scrollView.addSubview(precioUnitarioLabel)
        precioUnitarioLabel.topAnchor.constraint(equalTo: cantidadTextField.bottomAnchor, constant: 20).isActive = true
        precioUnitarioLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        precioUnitarioLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5).isActive = true
    }
    func setupPrecioUnitarioTextField(){
        scrollView.addSubview(precioUnitarioTextField)
        precioUnitarioTextField.centerYAnchor.constraint(equalTo: precioUnitarioLabel.centerYAnchor).isActive = true
        precioUnitarioTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        precioUnitarioTextField.leftAnchor.constraint(equalTo: precioUnitarioLabel.rightAnchor, constant: 10).isActive = true
        precioUnitarioTextField.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupEstadoLabel(){
        scrollView.addSubview(estadoLabel)
        estadoLabel.topAnchor.constraint(equalTo: precioUnitarioTextField.bottomAnchor, constant: 20).isActive = true
        estadoLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        estadoLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5).isActive = true
    }
    func setupEstadoButton(){
        scrollView.addSubview(estadoButton)
        estadoButton.centerYAnchor.constraint(equalTo: estadoLabel.centerYAnchor).isActive = true
        estadoButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        estadoButton.leftAnchor.constraint(equalTo: estadoLabel.rightAnchor, constant: 10).isActive = true
        estadoButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupUbicacionLabel(){
        scrollView.addSubview(ubicacionLabel)
        ubicacionLabel.topAnchor.constraint(equalTo: estadoButton.bottomAnchor, constant: 20).isActive = true
        ubicacionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        ubicacionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5).isActive = true
    }
    func setupUbicacionButton(){
        scrollView.addSubview(ubicacionButton)
        ubicacionButton.centerYAnchor.constraint(equalTo: ubicacionLabel.centerYAnchor).isActive = true
        ubicacionButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        ubicacionButton.leftAnchor.constraint(equalTo: ubicacionLabel.rightAnchor, constant: 10).isActive = true
        ubicacionButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupTiempoDeEntregaLabel(){
        scrollView.addSubview(tiempoDeEntregaLabel)
        tiempoDeEntregaLabel.topAnchor.constraint(equalTo: ubicacionButton.bottomAnchor, constant: 20).isActive = true
        tiempoDeEntregaLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        tiempoDeEntregaLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5).isActive = true
    }
    func setupTiempoDeEntregaButton(){
        scrollView.addSubview(tiempoDeEntregaButton)
        tiempoDeEntregaButton.centerYAnchor.constraint(equalTo: tiempoDeEntregaLabel.centerYAnchor).isActive = true
        tiempoDeEntregaButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        tiempoDeEntregaButton.leftAnchor.constraint(equalTo: tiempoDeEntregaLabel.rightAnchor, constant: 10).isActive = true
        tiempoDeEntregaButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupComentarioLabel(){
        scrollView.addSubview(comentarioLabel)
        comentarioLabel.topAnchor.constraint(equalTo: tiempoDeEntregaButton.bottomAnchor, constant: 20).isActive = true
        comentarioLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        comentarioLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5).isActive = true
    }
    func setupComentarionTextField(){
        scrollView.addSubview(comentarioTextField)
        comentarioTextField.centerYAnchor.constraint(equalTo: comentarioLabel.centerYAnchor).isActive = true
        comentarioTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        comentarioTextField.leftAnchor.constraint(equalTo: comentarioLabel.rightAnchor, constant: 10).isActive = true
        comentarioTextField.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupGranatiaLabel(){
        scrollView.addSubview(granatiaLabel)
        granatiaLabel.topAnchor.constraint(equalTo: comentarioTextField.bottomAnchor, constant: 20).isActive = true
        granatiaLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        granatiaLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5).isActive = true
    }
    func setupGranatiaButton(){
        scrollView.addSubview(granatiaButton)
        granatiaButton.centerYAnchor.constraint(equalTo: granatiaLabel.centerYAnchor).isActive = true
        granatiaButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        granatiaButton.leftAnchor.constraint(equalTo: granatiaLabel.rightAnchor, constant: 10).isActive = true
        granatiaButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupPeizaLabel(){
        scrollView.addSubview(peizaLabel)
        peizaLabel.topAnchor.constraint(equalTo: granatiaButton.bottomAnchor, constant: 20).isActive = true
        peizaLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        peizaLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5).isActive = true
    }
    func setupPeizaButton(){
        scrollView.addSubview(piezaButton)
        piezaButton.centerYAnchor.constraint(equalTo: peizaLabel.centerYAnchor).isActive = true
        piezaButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        piezaButton.leftAnchor.constraint(equalTo: peizaLabel.rightAnchor, constant: 10).isActive = true
        piezaButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.06).isActive = true
    }
    func setupAgregarOfertaImageViewOne(){
        scrollView.addSubview(agregarOfertaImageViewOne)
        agregarOfertaImageViewOne.topAnchor.constraint(equalTo: piezaButton.bottomAnchor, constant: 25).isActive = true
        agregarOfertaImageViewOne.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        agregarOfertaImageViewOne.heightAnchor.constraint(equalTo:scrollView.widthAnchor, multiplier: 0.20).isActive = true
        agregarOfertaImageViewOne.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.20).isActive = true
    }
    func setupAgregarOfertaImageViewTwo(){
        scrollView.addSubview(agregarOfertaImageViewTwo)
        agregarOfertaImageViewTwo.centerYAnchor.constraint(equalTo: agregarOfertaImageViewOne.centerYAnchor).isActive = true
        agregarOfertaImageViewTwo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        agregarOfertaImageViewTwo.heightAnchor.constraint(equalTo:scrollView.widthAnchor, multiplier: 0.20).isActive = true
        agregarOfertaImageViewTwo.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.20).isActive = true
    }
    func setupFirstImageViewPlaceholderLabel(){
        agregarOfertaImageViewOne.addSubview(imagePlaceholderLabelForImageViewOne)
        imagePlaceholderLabelForImageViewOne.centerXAnchor.constraint(equalTo: agregarOfertaImageViewOne.centerXAnchor).isActive = true
        imagePlaceholderLabelForImageViewOne.centerYAnchor.constraint(equalTo: agregarOfertaImageViewOne.centerYAnchor).isActive = true
    }
    func setupSecondImageViewPlaceholderLabel(){
        agregarOfertaImageViewTwo.addSubview(imagePlaceholderLabelForImageViewTwo)
        imagePlaceholderLabelForImageViewTwo.centerXAnchor.constraint(equalTo: agregarOfertaImageViewTwo.centerXAnchor).isActive = true
        imagePlaceholderLabelForImageViewTwo.centerYAnchor.constraint(equalTo: agregarOfertaImageViewTwo.centerYAnchor).isActive = true
    }
    func setupAgregarOfertaButton(){
        scrollView.addSubview(agregarOferta)
        agregarOferta.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        agregarOferta.topAnchor.constraint(equalTo: agregarOfertaImageViewOne.bottomAnchor, constant: 15).isActive = true
        agregarOferta.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.05).isActive = true
        agregarOferta.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5).isActive = true
    }
    func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension AddOfferFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if  self.imagePicked == 1{
            if agregarOfertaImageViewOne.image != nil {
                agregarOfertaImageViewOne.image = nil
            }
            imagePlaceholderLabelForImageViewOne.alpha = 0
            agregarOfertaImageViewOne.contentMode = .scaleAspectFit
            agregarOfertaImageViewOne.image = image
        }
        if self.imagePicked == 2{
            if agregarOfertaImageViewTwo.image != nil {
                agregarOfertaImageViewTwo.image = nil
            }
            imagePlaceholderLabelForImageViewTwo.alpha = 0
            agregarOfertaImageViewTwo.contentMode = .scaleAspectFit
            agregarOfertaImageViewTwo.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
    }
}

