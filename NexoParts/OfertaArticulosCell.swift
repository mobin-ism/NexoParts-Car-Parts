//
//  OfertaArticulosCell.swift
//  NexoParts
//
//  Created by Creativeitem on 2/7/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit

class OfertaArticulosCell: UITableViewCell {
    
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
    
    let marcaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let searchCarIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let stateNameLabel: UILabel = {
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
    let yearLabel: UILabel = {
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
        label.numberOfLines = 2
        return label
    }()
    let chasisNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1.0)
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
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
    
    var carImage: UIImage? = nil {
        didSet {
            carImageView.image = carImage
        }
    }
    var carIcon: UIImage? = nil {
        didSet {
            carIconView.image = carIcon
        }
    }
    var marcaNameText: String? = ""{
        didSet {
            marcaLabel.text = marcaNameText
        }
    }
    var searchCarIcon: UIImage? = nil {
        didSet {
            searchCarIconView.image = searchCarIcon
        }
    }
    var stateNameText: String? = ""{
        didSet {
            stateNameLabel.text = stateNameText
        }
    }
    var calendarIcon: UIImage? = nil {
        didSet {
            calendarIconView.image = calendarIcon
        }
    }
    var yearTxt: String? = ""{
        didSet {
            yearLabel.text = yearTxt
        }
    }
    var articuloTitleText: String? = ""{
        didSet {
            articulosLabel.text = articuloTitleText
        }
    }
    var chasisNumberText: String? = ""{
        didSet {
            chasisNumberLabel.text = chasisNumberText
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = BG_COLOR
        self.selectionStyle = .default
        setupSubviews()
    }
    
    func setupSubviews() {
        showCarImage()
        setupCarIcon()
        setupMarcaLabel()
        setupSearchCarIcon()
        setupStateLabel()
        setupCalendarIcon()
        setUpYearLabel()
        setUpArticuloLabel()
        setUpChasisNumberLabel()
        setupGreenIconButton()
    }
    func showCarImage(){
        self.addSubview(carImageView)
        carImageView.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        carImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        carImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        carImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65).isActive = true
    }
    
    func setupCarIcon(){
        self.addSubview(carIconView)
        carIconView.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        carIconView.leftAnchor.constraint(equalTo: carImageView.rightAnchor, constant: 5).isActive = true
        carIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        carIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func setupMarcaLabel() {
        self.addSubview(marcaLabel)
        marcaLabel.centerYAnchor.constraint(equalTo: carIconView.centerYAnchor).isActive = true
        marcaLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        marcaLabel.leftAnchor.constraint(equalTo: carIconView.rightAnchor, constant: 5).isActive = true
        marcaLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
    }
    func setupSearchCarIcon(){
        self.addSubview(searchCarIconView)
        searchCarIconView.topAnchor.constraint(equalTo: carIconView.bottomAnchor, constant:10).isActive = true
        searchCarIconView.leftAnchor.constraint(equalTo: carImageView.rightAnchor, constant: 5).isActive = true
        searchCarIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        searchCarIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func setupStateLabel(){
        self.addSubview(stateNameLabel)
        stateNameLabel.centerYAnchor.constraint(equalTo: searchCarIconView.centerYAnchor).isActive = true
        stateNameLabel.topAnchor.constraint(equalTo: marcaLabel.bottomAnchor, constant: 5).isActive = true
        stateNameLabel.leftAnchor.constraint(equalTo: searchCarIconView.rightAnchor, constant: 5).isActive = true
        stateNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
    }
    func setupCalendarIcon(){
        self.addSubview(calendarIconView)
        calendarIconView.topAnchor.constraint(equalTo: searchCarIconView.bottomAnchor, constant:10).isActive = true
        calendarIconView.leftAnchor.constraint(equalTo: carImageView.rightAnchor, constant: 5).isActive = true
        calendarIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        calendarIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func setUpYearLabel(){
        self.addSubview(yearLabel)
        yearLabel.centerYAnchor.constraint(equalTo: calendarIconView.centerYAnchor).isActive = true
        yearLabel.topAnchor.constraint(equalTo: stateNameLabel.bottomAnchor, constant: 5).isActive = true
        yearLabel.leftAnchor.constraint(equalTo: calendarIconView.rightAnchor, constant: 5).isActive = true
        yearLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
    }
    func setUpArticuloLabel(){
        self.addSubview(articulosLabel)
        articulosLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        articulosLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        articulosLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
        
    }
    func setUpChasisNumberLabel(){
        self.addSubview(chasisNumberLabel)
        chasisNumberLabel.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor).isActive = true
        chasisNumberLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        chasisNumberLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
    }
    func setupGreenIconButton(){
        self.addSubview(greenIconNuevaCotizacionButton)
        greenIconNuevaCotizacionButton.centerYAnchor.constraint(equalTo: stateNameLabel.centerYAnchor).isActive = true
        greenIconNuevaCotizacionButton.leftAnchor.constraint(equalTo: articulosLabel.rightAnchor).isActive = true
        greenIconNuevaCotizacionButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        greenIconNuevaCotizacionButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

