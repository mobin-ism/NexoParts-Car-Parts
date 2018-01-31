//
//  SelectorCell.swift
//  NexoParts
//
//  Created by Creativeitem on 6/7/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit

class CotizacionCell: UITableViewCell {
    
    var cvc = CotizacionesViewController()
    
    let cotizacionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let clipboardIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let cotizacionNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let idCardIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let clientNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let calendarIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let articulosLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1.0).cgColor
        label.textAlignment = .center
        return label
    }()
    lazy var greenIconNuevaCotizacionButton: UIButton = {
        let greenIconButton = UIButton(type: .system)
        greenIconButton.setTitle("▶︎", for: .normal)
        greenIconButton.setTitleColor(GREEN_ICON_COLOR, for: .normal)
        greenIconButton.translatesAutoresizingMaskIntoConstraints = false
        //greenIconButton.addTarget(self, action: #selector(handleNuevaCotizacion), for: .touchUpInside)
        greenIconButton.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        greenIconButton.layer.shadowRadius = 2
        greenIconButton.layer.shadowOpacity = 0.8
        greenIconButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        return greenIconButton
    }()
    
    var cotizacionImage: UIImage? = nil {
        didSet {
            cotizacionImageView.image = cotizacionImage
        }
    }
    var clipboardIcon: UIImage? = nil {
        didSet {
            clipboardIconView.image = clipboardIcon
        }
    }
    var cotizacionNumberText: String? = ""{
        didSet {
            cotizacionNumberLabel.text = cotizacionNumberText
        }
    }
    var idCardIcon: UIImage? = nil {
        didSet {
            idCardIconView.image = idCardIcon
        }
    }
    var clientNameText: String? = ""{
        didSet {
            clientNameLabel.text = clientNameText
        }
    }
    var calendarIcon: UIImage? = nil {
        didSet {
            calendarIconView.image = calendarIcon
        }
    }
    var dateText: String? = ""{
        didSet {
            dateLabel.text = dateText
        }
    }
    var articuloTitleText: String? = ""{
        didSet {
            articulosLabel.text = articuloTitleText
        }
    }
    var statusText: String? = ""{
        didSet {
            statusLabel.text = statusText
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = BG_COLOR
        self.selectionStyle = .default
        setupSubviews()
    }
    
    func setupSubviews() {
        showCotizacionImage()
        setupClipboardIcon()
        setupCotizacionNumberLabel()
        setupIdCardIcon()
        setupClientLabel()
        setupCalendarIcon()
        setUpDateLabel()
        setUpArticuloLabel()
        setUpStatusLabel()
        setupGreenIconButton()
    }
    func showCotizacionImage(){
        self.addSubview(cotizacionImageView)
        cotizacionImageView.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        cotizacionImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        cotizacionImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        cotizacionImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65).isActive = true
    }
    
    func setupClipboardIcon(){
        self.addSubview(clipboardIconView)
        clipboardIconView.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        clipboardIconView.leftAnchor.constraint(equalTo: cotizacionImageView.rightAnchor, constant: 5).isActive = true
        clipboardIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        clipboardIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func setupCotizacionNumberLabel() {
        self.addSubview(cotizacionNumberLabel)
        cotizacionNumberLabel.centerYAnchor.constraint(equalTo: clipboardIconView.centerYAnchor).isActive = true
        cotizacionNumberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        cotizacionNumberLabel.leftAnchor.constraint(equalTo: clipboardIconView.rightAnchor, constant: 5).isActive = true
        cotizacionNumberLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
    }
    func setupIdCardIcon(){
        self.addSubview(idCardIconView)
        idCardIconView.topAnchor.constraint(equalTo: clipboardIconView.bottomAnchor, constant:10).isActive = true
        idCardIconView.leftAnchor.constraint(equalTo: cotizacionImageView.rightAnchor, constant: 5).isActive = true
        idCardIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        idCardIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func setupClientLabel(){
        self.addSubview(clientNameLabel)
        clientNameLabel.centerYAnchor.constraint(equalTo: idCardIconView.centerYAnchor).isActive = true
        clientNameLabel.topAnchor.constraint(equalTo: cotizacionNumberLabel.bottomAnchor, constant: 5).isActive = true
        clientNameLabel.leftAnchor.constraint(equalTo: idCardIconView.rightAnchor, constant: 5).isActive = true
        clientNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
    }
    func setupCalendarIcon(){
        self.addSubview(calendarIconView)
        calendarIconView.topAnchor.constraint(equalTo: idCardIconView.bottomAnchor, constant:10).isActive = true
        calendarIconView.leftAnchor.constraint(equalTo: cotizacionImageView.rightAnchor, constant: 5).isActive = true
        calendarIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        calendarIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func setUpDateLabel(){
        self.addSubview(dateLabel)
        dateLabel.centerYAnchor.constraint(equalTo: calendarIconView.centerYAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: clientNameLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: calendarIconView.rightAnchor, constant: 5).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
    }
    func setUpArticuloLabel(){
        self.addSubview(articulosLabel)
        articulosLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        articulosLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        articulosLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
        
    }
    func setUpStatusLabel(){
        self.addSubview(statusLabel)
        statusLabel.topAnchor.constraint(equalTo: articulosLabel.bottomAnchor, constant: 10).isActive = true
        statusLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        statusLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
    }
    func setupGreenIconButton(){
        self.addSubview(greenIconNuevaCotizacionButton)
        greenIconNuevaCotizacionButton.centerYAnchor.constraint(equalTo: clientNameLabel.centerYAnchor).isActive = true
        greenIconNuevaCotizacionButton.leftAnchor.constraint(equalTo: articulosLabel.rightAnchor).isActive = true
        greenIconNuevaCotizacionButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        greenIconNuevaCotizacionButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05).isActive = true
    }
    func handleNuevaCotizacion(){
        //print("Nueva Cotizacion")
        DispatchQueue.main.async {
            self.cvc.handleNuevaCotizacion()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

