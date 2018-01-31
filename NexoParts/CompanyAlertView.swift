//
//  CompanyAlertView.swift
//  NexoParts
//
//  Created by Creativeitem on 8/29/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
class CompanyAlertView: UIViewController {
    
    let alertBackgroundLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red:1.00, green:0.65, blue:0.15, alpha:1.0).cgColor
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        return label
    }()
    let alertSignImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "bell")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var alertMessage: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        label.textColor = UIColor.white
        label.font = UIFont(name: TEXT_FONT, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        view?.backgroundColor = UIColor(white: 1, alpha: 0)
        
        setupUI()
    }
    func setupUI(){
        setupAlertBackgroundLabel()
        showAlertSign()
        showAlertMessage()
    }
    func setupAlertBackgroundLabel(){
        view.addSubview(alertBackgroundLabel)
        alertBackgroundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertBackgroundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertBackgroundLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30).isActive = true
        alertBackgroundLabel.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30).isActive = true
    }
    func showAlertSign(){
        view.addSubview(alertSignImageView)
        alertSignImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertSignImageView.topAnchor.constraint(equalTo: alertBackgroundLabel.topAnchor, constant: 25).isActive = true
        alertSignImageView.heightAnchor.constraint(equalTo: alertBackgroundLabel.heightAnchor, multiplier: 0.30).isActive = true
        alertSignImageView.widthAnchor.constraint(equalTo: alertBackgroundLabel.heightAnchor, multiplier: 0.30).isActive = true
    }
    func showAlertMessage(){
        view.addSubview(alertMessage)
        alertMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //alertMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertMessage.topAnchor.constraint(equalTo: alertSignImageView.bottomAnchor, constant: 7).isActive = true
        alertMessage.widthAnchor.constraint(equalTo: alertBackgroundLabel.widthAnchor, multiplier: 0.8).isActive = true
    }
    
}

