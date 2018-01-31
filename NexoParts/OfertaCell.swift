//
//  OfertaCell.swift
//  NexoParts
//
//  Created by Creativeitem on 7/9/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
class OfertaCell : UITableViewCell{
    
    let idCardIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let adminNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let priceLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    var idCard: UIImage? = nil {
        didSet {
            idCardIconView.image = idCard
        }
    }
    
    var adminName: String? = ""{
        didSet {
            adminNameLabel.text = adminName
        }
    }
    
    var price: String? = ""{
        didSet {
            priceLable.text = price
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = BG_COLOR
        self.selectionStyle = .default
        setupSubviews()
    }
    
    func setupSubviews(){
        showIdCardIcon()
        showAdminNameLabel()
        showPriceLabel()
    }
    func showIdCardIcon(){
        self.addSubview(idCardIconView)
        idCardIconView.topAnchor.constraint(equalTo: self.topAnchor, constant:20).isActive = true
        idCardIconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        idCardIconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.50).isActive = true
        idCardIconView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.50).isActive = true
    }
    func showAdminNameLabel(){
        self.addSubview(adminNameLabel)
        adminNameLabel.centerYAnchor.constraint(equalTo: idCardIconView.centerYAnchor).isActive = true
        adminNameLabel.leftAnchor.constraint(equalTo: idCardIconView.rightAnchor, constant: 10).isActive = true
        adminNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func showPriceLabel(){
        self.addSubview(priceLable)
        priceLable.centerYAnchor.constraint(equalTo: idCardIconView.centerYAnchor).isActive = true
        priceLable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        priceLable.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }
    func handleOfferDetails(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

