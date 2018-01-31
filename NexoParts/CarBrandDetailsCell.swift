//
//  CarBrandDetailsCell.swift
//  NexoParts
//
//  Created by Creativeitem on 7/4/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
class CarBrandDetailsCell : UITableViewCell{
    
    let carModelImageView: UIImageView = {
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
    let carTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let calenderIconView: UIImageView = {
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
    let keyIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let versionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.cornerRadius = 5
        label.layer.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1.0).cgColor
        label.textAlignment = .center
        return label
    }()
    let greenArrowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red:0.11, green:0.37, blue:0.13, alpha:1.0)
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var carImage: UIImage? = nil {
        didSet {
            carModelImageView.image = carImage
        }
    }
    var carIcon: UIImage? = nil {
        didSet {
            carIconView.image = carIcon
        }
    }
    var carTitle: String? = ""{
        didSet {
            carTitleLabel.text = carTitle
        }
    }
    var calenderIcon: UIImage? = nil {
        didSet {
            calenderIconView.image = calenderIcon
        }
    }
    var year: String? = ""{
        didSet {
            yearLabel.text = year
        }
    }
    var keyIcon: UIImage? = nil {
        didSet {
            keyIconView.image = keyIcon
        }
    }
    var version: String? = ""{
        didSet {
            versionLabel.text = version
        }
    }
    var status: String? = ""{
        didSet {
            statusLabel.text = status
        }
    }
    var greenArrow: String? = ""{
        didSet {
            greenArrowLabel.text = greenArrow
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = BG_COLOR
        self.selectionStyle = .default
        setupSubviews()
    }
    
    func setupSubviews(){
        showCarModelImageView()
        showCarIcon()
        showCarLabel()
        showCalenderIcon()
        showYearLabel()
        showKeyIcon()
        showVersionLabel()
        showStatusLabel()
        showGreenIconLabel()
    }
    
    func showCarModelImageView(){
        self.addSubview(carModelImageView)
        carModelImageView.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        carModelImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        carModelImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        carModelImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75).isActive = true
    }
    func showCarIcon(){
        self.addSubview(carIconView)
        carIconView.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        carIconView.leftAnchor.constraint(equalTo: carModelImageView.rightAnchor, constant: 5).isActive = true
        carIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        carIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func showCarLabel(){
        self.addSubview(carTitleLabel)
        carTitleLabel.centerYAnchor.constraint(equalTo: carIconView.centerYAnchor).isActive = true
        carTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        carTitleLabel.leftAnchor.constraint(equalTo: carIconView.rightAnchor, constant: 5).isActive = true
        carTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func showCalenderIcon(){
        self.addSubview(calenderIconView)
        calenderIconView.topAnchor.constraint(equalTo: carIconView.bottomAnchor, constant:10).isActive = true
        calenderIconView.leftAnchor.constraint(equalTo: carModelImageView.rightAnchor, constant: 5).isActive = true
        calenderIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        calenderIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        
    }
    func showYearLabel(){
        self.addSubview(yearLabel)
        yearLabel.centerYAnchor.constraint(equalTo: calenderIconView.centerYAnchor).isActive = true
        yearLabel.topAnchor.constraint(equalTo: carTitleLabel.bottomAnchor, constant:5).isActive = true
        yearLabel.leftAnchor.constraint(equalTo: calenderIconView.rightAnchor, constant: 5).isActive = true
        yearLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func showKeyIcon(){
        self.addSubview(keyIconView)
        keyIconView.topAnchor.constraint(equalTo: calenderIconView.bottomAnchor, constant:10).isActive = true
        keyIconView.leftAnchor.constraint(equalTo: carModelImageView.rightAnchor, constant: 5).isActive = true
        keyIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        keyIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func showVersionLabel(){
        self.addSubview(versionLabel)
        versionLabel.centerYAnchor.constraint(equalTo: keyIconView.centerYAnchor).isActive = true
        versionLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant:5).isActive = true
        versionLabel.leftAnchor.constraint(equalTo: keyIconView.rightAnchor, constant: 5).isActive = true
        versionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func showStatusLabel(){
        self.addSubview(statusLabel)
        statusLabel.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor).isActive = true
        statusLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        statusLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
        
    }
    func showGreenIconLabel(){
        self.addSubview(greenArrowLabel)
        greenArrowLabel.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor).isActive = true
        greenArrowLabel.leftAnchor.constraint(equalTo: statusLabel.rightAnchor, constant: 0).isActive = true
        greenArrowLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        greenArrowLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
