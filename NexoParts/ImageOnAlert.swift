//
//  ImageOnAlert.swift
//  NexoParts
//
//  Created by Creativeitem on 12/17/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
class ArticleImageOnAlert: UIViewController {
    let alertBackgroundLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        return label
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let noImageLabel: UILabel = {
        let label = UILabel()
        label.text = "No Image Selected"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 15)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    override func viewDidLoad() {
        view?.backgroundColor = UIColor(white: 1, alpha: 0)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCloseButton))
        view.addGestureRecognizer(tapGesture)
        setupUI()
    }
    
    func setupUI(){
        setupAlertBackgroundLabel()
        
        if self.imageView.image == nil{
            showNoImageLabel()
        }
        else{
            showImageView()
        }
    }
    func setupAlertBackgroundLabel(){
        view.addSubview(alertBackgroundLabel)
        alertBackgroundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertBackgroundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertBackgroundLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        alertBackgroundLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
    }
    func showImageView(){
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: alertBackgroundLabel.topAnchor, constant: 25).isActive = true
        imageView.heightAnchor.constraint(equalTo: alertBackgroundLabel.heightAnchor, multiplier: 0.80).isActive = true
        imageView.widthAnchor.constraint(equalTo: alertBackgroundLabel.heightAnchor, multiplier: 0.80).isActive = true
    }
    func showNoImageLabel(){
        view.addSubview(noImageLabel)
        noImageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noImageLabel.topAnchor.constraint(equalTo: alertBackgroundLabel.topAnchor, constant: 25).isActive = true
        noImageLabel.heightAnchor.constraint(equalTo: alertBackgroundLabel.heightAnchor, multiplier: 0.80).isActive = true
        noImageLabel.widthAnchor.constraint(equalTo: alertBackgroundLabel.heightAnchor, multiplier: 0.80).isActive = true
    }
    func handleCloseButton(){
        self.dismiss(animated: true, completion: nil)
    }
}

class OfferImageOnAlert: UIViewController {
    let alertBackgroundLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1).cgColor
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        return label
    }()
    let imageViewOne: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:0.5).cgColor
        return imageView
    }()
    let imageViewTwo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:0.5).cgColor
        return imageView
    }()
    let noImageLabelForImageViewOne: UILabel = {
        let label = UILabel()
        label.text = "No Image Selected"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 15)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.alpha = 0
        return label
    }()
    let noImageLabelForImageViewTwo: UILabel = {
        let label = UILabel()
        label.text = "No Image Selected"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: TEXT_FONT, size: 15)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.alpha = 0
        return label
    }()
    override func viewDidLoad() {
        view?.backgroundColor = UIColor(white: 1, alpha: 0)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCloseButton))
        view.addGestureRecognizer(tapGesture)
        setupUI()
    }
    
    func setupUI(){
        setupAlertBackgroundLabel()
        
        if self.imageViewOne.image == nil{
            noImageLabelForImageViewOne.alpha = 1
        }
        if self.imageViewTwo.image == nil{
            noImageLabelForImageViewTwo.alpha = 1
        }
        showImageViews()
    }
    func setupAlertBackgroundLabel(){
        view.addSubview(alertBackgroundLabel)
        alertBackgroundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertBackgroundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertBackgroundLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.80).isActive = true
        alertBackgroundLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
    }
    func showImageViews(){
        showImageViewOne()
        showImageViewTwo()
        showNoImageLabelForImageViewOne()
        showNoImageLabelForImageViewTwo()
    }
    func showImageViewOne(){
        view.addSubview(imageViewOne)
        imageViewOne.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageViewOne.topAnchor.constraint(equalTo: alertBackgroundLabel.topAnchor, constant: 30).isActive = true
        imageViewOne.heightAnchor.constraint(equalTo: alertBackgroundLabel.heightAnchor, multiplier: 0.40).isActive = true
        imageViewOne.widthAnchor.constraint(equalTo: alertBackgroundLabel.widthAnchor, multiplier: 0.90).isActive = true
    }
    func showImageViewTwo(){
        view.addSubview(imageViewTwo)
        imageViewTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageViewTwo.bottomAnchor.constraint(equalTo: alertBackgroundLabel.bottomAnchor, constant: -30).isActive = true
        imageViewTwo.heightAnchor.constraint(equalTo: alertBackgroundLabel.heightAnchor, multiplier: 0.40).isActive = true
        imageViewTwo.widthAnchor.constraint(equalTo: alertBackgroundLabel.widthAnchor, multiplier: 0.90).isActive = true
    }
    func showNoImageLabelForImageViewOne(){
        imageViewOne.addSubview(noImageLabelForImageViewOne)
        noImageLabelForImageViewOne.centerXAnchor.constraint(equalTo: imageViewOne.centerXAnchor).isActive = true
        noImageLabelForImageViewOne.centerYAnchor.constraint(equalTo: imageViewOne.centerYAnchor).isActive = true
    }
    func showNoImageLabelForImageViewTwo(){
        imageViewTwo.addSubview(noImageLabelForImageViewTwo)
        noImageLabelForImageViewTwo.centerXAnchor.constraint(equalTo: imageViewTwo.centerXAnchor).isActive = true
        noImageLabelForImageViewTwo.centerYAnchor.constraint(equalTo: imageViewTwo.centerYAnchor).isActive = true
    }
    func handleCloseButton(){
        self.dismiss(animated: true, completion: nil)
    }
}
