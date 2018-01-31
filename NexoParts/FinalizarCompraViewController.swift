//
//  FinalizarCompraViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 8/2/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire

struct PaymentResponse: Decodable {
    let Result: String
}

class FinalizarCompraViewController : UIViewController, UIScrollViewDelegate{
    
    var paymentMethodArray = [PaymentMethod]()
    var yearModelArray = [YearModel]()
    var monthModelArary = [MonthModel]()
    var paymentMethodList = ["Visa", "Mastercard", "Cheque o Transferencia Bancaria"]
    var totalBill: Float! = 0.00
    var totalBillWithPagueloFacilCharge: Float! = 0.00
    var yearArray = [Int]()
    var monthArray = [Int]()
    var selectedCotizacionID : String!
    var cardNumber : String = ""
    var cardSecurityCode: String = ""
    
    var selectedYear : Int = 0
    var selectedMonth: Int = 0
    
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
        return imageView
    }()
    let finalizarCompraLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = DEEP_BLUE_COLOR
        label.font = UIFont(name: TEXT_FONT, size: 28)
        label.text = "Finalizar Compra"
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
    let metodoDePagoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.text = "Metodo De Pago"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let metodoDePagoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Metodo De Pago ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePaymentMethodButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 14)
        return button
    }()
    let numeroDeTarjetaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.text = "Numero De Tarjeta"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var numeroDeTarjetaTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Numero De Tarjeta", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.cornerRadius = 10
        field.layer.shadowOpacity = 0.8
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        return field
    }()
    let codigoDeSeguridadLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.text = "Codigo De Seguridad"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var codigoDeSeguridadTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Codigo De Seguridad", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        field.layer.shadowRadius = 2
        field.layer.shadowOpacity = 0.8
        field.layer.cornerRadius = 10
        field.layer.shadowOffset = CGSize(width: 0, height: 3)
        return field
    }()
    let fechaDeExpiracionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.text = "Fecha de Expiracion"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let fechaDeExpiracionYearButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Year ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlefechaDeExpiracionYearButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 14)
        return button
    }()
    let fechaDeExpiracionMonthButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Month ▼", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlefechaDeExpiracionMonthButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 14)
        return button
    }()
    let nombreDeTarjetaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.text = "Nombre de Tarjeta"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var nombreDeTarjetaTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(string: "Nombre De Tarjeta", attributes: [NSFontAttributeName: UIFont(name: TEXT_FONT, size: 14)!])
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

    let comprarButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"wallet-small"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 5)
        button.titleEdgeInsets = UIEdgeInsets(top: 5,left: 0,bottom: 0,right: 0)
        button.setTitle("Comprar", for: .normal)
        button.setTitleColor(DEEP_BLUE_COLOR, for: .normal)
        button.backgroundColor = GREEN_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleComprarButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.titleLabel?.font = UIFont(name: TEXT_FONT, size: 22)
        return button
    }()
    let totalBillTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Total Neto B/.   "
        label.textColor = UIColor.white
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:1.0).cgColor
        label.numberOfLines = 0
        return label
    }()
    let totalBillLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "0.00"
        label.textColor = GREEN_COLOR
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:1.0).cgColor
        label.numberOfLines = 0
        return label
    }()
    let itbmsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Precio incluye Cargos Administrativos"
        label.textColor = .white
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:1.0).cgColor
        label.numberOfLines = 2
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

        //setup view
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.selectedYear = 0
        self.selectedMonth = 0
        
        if !self.paymentMethodArray.isEmpty {
            self.paymentMethodArray.removeAll()
        }
        for paymentMethod in paymentMethodList {
            let payment = PaymentMethod(paymentMethodName: paymentMethod)
            self.paymentMethodArray.append(payment)
        }
        
        if !self.yearArray.isEmpty{
            self.yearArray.removeAll()
        }
        if !self.yearModelArray.isEmpty{
            self.yearModelArray.removeAll()
        }
        
        if !self.monthArray.isEmpty{
            self.monthArray.removeAll()
        }
        if !self.monthModelArary.isEmpty{
            self.monthModelArary.removeAll()
        }
        
        //Appending Month and Year Array
        for i in 1...12{
            self.monthArray.append(i)
        }
        for i in 2017...2030{
            self.yearArray.append(i)
        }
        
        for year in yearArray{
            let data = YearModel(year: year)
            self.yearModelArray.append(data)
        }
        for month in monthArray{
            let data = MonthModel(month: month)
            self.monthModelArary.append(data)
        }
        
        //total bill with PagueloFacil
        self.calculateTotalBillWithPagueloFacil()
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    func customizeNavigationBar(){
        view.backgroundColor = BG_COLOR
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "Finaizar Compra"
        
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
        metodoDePagoButton.layer.cornerRadius = metodoDePagoButton.frame.height / 2
        numeroDeTarjetaTextField.layer.cornerRadius = numeroDeTarjetaTextField.frame.height / 2
        codigoDeSeguridadTextField.layer.cornerRadius = codigoDeSeguridadTextField.frame.height / 2
        fechaDeExpiracionYearButton.layer.cornerRadius = fechaDeExpiracionYearButton.frame.height / 2
        fechaDeExpiracionMonthButton.layer.cornerRadius = fechaDeExpiracionMonthButton.frame.height / 2
        nombreDeTarjetaTextField.layer.cornerRadius = nombreDeTarjetaTextField.frame.height / 2
        
        // set scroll view's content size
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + (view.frame.height)
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 150)
    }
    
    lazy var selector: Selector = {
        let select = Selector()
        select.finalizarCompraVC = self
        return select
    }()
    
    func handleComprarButton(){
        self.cardNumber = self.numeroDeTarjetaTextField.text!
        self.cardSecurityCode = self.codigoDeSeguridadTextField.text!
        if self.cardNumber == "" || self.cardSecurityCode == "" || self.selectedMonth == 0 || self.selectedYear == 0 || self.totalBill == 0.00{
            self.showAlert(title: "¡Advertencia!", message: "Rellena todos los campos")
            return
        }
        self.confirmPayment()
    }
    func handlefechaDeExpiracionYearButton(){
        self.selector.show(withData: yearModelArray)
    }
    func handlefechaDeExpiracionMonthButton(){
        self.selector.show(withData: monthModelArary)
    }
    func handlePaymentMethodButton(){
        self.selector.show(withData: paymentMethodArray)
    }
    func changeSelectorTitleForPaymentMethod(withString title: String){
        self.metodoDePagoButton.setTitle(title, for: .normal)
    }
    func changeSelectorTitleForYear(withString title: String){
        self.fechaDeExpiracionYearButton.setTitle(title, for: .normal)
    }
    func changeSelectorTitleForMonth(withString title: String){
        self.fechaDeExpiracionMonthButton.setTitle(title, for: .normal)
    }
    func setUpUI(){
        setupEnlightenedLabel()
        setupWalletIconView()
        setupNonEnlightenedLabelOne()
        setupShipphingCartDoneIconView()
        setupNonEnlightenedLabelTwo()
        setupShipphingCartIconView()
        setupFinalizarCompraLabel()
        setupHorizontalLineLabelOne()
        
        setupComprarButton()
        setupHorizontalLineLabelTwo()
        setupTotalBillTitleLabel()
        setupTotalBillLabel()
        setupITBMSLabel()
        
        setupScrollView()
        setupMetodoDePagoLabel()
        setupMetodoDePagoButton()
        setupNumeroDeTarjetaLabel()
        setupNumeroDeTarjetaTextField()
        setupCodigoDeSeguridadLabel()
        setupCodigoDeSeguridadTextField()
        setupFechaDeExpiracionLabel()
        setupFechaDeExpiracionYearButton()
        setupfechaDeExpiracionMonthButton()
        setupNombreDeTarjetaLabel()
        setupNombreDeTarjetaTextField()
        
        setupActivityIndicator()
    }
    func setupEnlightenedLabel(){
        view.addSubview(enlightenedLabel)
        enlightenedLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        enlightenedLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        enlightenedLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20).isActive = true
        enlightenedLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20).isActive = true
    }
    func setupWalletIconView(){
        view.addSubview(walletIconView)
        walletIconView.topAnchor.constraint(equalTo: enlightenedLabel.topAnchor, constant: 12).isActive = true
        walletIconView.leftAnchor.constraint(equalTo: enlightenedLabel.leftAnchor, constant: 12).isActive = true
        walletIconView.rightAnchor.constraint(equalTo: enlightenedLabel.rightAnchor, constant: -12).isActive = true
        walletIconView.bottomAnchor.constraint(equalTo: enlightenedLabel.bottomAnchor, constant: -12).isActive = true
    }
    func setupNonEnlightenedLabelOne(){
        view.addSubview(nonEnlightenedLabelOne)
        nonEnlightenedLabelOne.centerYAnchor.constraint(equalTo: enlightenedLabel.centerYAnchor).isActive = true
        nonEnlightenedLabelOne.rightAnchor.constraint(equalTo: enlightenedLabel.leftAnchor, constant: -15).isActive = true
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
        nonEnlightenedLabelTwo.rightAnchor.constraint(equalTo: nonEnlightenedLabelOne.leftAnchor, constant: -15).isActive = true
        nonEnlightenedLabelTwo.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        nonEnlightenedLabelTwo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
    }
    func setupShipphingCartIconView(){
        view.addSubview(shippingCartIconView)
        shippingCartIconView.topAnchor.constraint(equalTo: nonEnlightenedLabelTwo.topAnchor, constant: 7).isActive = true
        shippingCartIconView.leftAnchor.constraint(equalTo: nonEnlightenedLabelTwo.leftAnchor, constant: 7).isActive = true
        shippingCartIconView.rightAnchor.constraint(equalTo: nonEnlightenedLabelTwo.rightAnchor, constant: -7).isActive = true
        shippingCartIconView.bottomAnchor.constraint(equalTo: nonEnlightenedLabelTwo.bottomAnchor, constant: -7).isActive = true
    }
    
    func setupFinalizarCompraLabel(){
        view.addSubview(finalizarCompraLabel)
        finalizarCompraLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        finalizarCompraLabel.topAnchor.constraint(equalTo: enlightenedLabel.bottomAnchor, constant: 15).isActive = true
    }
    func setupHorizontalLineLabelOne(){
        view.addSubview(horizontalLineLabelOne)
        horizontalLineLabelOne.topAnchor.constraint(equalTo: finalizarCompraLabel.bottomAnchor, constant: 10).isActive = true
        horizontalLineLabelOne.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalLineLabelOne.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalLineLabelOne.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.004).isActive = true
    }
    
    func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: horizontalLineLabelOne.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: totalBillTitleLabel.topAnchor).isActive = true
    }
    
    func setupMetodoDePagoLabel(){
        scrollView.addSubview(metodoDePagoLabel)
        metodoDePagoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25).isActive = true
        metodoDePagoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        metodoDePagoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    func setupMetodoDePagoButton(){
        scrollView.addSubview(metodoDePagoButton)
        metodoDePagoButton.centerYAnchor.constraint(equalTo: metodoDePagoLabel.centerYAnchor).isActive = true
        metodoDePagoButton.leftAnchor.constraint(equalTo: metodoDePagoLabel.rightAnchor, constant: 10).isActive = true
        metodoDePagoButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:0.045).isActive = true
        metodoDePagoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
    }
    func setupNumeroDeTarjetaLabel(){
        scrollView.addSubview(numeroDeTarjetaLabel)
        numeroDeTarjetaLabel.topAnchor.constraint(equalTo: metodoDePagoButton.bottomAnchor, constant: 15).isActive = true
        numeroDeTarjetaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        numeroDeTarjetaLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    func setupNumeroDeTarjetaTextField(){
        scrollView.addSubview(numeroDeTarjetaTextField)
        numeroDeTarjetaTextField.centerYAnchor.constraint(equalTo: numeroDeTarjetaLabel.centerYAnchor).isActive = true
        numeroDeTarjetaTextField.leftAnchor.constraint(equalTo: numeroDeTarjetaLabel.rightAnchor, constant: 10).isActive = true
        numeroDeTarjetaTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:0.045).isActive = true
        numeroDeTarjetaTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
    }
    func setupCodigoDeSeguridadLabel(){
        scrollView.addSubview(codigoDeSeguridadLabel)
        codigoDeSeguridadLabel.topAnchor.constraint(equalTo: numeroDeTarjetaTextField.bottomAnchor, constant: 15).isActive = true
        codigoDeSeguridadLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        codigoDeSeguridadLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    func setupCodigoDeSeguridadTextField(){
        scrollView.addSubview(codigoDeSeguridadTextField)
        codigoDeSeguridadTextField.centerYAnchor.constraint(equalTo: codigoDeSeguridadLabel.centerYAnchor).isActive = true
        codigoDeSeguridadTextField.leftAnchor.constraint(equalTo: codigoDeSeguridadLabel.rightAnchor, constant: 10).isActive = true
        codigoDeSeguridadTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:0.045).isActive = true
        codigoDeSeguridadTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
    }
    func setupFechaDeExpiracionLabel(){
        scrollView.addSubview(fechaDeExpiracionLabel)
        fechaDeExpiracionLabel.topAnchor.constraint(equalTo: codigoDeSeguridadTextField.bottomAnchor, constant: 15).isActive = true
        fechaDeExpiracionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        fechaDeExpiracionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    func setupFechaDeExpiracionYearButton(){
        scrollView.addSubview(fechaDeExpiracionYearButton)
        fechaDeExpiracionYearButton.centerYAnchor.constraint(equalTo: fechaDeExpiracionLabel.centerYAnchor).isActive = true
        fechaDeExpiracionYearButton.leftAnchor.constraint(equalTo: fechaDeExpiracionLabel.rightAnchor, constant: 10).isActive = true
        fechaDeExpiracionYearButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:0.045).isActive = true
        fechaDeExpiracionYearButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.24).isActive = true
    }
    func setupfechaDeExpiracionMonthButton(){
        scrollView.addSubview(fechaDeExpiracionMonthButton)
        fechaDeExpiracionMonthButton.centerYAnchor.constraint(equalTo: fechaDeExpiracionLabel.centerYAnchor).isActive = true
        fechaDeExpiracionMonthButton.leftAnchor.constraint(equalTo: fechaDeExpiracionYearButton.rightAnchor, constant: 5).isActive = true
        fechaDeExpiracionMonthButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:0.045).isActive = true
        fechaDeExpiracionMonthButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
    }
    func setupNombreDeTarjetaLabel(){
        scrollView.addSubview(nombreDeTarjetaLabel)
        nombreDeTarjetaLabel.topAnchor.constraint(equalTo: fechaDeExpiracionYearButton.bottomAnchor, constant: 15).isActive = true
        nombreDeTarjetaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        nombreDeTarjetaLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    func setupNombreDeTarjetaTextField(){
        scrollView.addSubview(nombreDeTarjetaTextField)
        nombreDeTarjetaTextField.centerYAnchor.constraint(equalTo: nombreDeTarjetaLabel.centerYAnchor).isActive = true
        nombreDeTarjetaTextField.leftAnchor.constraint(equalTo: nombreDeTarjetaLabel.rightAnchor, constant: 10).isActive = true
        nombreDeTarjetaTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:0.045).isActive = true
        nombreDeTarjetaTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
    }
    func setupComprarButton(){
        view.addSubview(comprarButton)
        comprarButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        comprarButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        comprarButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        comprarButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    func setupHorizontalLineLabelTwo(){
        view.addSubview(horizontalLineLabelTwo)
        horizontalLineLabelTwo.bottomAnchor.constraint(equalTo: comprarButton.topAnchor).isActive = true
        horizontalLineLabelTwo.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalLineLabelTwo.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalLineLabelTwo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.006).isActive = true
    }
    func setupTotalBillTitleLabel(){
        view.addSubview(totalBillTitleLabel)
        totalBillTitleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        totalBillTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        totalBillTitleLabel.bottomAnchor.constraint(equalTo: horizontalLineLabelTwo.topAnchor).isActive = true
        totalBillTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    func setupTotalBillLabel(){
        view.addSubview(totalBillLabel)
        totalBillLabel.heightAnchor.constraint(equalTo: totalBillTitleLabel.heightAnchor, multiplier: 1).isActive = true
        totalBillLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        totalBillLabel.bottomAnchor.constraint(equalTo: horizontalLineLabelTwo.topAnchor).isActive = true
        totalBillLabel.leftAnchor.constraint(equalTo: totalBillTitleLabel.rightAnchor).isActive = true
    }
    func setupITBMSLabel(){
        view.addSubview(itbmsLabel)
        itbmsLabel.heightAnchor.constraint(equalTo: totalBillTitleLabel.heightAnchor, multiplier: 1).isActive = true
        itbmsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        itbmsLabel.bottomAnchor.constraint(equalTo: horizontalLineLabelTwo.topAnchor).isActive = true
        itbmsLabel.leftAnchor.constraint(equalTo: totalBillLabel.rightAnchor).isActive = true
    }
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    // API Call
    func confirmPayment(){
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)payment/\(UserDefaults.standard.value(forKey: USER_ID) as! String)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "card_number" : self.cardNumber,
                      "card_security_code" : self.cardSecurityCode,
                      "amount_to_pay" : self.totalBillWithPagueloFacilCharge,
                      "selected_year" : self.selectedYear,
                      "selected_month" : self.selectedMonth,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in
            self.activityIndicator.startAnimating()
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                print(response.result)
                return
            }
            print(response)
            self.activityIndicator.stopAnimating()
            
            // json decode swift 4
            let responsedata = response.data!
            let decoder = JSONDecoder()
            let result = try! decoder.decode(PaymentResponse.self, from: responsedata)
            if result.Result == "Declined"{
                self.showAlert(title: "¡Lo siento!", message: "Payment " + result.Result)
            }
            else if result.Result == "Approved"{
                self.sendConfirmationMail()
                self.showAlert(title: "¡¡Felicitaciones!!", message: "Payment " + result.Result)
            }
            else{
                self.showAlert(title:"¡Error!", message: result.Result)
            }
        })
    }
    
    func sendConfirmationMail(){
        // send mail and notifications
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)send_payment_confirmation_mail/\(self.selectedCotizacionID!)/\(self.totalBill!)/\(self.totalBillWithPagueloFacilCharge!)") else {return}
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
    
    func showAlert(title: String!, message: String!){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Cerca", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showBankInfoAlert(){
        let message = "Banco: Banesco\nNombre de Cuenta: Grupo Garrison S.A\nTipo de Cuenta: Cuenta Corriente\nNumero de Cuenta: 110000053236"
        let alertController = UIAlertController(title: "Información Bancaria", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ordenar", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.changeCotizacionStatus()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func changeCotizacionStatus(){
        // send mail and notifications
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)change_cotizacion_status/\(self.selectedCotizacionID!)") else {return}
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            guard response.result.isSuccess else {
                self.activityIndicator.stopAnimating()
                print(response.result)
                return
            }
            self.activityIndicator.stopAnimating()
            print(response)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func calculateTotalBillWithPagueloFacil(){
        //self.totalBillLabel.text = "\(self.totalBill!)"
        let pagueloFacilCharge = self.totalBill * 0.0495
        self.totalBillWithPagueloFacilCharge = self.totalBill + pagueloFacilCharge
        self.totalBillLabel.text = "\(self.totalBillWithPagueloFacilCharge!)"
    }
    
}
