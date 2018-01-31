//
//  ImageLabelView.swift
//  NexoParts
//
//  Created by Creativeitem on 5/29/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit

class ImageLabelView: UIView {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var title: String? = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var titleColor: UIColor? = .black {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    var image: UIImage? = nil {
        didSet {
            iconImageView.image = image
        }
    }
    
    var bgColor: UIColor? = BG_COLOR {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
    }
    
    func setupSubviews() {
        self.addSubview(iconImageView)
        iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        
        self.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

