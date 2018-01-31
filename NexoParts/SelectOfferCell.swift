//
//  SelectOfferCell.swift
//  NexoParts
//
//  Created by Creativeitem on 7/10/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class SelectOfferCell : UITableViewCell{
    
    var toggleColor : Int! = 0
    var offerDetailsVC = OfferDetailsViewController()
    var checkStatus : String!
    
    let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let carIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let carModelTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let offerStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.layer.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1.0).cgColor
        return label
    }()
    
    let estadoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.backgroundColor = UIColor(red:1.00, green:0.44, blue:0.26, alpha:1.0).cgColor
        return label
    }()
    
    let piezaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.backgroundColor = GREEN_COLOR.cgColor
        return label
    }()
    
    let garantiaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:1.0).cgColor
        return label
    }()
    
    let offerPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Precio"
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let offerPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var selectGreenDotButton: UIButton = {
        let greenIconButton = UIButton(type: .system)
        greenIconButton.setTitle("◉", for: .normal)
        greenIconButton.setTitleColor(GRAY_COLOR, for: .normal)
        greenIconButton.translatesAutoresizingMaskIntoConstraints = false
        greenIconButton.addTarget(self, action: #selector(checkSelection), for: .touchUpInside)
        greenIconButton.titleLabel!.font =  UIFont(name: TEXT_FONT, size: 22)
        return greenIconButton
    }()
    
    var carModelImage: UIImage? = nil {
        didSet {
            carImageView.image = carModelImage
        }
    }
    var carIcon: UIImage? = nil {
        didSet {
            carIconView.image = carIcon
        }
    }
    var carModelName: String? = ""{
        didSet {
            carModelTitleLabel.text = carModelName
        }
    }
    var offerStatus: String? = "" {
        didSet {
            offerStatusLabel.text = offerStatus
        }
    }
    var offerPrice: String? = "" {
        didSet {
            offerPriceLabel.text = offerPrice
        }
    }
    var estado: String? = "" {
        didSet {
            estadoLabel.text = estado
        }
    }
    var pieza: String? = "" {
        didSet {
            piezaLabel.text = pieza
        }
    }
    var garantia: String? = "" {
        didSet {
            garantiaLabel.text = garantia
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = BG_COLOR
        self.selectionStyle = .default
        setupSubviews()
        self.isAdded(_offerId: UserDefaults.standard.value(forKey: OFFER_ID) as! String, _cotizacinoNumber: UserDefaults.standard.value(forKey: SELECTED_COTIZACION) as! String)
    }
    
    func checkSelection(){
        if(self.toggleColor == 0){
            self.selectGreenDotButton.setTitleColor(UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0), for: .normal)
            self.toggleColor = 1
        }
        else{
            self.selectGreenDotButton.setTitleColor(GRAY_COLOR, for: .normal)
            self.toggleColor = 0
        }
    }
    
    func setupSubviews() {
        showCarImage()
        showCarIconImage()
        showCarModelName()
        showOfferStatus()
        showPiezaLabel()
        showEstadoLabel()
        showGarantialabel()
        showPriceTitleLabel()
        showActualPriceLabel()
        showGreenDotIcon()
    }
    func showCarImage(){
        self.addSubview(carImageView)
        carImageView.topAnchor.constraint(equalTo: self.topAnchor, constant:20).isActive = true
        carImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        carImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65).isActive = true
        carImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
    }
    func showCarIconImage(){
        self.addSubview(carIconView)
        carIconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        carIconView.leftAnchor.constraint(equalTo: carImageView.rightAnchor, constant: 5).isActive = true
        carIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.10).isActive = true
        carIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.10).isActive = true
    }
    func showCarModelName(){
        self.addSubview(carModelTitleLabel)
        carModelTitleLabel.centerYAnchor.constraint(equalTo: carIconView.centerYAnchor).isActive = true
        carModelTitleLabel.leftAnchor.constraint(equalTo: carIconView.rightAnchor, constant: 5).isActive = true
        carModelTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
    }
    func showOfferStatus(){
        self.addSubview(offerStatusLabel)
        offerStatusLabel.topAnchor.constraint(equalTo: carModelTitleLabel.bottomAnchor, constant: 5).isActive = true
        offerStatusLabel.leftAnchor.constraint(equalTo: carImageView.rightAnchor, constant: 5).isActive = true
        offerStatusLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func showPiezaLabel(){
        self.addSubview(piezaLabel)
        piezaLabel.topAnchor.constraint(equalTo: offerStatusLabel.bottomAnchor, constant: 5).isActive = true
        piezaLabel.leftAnchor.constraint(equalTo: carImageView.rightAnchor, constant: 5).isActive = true
        piezaLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func showEstadoLabel(){
        self.addSubview(estadoLabel)
        estadoLabel.topAnchor.constraint(equalTo: piezaLabel.bottomAnchor, constant: 5).isActive = true
        estadoLabel.leftAnchor.constraint(equalTo: carImageView.rightAnchor, constant: 5).isActive = true
        estadoLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func showGarantialabel(){
        self.addSubview(garantiaLabel)
        garantiaLabel.topAnchor.constraint(equalTo: estadoLabel.bottomAnchor, constant: 5).isActive = true
        garantiaLabel.leftAnchor.constraint(equalTo: carImageView.rightAnchor, constant: 5).isActive = true
        garantiaLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func showPriceTitleLabel(){
        self.addSubview(offerPriceTitleLabel)
        offerPriceTitleLabel.centerYAnchor.constraint(equalTo: self.carImageView.centerYAnchor).isActive = true
        offerPriceTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        offerPriceTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35).isActive = true
    }
    func showActualPriceLabel(){
        self.addSubview(offerPriceLabel)
        offerPriceLabel.topAnchor.constraint(equalTo: offerPriceTitleLabel.bottomAnchor, constant: 5).isActive = true
        offerPriceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        offerPriceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35).isActive = true
    }
    func showGreenDotIcon(){
        self.addSubview(selectGreenDotButton)
        selectGreenDotButton.centerYAnchor.constraint(equalTo: carImageView.centerYAnchor).isActive = true
        selectGreenDotButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        selectGreenDotButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.07).isActive = true
    }
    
    func isAdded(_offerId: String!, _cotizacinoNumber: String!){
        guard let url = URL(string: "\(API_URL)is_added_to_cart/\(UserDefaults.standard.value(forKey: USER_ID) as! String)/\(UserDefaults.standard.value(forKey: SELECTED_COTIZACION) as! String)/\(UserDefaults.standard.value(forKey: OFFER_ID) as! String)") else { return }
        let params = ["auth_token": UserDefaults.standard.value(forKey: USER_AUTH_TOKEN) as! String,
                      "user_id": UserDefaults.standard.value(forKey: USER_ID) as! String,
                      "authenticate": "true"] as [String: Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseString(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response.result)
                return
            }
            self.checkStatus = response.result.value!
            if self.checkStatus == "Exists" {
                self.selectGreenDotButton.setTitleColor(UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0), for: .normal)
                self.toggleColor = 1
            }
            else{
                self.selectGreenDotButton.setTitleColor(GRAY_COLOR, for: .normal)
                self.toggleColor = 0
            }
        })
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

