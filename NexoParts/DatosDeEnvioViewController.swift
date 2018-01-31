//
//  DatosDeEnvioViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 8/2/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class DatosDeEnvioViewController : UIViewController, UIScrollViewDelegate{
    
    var selectedCotozaciones: String!
    
    var eligeUnTransporte = [EligeUnTransporte]()
    let transportArray = ["Donaldo Guerra", "Uno Express", "Flete Chavales", "Ferguson", "Servientrega", "Transporte NexoParts", "Recoger En Tienda (Gratis)"]
    var transportID : String!
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
    let shippingCartIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "shipping-cart")
        imageView.tag = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let enlightenedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(red:0.63, green:0.78, blue:0.21, alpha:1.0).cgColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nonEnlightenedLabelOne: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0).cgColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let shippingDoneIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "shipping-cart-done")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tag = 1
        return imageView
    }()
    let nonEnlightenedLabelTwo: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0).cgColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let walletIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "wallet")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tag = 2
        return imageView
    }()
    func tap(gesture: UIGestureRecognizer) {
        print(gesture.view!.tag) // You can check for their tag and do different things based on tag
    }
    let datosDeEnvioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = DEEP_BLUE_COLOR
        label.font = UIFont(name: BOLD_TEXT_FONT, size: 28)
        label.text = "Datos De Envío"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let horizontalLineLabelOne: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(red:0.02, green:0.09, blue:0.31, alpha:1.0).cgColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let direccionDeEnvioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.text = "Direccion De Envio"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var direccionDeEnvioTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Direccion De Envio", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.cornerRadius = 10
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        return field
    }()
    let direccionDeFacturaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.text = "Direccion De Factura"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var direccionDeFacturaTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Direccion De Factura", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.cornerRadius = 10
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        return field
    }()
    let eligeUnTransporteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.text = "Elige un Transporte"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let eligeUnTransporteButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Elige Un Transporte ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleEligeUnTransporteButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 14)
        return button
    }()
    let comentariosLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.text = "Comentarios"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var comentariosTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Comentarios", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.cornerRadius = 10
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        return field
    }()
    let horizontalLineLabelTwo: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(red:0.02, green:0.09, blue:0.31, alpha:1.0).cgColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let goToPageButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Siguiente > Paso 2", for: .normal)
        button.setTitleColor(DEEP_BLUE_COLOR, for: .normal)
        button.backgroundColor = GREEN_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleGoToPage), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 22)
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
        
        //customize the navigation bar
        customizeNavigationBar()
        
        //setup view
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        if !self.eligeUnTransporte.isEmpty {
            self.eligeUnTransporte.removeAll()
        }
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    lazy var selector: Selector = {
        let select = Selector()
        select.datosDeEnvioVC = self
        return select
    }()
    func customizeNavigationBar(){
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Proceso De Compra"
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        enlightenedLabel.layer.cornerRadius = enlightenedLabel.frame.height / 2
        nonEnlightenedLabelOne.layer.cornerRadius = nonEnlightenedLabelOne.frame.height / 2
        nonEnlightenedLabelTwo.layer.cornerRadius = nonEnlightenedLabelTwo.frame.height / 2
        eligeUnTransporteButton.layer.cornerRadius = eligeUnTransporteButton.frame.height / 2
        
        // set scroll view's content size
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + (view.frame.height)
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 150)
    }
    func handleGoToPage(){
        if self.direccionDeEnvioTextField.text != "" && self.direccionDeFacturaTextField.text != "", self.comentariosTextField.text != "" && self.transportID != nil{
            self.setDatosDeEnvioData()
        }
        else{
            self.showRequiredAlert()
        }
    }
    
    func setDatosDeEnvioData(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)set_datos_de_envio_data") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "cotizacion_id": self.selectedCotozaciones!,
                      "direccion_de_envio" : self.direccionDeEnvioTextField.text!,
                      "direccion_de_factura": self.direccionDeFacturaTextField.text!,
                      "comentarios"         : self.comentariosTextField.text!,
                      "forma_de_envio"      : self.transportID!,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                return
            }
            
            self.activityIndicator.stopAnimating()
            let confirmacionVC = ConfirmacionViewController()
            confirmacionVC.selectedCotozaciones = self.selectedCotozaciones
            self.navigationController?.pushViewController(confirmacionVC, animated: true)
        })
    }
    func showRequiredAlert(){
        let alertController = UIAlertController(title: "Completa todos los campos", message: "Debes completar todos los campos a continuación", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cerca", style: .default) { UIAlertAction in
            print("Okay Pressed")
        }
        alertController.addAction(action)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    func handleEligeUnTransporteButton(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)get_eligeUnTransporte") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                return
            }
            if !self.eligeUnTransporte.isEmpty{
                self.eligeUnTransporte.removeAll()
            }
            if let responseData = response.data {
                let json = JSON(data: responseData)
                if let dictArray = json.array {
                    for dict in dictArray {
                        let transportData = EligeUnTransporte(transporteName: dict["detalle_envio"].string!, transporteID: dict["id_envio"].string!)
                        self.eligeUnTransporte.append(transportData)
                    }
                    self.activityIndicator.stopAnimating()
                    self.selector.show(withData: self.eligeUnTransporte)
                }
            }
        })
    }
    func changeSelectorTitleForTransport(withString title: String){
        self.eligeUnTransporteButton.setTitle(title, for: .normal)
    }
    func handleWallet(){
        print("Wallet")
    }
    func setUpUI(){
        setupEnlightenedLabel()
        setupShipphingCartIconView()
        setupNonEnlightenedLabelOne()
        setupShipphingCartDoneIconView()
        setupNonEnlightenedLabelTwo()
        setupWalletIconView()
        setupDatosDeEnvioLabel()
        setupHorizontalLineLabelOne()
        setupGoToPageButton()
        setupHorizontalLineLabelTwo()
        setupScrollView()
        setupDireccionDeEnvioLabel()
        setupDireccionDeEnvioTextField()
        setupDireccionDeFacturaLabel()
        setupDireccionDeFacturaTextField()
        setupEligeUnTransportLabel()
        setupEligeUnTransportButton()
        setupComentariosLabel()
        setupComentariosTextField()
        setupActivityIndicator()
        view.layoutIfNeeded()
    }
    func setupEnlightenedLabel(){
        view.addSubview(enlightenedLabel)
        enlightenedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        enlightenedLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        enlightenedLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20).isActive = true
        enlightenedLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20).isActive = true
    }
    func setupShipphingCartIconView(){
        view.addSubview(shippingCartIconView)
        shippingCartIconView.topAnchor.constraint(equalTo: enlightenedLabel.topAnchor, constant: 12).isActive = true
        shippingCartIconView.leftAnchor.constraint(equalTo: enlightenedLabel.leftAnchor, constant: 12).isActive = true
        shippingCartIconView.rightAnchor.constraint(equalTo: enlightenedLabel.rightAnchor, constant: -12).isActive = true
        shippingCartIconView.bottomAnchor.constraint(equalTo: enlightenedLabel.bottomAnchor, constant: -12).isActive = true
    }
    func setupNonEnlightenedLabelOne(){
        view.addSubview(nonEnlightenedLabelOne)
        nonEnlightenedLabelOne.centerYAnchor.constraint(equalTo: enlightenedLabel.centerYAnchor).isActive = true
        nonEnlightenedLabelOne.leftAnchor.constraint(equalTo: enlightenedLabel.rightAnchor, constant: 15).isActive = true
        nonEnlightenedLabelOne.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        nonEnlightenedLabelOne.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
    }
    func setupShipphingCartDoneIconView(){
        view.addSubview(shippingDoneIconView)
        shippingDoneIconView.topAnchor.constraint(equalTo: nonEnlightenedLabelOne.topAnchor, constant: 7).isActive = true
        shippingDoneIconView.leftAnchor.constraint(equalTo: nonEnlightenedLabelOne.leftAnchor, constant: 7).isActive = true
        shippingDoneIconView.rightAnchor.constraint(equalTo: nonEnlightenedLabelOne.rightAnchor, constant: -7).isActive = true
        shippingDoneIconView.bottomAnchor.constraint(equalTo: nonEnlightenedLabelOne.bottomAnchor, constant: -7).isActive = true
    }
    func setupNonEnlightenedLabelTwo(){
        view.addSubview(nonEnlightenedLabelTwo)
        nonEnlightenedLabelTwo.centerYAnchor.constraint(equalTo: enlightenedLabel.centerYAnchor).isActive = true
        nonEnlightenedLabelTwo.leftAnchor.constraint(equalTo: nonEnlightenedLabelOne.rightAnchor, constant: 15).isActive = true
        nonEnlightenedLabelTwo.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        nonEnlightenedLabelTwo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
    }
    func setupWalletIconView(){
        view.addSubview(walletIconView)
        walletIconView.topAnchor.constraint(equalTo: nonEnlightenedLabelTwo.topAnchor, constant: 7).isActive = true
        walletIconView.leftAnchor.constraint(equalTo: nonEnlightenedLabelTwo.leftAnchor, constant: 7).isActive = true
        walletIconView.rightAnchor.constraint(equalTo: nonEnlightenedLabelTwo.rightAnchor, constant: -7).isActive = true
        walletIconView.bottomAnchor.constraint(equalTo: nonEnlightenedLabelTwo.bottomAnchor, constant: -7).isActive = true
    }
    func setupDatosDeEnvioLabel(){
        view.addSubview(datosDeEnvioLabel)
        datosDeEnvioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datosDeEnvioLabel.topAnchor.constraint(equalTo: enlightenedLabel.bottomAnchor, constant: 15).isActive = true
    }
    func setupHorizontalLineLabelOne(){
        view.addSubview(horizontalLineLabelOne)
        horizontalLineLabelOne.topAnchor.constraint(equalTo: datosDeEnvioLabel.bottomAnchor, constant: 10).isActive = true
        horizontalLineLabelOne.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalLineLabelOne.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalLineLabelOne.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.004).isActive = true
    }
    func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: self.horizontalLineLabelOne.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.horizontalLineLabelTwo.topAnchor).isActive = true
    }
    func setupDireccionDeEnvioLabel(){
        scrollView.addSubview(direccionDeEnvioLabel)
        direccionDeEnvioLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25).isActive = true
        direccionDeEnvioLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        direccionDeEnvioLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    func setupDireccionDeEnvioTextField(){
        scrollView.addSubview(direccionDeEnvioTextField)
        direccionDeEnvioTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25).isActive = true
        direccionDeEnvioTextField.leftAnchor.constraint(equalTo: direccionDeEnvioLabel.rightAnchor, constant: 5).isActive = true
        direccionDeEnvioTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        direccionDeEnvioTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    func setupDireccionDeFacturaLabel(){
        scrollView.addSubview(direccionDeFacturaLabel)
        direccionDeFacturaLabel.topAnchor.constraint(equalTo: direccionDeEnvioTextField.bottomAnchor, constant: 10).isActive = true
        direccionDeFacturaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        direccionDeFacturaLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    func setupDireccionDeFacturaTextField(){
        scrollView.addSubview(direccionDeFacturaTextField)
        direccionDeFacturaTextField.topAnchor.constraint(equalTo: direccionDeEnvioTextField.bottomAnchor, constant: 10).isActive = true
        direccionDeFacturaTextField.leftAnchor.constraint(equalTo: direccionDeFacturaLabel.rightAnchor, constant: 5).isActive = true
        direccionDeFacturaTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        direccionDeFacturaTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    func setupEligeUnTransportLabel(){
        scrollView.addSubview(eligeUnTransporteLabel)
        eligeUnTransporteLabel.topAnchor.constraint(equalTo: direccionDeFacturaTextField.bottomAnchor, constant: 10).isActive = true
        eligeUnTransporteLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        eligeUnTransporteLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    func setupEligeUnTransportButton(){
        scrollView.addSubview(eligeUnTransporteButton)
        eligeUnTransporteButton.topAnchor.constraint(equalTo: direccionDeFacturaTextField.bottomAnchor, constant: 10).isActive = true
        eligeUnTransporteButton.leftAnchor.constraint(equalTo: eligeUnTransporteLabel.rightAnchor, constant: 5).isActive = true
        eligeUnTransporteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        eligeUnTransporteButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.045).isActive = true
    }
    func setupComentariosLabel(){
        scrollView.addSubview(comentariosLabel)
        comentariosLabel.topAnchor.constraint(equalTo: eligeUnTransporteButton.bottomAnchor, constant: 10).isActive = true
        comentariosLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        comentariosLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    func setupComentariosTextField(){
        scrollView.addSubview(comentariosTextField)
        comentariosTextField.topAnchor.constraint(equalTo: eligeUnTransporteButton.bottomAnchor, constant: 10).isActive = true
        comentariosTextField.leftAnchor.constraint(equalTo: comentariosLabel.rightAnchor, constant: 5).isActive = true
        comentariosTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        comentariosTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    func setupGoToPageButton(){
        view.addSubview(goToPageButton)
        goToPageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        goToPageButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        goToPageButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        goToPageButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    func setupHorizontalLineLabelTwo(){
        view.addSubview(horizontalLineLabelTwo)
        horizontalLineLabelTwo.bottomAnchor.constraint(equalTo: goToPageButton.topAnchor).isActive = true
        horizontalLineLabelTwo.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalLineLabelTwo.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalLineLabelTwo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.006).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

