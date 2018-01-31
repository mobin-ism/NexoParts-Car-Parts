//
//  ArticleWiseOfferCell.swift
//  NexoParts
//
//  Created by Creativeitem on 12/14/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
class ArticleWiseOfferCell: UITableViewCell {
    
    let carIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "clipboard")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let articleLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    let cantidadTitleLable: UILabel = {
        let label = UILabel()
        label.text = "Cantidad de Ofertas"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    let cantidadLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Precio:"
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont(name: BOLD_TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont(name: BOLD_TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    var article: String? = ""{
        didSet {
            articleLable.text = article
        }
    }
    var cantidad: String? = ""{
        didSet {
            cantidadLable.text = cantidad
        }
    }
    var price: String? = ""{
        didSet {
            priceLabel.text = price
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = BG_COLOR
        self.selectionStyle = .default
        setupSubviews()
    }
    
    func setupSubviews(){
        showCarIcon()
        showArticleTitle()
        showCantidadTitle()
        showCantidad()
        showPrice()
        showPriceTitle()
    }
    func showCarIcon(){
        self.addSubview(carIconView)
        carIconView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        carIconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant:10).isActive = true
        carIconView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05).isActive = true
        carIconView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.07).isActive = true
    }
    func showArticleTitle(){
        self.addSubview(articleLable)
        articleLable.centerYAnchor.constraint(equalTo: carIconView.centerYAnchor).isActive = true
        articleLable.leftAnchor.constraint(equalTo: carIconView.rightAnchor, constant: 5).isActive = true
        articleLable.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func showCantidadTitle(){
        self.addSubview(cantidadTitleLable)
        cantidadTitleLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cantidadTitleLable.leftAnchor.constraint(equalTo: articleLable.rightAnchor, constant: 10).isActive = true
        cantidadTitleLable.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
    }
    func showCantidad(){
        self.addSubview(cantidadLable)
        cantidadLable.topAnchor.constraint(equalTo: cantidadTitleLable.bottomAnchor, constant: 5).isActive = true
        cantidadLable.centerXAnchor.constraint(equalTo: cantidadTitleLable.centerXAnchor).isActive = true
        cantidadLable.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.11).isActive = true
    }
    func showPrice(){
        self.addSubview(priceLabel)
        priceLabel.centerYAnchor.constraint(equalTo: articleLable.centerYAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
    func showPriceTitle(){
        self.addSubview(priceTitleLabel)
        priceTitleLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor).isActive = true
        priceTitleLabel.leftAnchor.constraint(equalTo: cantidadTitleLable.rightAnchor, constant: 10).isActive = true
        priceTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.11).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
