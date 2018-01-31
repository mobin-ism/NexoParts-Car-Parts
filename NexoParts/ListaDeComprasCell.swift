//
//  ListaDeComprasCell.swift
//  NexoParts
//
//  Created by Creativeitem on 8/1/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit

class ListaDeComprasCell: UITableViewCell {
    
    let clipboardIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let numberLabel: UILabel = {
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
    let userNameLabel: UILabel = {
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
    let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let totalBillLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: BOLD_TEXT_FONT, size: 12)
        label.textAlignment = .center
        label.textColor = UIColor(red:0.55, green:0.76, blue:0.29, alpha:1.0)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var greenButton: UIButton = {
        let greenIconButton = UIButton(type: .system)
        greenIconButton.setTitle("▶︎", for: .normal)
        greenIconButton.setTitleColor(GREEN_ICON_COLOR, for: .normal)
        greenIconButton.translatesAutoresizingMaskIntoConstraints = false
        greenIconButton.addTarget(self, action: #selector(handleGreenIcon), for: .touchUpInside)
        greenIconButton.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        greenIconButton.layer.shadowRadius = 2
        greenIconButton.layer.shadowOpacity = 0.8
        greenIconButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        return greenIconButton
    }()
    
    var clipboardIcon: UIImage? = nil {
        didSet {
            clipboardIconView.image = clipboardIcon
        }
    }
    var number: String? = ""{
        didSet {
            numberLabel.text = number
        }
    }
    var idCardIcon: UIImage? = nil {
        didSet {
            idCardIconView.image = idCardIcon
        }
    }
    var userName: String? = ""{
        didSet {
            userNameLabel.text = userName
        }
    }
    var calendarIcon: UIImage? = nil {
        didSet {
            calendarIconView.image = calendarIcon
        }
    }
    var date: String? = ""{
        didSet {
            dateLabel.text = date
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
    var totalTitle: String? = ""{
        didSet {
            totalTitleLabel.text = totalTitle
        }
    }
    var totalBill: String? = ""{
        didSet {
            totalBillLabel.text = totalBill
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = BG_COLOR
        self.selectionStyle = .default
        setupSubviews()
    }
    
    func setupSubviews() {
        showClipboardIcon()
        showNumberLabel()
        showIdCardIcon()
        showUsernameLabel()
        showCalendarIcon()
        showDateLabel()
        showArticleTitle()
        showStatusLabel()
        showTotalBillTitle()
        showTotalBill()
        showGreenIconButton()
    }
    func showClipboardIcon(){
        self.addSubview(clipboardIconView)
        clipboardIconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        clipboardIconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        clipboardIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        clipboardIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func showNumberLabel(){
        self.addSubview(numberLabel)
        numberLabel.centerYAnchor.constraint(equalTo: clipboardIconView.centerYAnchor).isActive = true
        numberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        numberLabel.leftAnchor.constraint(equalTo: clipboardIconView.rightAnchor, constant: 5).isActive = true
        numberLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30).isActive = true
    }
    func showIdCardIcon(){
        self.addSubview(idCardIconView)
        idCardIconView.topAnchor.constraint(equalTo: clipboardIconView.bottomAnchor, constant: 10).isActive = true
        idCardIconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        idCardIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        idCardIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func showUsernameLabel(){
        self.addSubview(userNameLabel)
        userNameLabel.centerYAnchor.constraint(equalTo: idCardIconView.centerYAnchor).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: numberLabel.topAnchor, constant:10).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: idCardIconView.rightAnchor, constant: 5).isActive = true
        userNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30).isActive = true
        
    }
    func showCalendarIcon(){
        self.addSubview(calendarIconView)
        calendarIconView.topAnchor.constraint(equalTo: idCardIconView.bottomAnchor, constant: 10).isActive = true
        calendarIconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        calendarIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        calendarIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    func showDateLabel(){
        self.addSubview(dateLabel)
        dateLabel.centerYAnchor.constraint(equalTo: calendarIconView.centerYAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor, constant:10).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: calendarIconView.rightAnchor, constant: 5).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30).isActive = true
    }
    func showArticleTitle(){
        self.addSubview(articleTitleLabel)
        articleTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        articleTitleLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 5).isActive = true
        articleTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30).isActive = true
    }
    func showStatusLabel(){
        self.addSubview(statusLabel)
        statusLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 10).isActive = true
        statusLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 5).isActive = true
        statusLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30).isActive = true
    }
    func showTotalBillTitle(){
        self.addSubview(totalTitleLabel)
        totalTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        totalTitleLabel.leftAnchor.constraint(equalTo: articleTitleLabel.rightAnchor, constant: 5).isActive = true
        totalTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    func showTotalBill(){
        self.addSubview(totalBillLabel)
        totalBillLabel.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor).isActive = true
        totalBillLabel.topAnchor.constraint(equalTo: totalTitleLabel.topAnchor, constant: 10).isActive = true
        totalBillLabel.leftAnchor.constraint(equalTo: articleTitleLabel.rightAnchor, constant: 5).isActive = true
        totalBillLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    func showGreenIconButton(){
        self.addSubview(greenButton)
        greenButton.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor).isActive = true
        greenButton.leftAnchor.constraint(equalTo: totalBillLabel.rightAnchor).isActive = true
        greenButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        greenButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05).isActive = true
        
    }
    func handleGreenIcon(){
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

