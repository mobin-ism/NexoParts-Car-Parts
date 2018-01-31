//
//  ResumenDeCompraCell.swift
//  NexoParts
//
//  Created by Creativeitem on 8/2/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit

class ResumenDeCompraCell: UITableViewCell {
    
    var resumenVC = ResumenDeCompraViewController()
    
    let hiddenOfferIdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
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
    let keyIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let modelLabel: UILabel = {
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
    let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.layer.cornerRadius = 5
        label.layer.backgroundColor = UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0).cgColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let valorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Valor:"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let valorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red:0.55, green:0.76, blue:0.29, alpha:1.0)
        label.font = UIFont(name: BOLD_TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let crossIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var hiddenOfferId: String? = ""{
        didSet {
            hiddenOfferIdLabel.text = hiddenOfferId
        }
    }
    var carIcon: UIImage? = nil {
        didSet {
            carIconView.image = carIcon
        }
    }
    var marca: String? = ""{
        didSet {
            marcaLabel.text = marca
        }
    }
    var keyIcon: UIImage? = nil {
        didSet {
            keyIconView.image = keyIcon
        }
    }
    var model: String? = ""{
        didSet {
            modelLabel.text = model
        }
    }
    var calendarIcon: UIImage? = nil {
        didSet {
            calendarIconView.image = calendarIcon
        }
    }
    var year: String? = ""{
        didSet {
            yearLabel.text = year
        }
    }
    var articleTitle: String? = ""{
        didSet {
            articleTitleLabel.text = articleTitle
        }
    }
    var status: String? = ""{
        didSet {
            statusLabel.text = status
        }
    }
    var valorTitle: String? = ""{
        didSet {
            valorTitleLabel.text = valorTitle
        }
    }
    var valor: String? = ""{
        didSet {
            valorLabel.text = valor
        }
    }
    var crossIcon: UIImage? = nil {
        didSet {
            crossIconView.image = crossIcon
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = BG_COLOR
        self.selectionStyle = .default
        
        setupSubviews()
    }
    
    func setupSubviews() {
        showCarIcon()
        showMarcaLabel()
        showKeyIcon()
        showModelLabel()
        showCalendarIcon()
        showYearLabel()
        showArticleTitle()
        showStatusLabel()
        showValorTitle()
        showValor()
        showCrossIcon()
    }
    func showCarIcon(){
        self.addSubview(carIconView)
        carIconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        carIconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        carIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        carIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func showMarcaLabel(){
        self.addSubview(marcaLabel)
        marcaLabel.centerYAnchor.constraint(equalTo: carIconView.centerYAnchor).isActive = true
        marcaLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        marcaLabel.leftAnchor.constraint(equalTo: carIconView.rightAnchor, constant: 5).isActive = true
        marcaLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func showKeyIcon(){
        self.addSubview(keyIconView)
        keyIconView.topAnchor.constraint(equalTo: carIconView.bottomAnchor, constant: 10).isActive = true
        keyIconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        keyIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        keyIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func showModelLabel(){
        self.addSubview(modelLabel)
        modelLabel.centerYAnchor.constraint(equalTo: keyIconView.centerYAnchor).isActive = true
        modelLabel.leftAnchor.constraint(equalTo: keyIconView.rightAnchor, constant: 5).isActive = true
        modelLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        
    }
    func showCalendarIcon(){
        self.addSubview(calendarIconView)
        calendarIconView.topAnchor.constraint(equalTo: keyIconView.bottomAnchor, constant: 10).isActive = true
        calendarIconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        calendarIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        calendarIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func showYearLabel(){
        self.addSubview(yearLabel)
        yearLabel.centerYAnchor.constraint(equalTo: calendarIconView.centerYAnchor).isActive = true
        yearLabel.leftAnchor.constraint(equalTo: calendarIconView.rightAnchor, constant: 5).isActive = true
        yearLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func showArticleTitle(){
        self.addSubview(articleTitleLabel)
        articleTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        articleTitleLabel.leftAnchor.constraint(equalTo: marcaLabel.rightAnchor, constant: 5).isActive = true
        articleTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30).isActive = true
    }
    func showStatusLabel(){
        self.addSubview(statusLabel)
        statusLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 10).isActive = true
        statusLabel.leftAnchor.constraint(equalTo: marcaLabel.rightAnchor, constant: 5).isActive = true
        statusLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30).isActive = true
    }
    func showValorTitle(){
        self.addSubview(valorTitleLabel)
        valorTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        valorTitleLabel.leftAnchor.constraint(equalTo: articleTitleLabel.rightAnchor, constant: 5).isActive = true
        valorTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    func showValor(){
        self.addSubview(valorLabel)
        valorLabel.centerYAnchor.constraint(equalTo: modelLabel.centerYAnchor).isActive = true
        valorLabel.leftAnchor.constraint(equalTo: articleTitleLabel.rightAnchor, constant: 5).isActive = true
        valorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    func showCrossIcon(){
        self.addSubview(crossIconView)
        crossIconView.centerYAnchor.constraint(equalTo: modelLabel.centerYAnchor).isActive = true
        crossIconView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        crossIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        crossIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

