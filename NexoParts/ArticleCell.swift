//
//  ArticleCell.swift
//  NexoParts
//
//  Created by Creativeitem on 7/15/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
class ArticleCell: UITableViewCell {
    
    let redNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.layer.cornerRadius = 5
        label.layer.backgroundColor = UIColor(red:0.78, green:0.16, blue:0.16, alpha:1.0).cgColor
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
    let modeloLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
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
        label.numberOfLines = 0
        return label
    }()
    let chasisNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let valorTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let valorLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
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
    
    var redNumber: String? = ""{
        didSet {
            redNumberLabel.text = redNumber
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
            modeloLabel.text = model
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
    var chasisNumber: String? = ""{
        didSet {
            chasisNumberLabel.text = chasisNumber
        }
    }
    var valorTitle: String? = ""{
        didSet {
            valorTitleLabel.text = valorTitle
        }
    }
    var valor: String? = ""{
        didSet {
            valorLable.text = valor
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
        showRedNumberLabel()
        showCarIcon()
        showMarcaLabel()
        showKeyIcon()
        showModelLabel()
        showCalendarIcon()
        showYearLabel()
        showCrossIconLabel()
        showArticleTitle()
        showChasisNumberLabel()
        //showValorTitleLabel()
        //showValorLabel()
    }
    func showRedNumberLabel(){
        self.addSubview(redNumberLabel)
        redNumberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        redNumberLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        redNumberLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05).isActive = true
        redNumberLabel.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05).isActive = true
    }
    func showCarIcon(){
        self.addSubview(carIconView)
        carIconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        carIconView.leftAnchor.constraint(equalTo: redNumberLabel.rightAnchor, constant: 7).isActive = true
        carIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        carIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func showMarcaLabel(){
        self.addSubview(marcaLabel)
        marcaLabel.centerYAnchor.constraint(equalTo: carIconView.centerYAnchor).isActive = true
        marcaLabel.leftAnchor.constraint(equalTo: carIconView.rightAnchor, constant: 5).isActive = true
        marcaLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.20).isActive = true
    }
    func showKeyIcon(){
        self.addSubview(keyIconView)
        keyIconView.topAnchor.constraint(equalTo: carIconView.bottomAnchor, constant: 10).isActive = true
        keyIconView.leftAnchor.constraint(equalTo: redNumberLabel.rightAnchor, constant: 7).isActive = true
        keyIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        keyIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func showModelLabel(){
        self.addSubview(modeloLabel)
        modeloLabel.centerYAnchor.constraint(equalTo: keyIconView.centerYAnchor).isActive = true
        modeloLabel.leftAnchor.constraint(equalTo: keyIconView.rightAnchor, constant: 5).isActive = true
        modeloLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.20).isActive = true
    }
    func showCalendarIcon(){
        self.addSubview(calendarIconView)
        calendarIconView.topAnchor.constraint(equalTo: keyIconView.bottomAnchor, constant: 10).isActive = true
        calendarIconView.leftAnchor.constraint(equalTo: redNumberLabel.rightAnchor, constant: 7).isActive = true
        calendarIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        calendarIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func showYearLabel(){
        self.addSubview(yearLabel)
        yearLabel.centerYAnchor.constraint(equalTo: calendarIconView.centerYAnchor).isActive = true
        yearLabel.leftAnchor.constraint(equalTo: calendarIconView.rightAnchor, constant: 5).isActive = true
        yearLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.20).isActive = true
    }
    func showArticleTitle(){
        self.addSubview(articleTitleLabel)
        articleTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        //articleTitleLabel.leftAnchor.constraint(equalTo: marcaLabel.rightAnchor, constant: 5).isActive = true
        articleTitleLabel.rightAnchor.constraint(equalTo: self.crossIconView.leftAnchor, constant: -30).isActive = true
        articleTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
        
    }
    func showChasisNumberLabel(){
        self.addSubview(chasisNumberLabel)
        chasisNumberLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 5).isActive = true
        //chasisNumberLabel.leftAnchor.constraint(equalTo: marcaLabel.rightAnchor, constant: 5).isActive = true
        chasisNumberLabel.rightAnchor.constraint(equalTo: self.crossIconView.leftAnchor, constant: -30).isActive = true
        chasisNumberLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
    }
    func showValorTitleLabel(){
        self.addSubview(valorTitleLabel)
        valorTitleLabel.centerYAnchor.constraint(equalTo: articleTitleLabel.centerYAnchor).isActive = true
        valorTitleLabel.rightAnchor.constraint(equalTo: crossIconView.rightAnchor, constant: -5).isActive = true
        valorTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.20).isActive = true
    }
    func showValorLabel(){
        self.addSubview(valorLable)
        valorLable.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 10).isActive = true
        valorLable.rightAnchor.constraint(equalTo: crossIconView.rightAnchor, constant: -5).isActive = true
        valorLable.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.20).isActive = true
    }
    func showCrossIconLabel(){
        self.addSubview(crossIconView)
        crossIconView.centerYAnchor.constraint(equalTo: redNumberLabel.centerYAnchor).isActive = true
        crossIconView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        crossIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        crossIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

