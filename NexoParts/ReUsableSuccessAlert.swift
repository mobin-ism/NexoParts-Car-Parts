//
//  ReUsableSuccessAlert.swift
//  NexoParts
//
//  Created by Creativeitem on 9/14/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
class ReUsableSuccessAlert: UIViewController {
    let alertBackgroundLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red:0.67, green:0.81, blue:0.24, alpha:1.0).cgColor
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        return label
    }()
    let alertSignImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "tick-sign")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let alertMessage: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
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
        alertSignImageView.heightAnchor.constraint(equalTo: alertBackgroundLabel.heightAnchor, multiplier: 0.60).isActive = true
        alertSignImageView.widthAnchor.constraint(equalTo: alertBackgroundLabel.heightAnchor, multiplier: 0.60).isActive = true
    }
    func showAlertMessage(){
        view.addSubview(alertMessage)
        alertMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertMessage.topAnchor.constraint(equalTo: alertSignImageView.bottomAnchor, constant: 7).isActive = true
        alertMessage.widthAnchor.constraint(equalTo: alertBackgroundLabel.widthAnchor, multiplier: 1).isActive = true
    }
}
