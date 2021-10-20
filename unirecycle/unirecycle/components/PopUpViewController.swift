//
//  PopUpViewController.swift
//  unirecycle
//
//  Created by Bob Broersen on 19/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    func setValues(popupTitle: String, popupText: String){
        self.popUpText.text  = popupText
        self.popUpTitle.text  = popupTitle
    }
    
    let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let popUpTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Roboto", size: 24)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        title.numberOfLines = 1
        return title
    }()
    
    let popUpText: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Roboto", size: 16)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        title.numberOfLines = 0
        return title
    }()
    
    let closeImage: UIImageView = {
        let image = UIImage(named: images.closeIcon)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    @objc func dismiss(tapGestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss(tapGestureRecognizer:)))
        closeImage.isUserInteractionEnabled = true
        closeImage.addGestureRecognizer(tapGestureRecognizer)
        
        setupViews()
    }
    
    func setupViews(){
        setupView()
        setupTitle()
        setupText()
        setupImage()
    }
    
    func setupView(){
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
    }
    
    func setupTitle(){
        contentView.addSubview(popUpTitle)
        NSLayoutConstraint.activate([
            popUpTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            popUpTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 55),
        ])
    }
    
    func setupText(){
        contentView.addSubview(popUpText)
        NSLayoutConstraint.activate([
            popUpText.topAnchor.constraint(equalTo: popUpTitle.bottomAnchor, constant: 17),
            popUpText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            popUpText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            popUpText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),

        ])
    }
    
    func setupImage(){
        contentView.addSubview(closeImage)
        NSLayoutConstraint.activate([
            closeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            closeImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
        ])
    }

    
    

}
