//
//  CheckProgressViewController.swift
//  unirecycle
//
//  Created by Bob Broersen on 07/06/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class CheckProgressViewController: UIViewController {
    let wasteView: UIView = {
        let view = UIView()
        view.backgroundColor  = Colors.darkPurple
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let wasteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto", size: 20)
        label.text = Strings.Home.amountWaste + String(userViewModel?.getTotalWasteSaved() ?? 0)
        label.textColor = .white
        return label
    }()
    
    let wasteImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: images.delete)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    let co2View: UIView = {
        let view = UIView()
        view.backgroundColor  = Colors.darkPurple
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let co2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto", size: 20)
        label.text = Strings.Home.amountCo2 + String(userViewModel?.getTotalCo2Saved() ?? 0)
        label.textColor = .white
        return label
    }()
    
    let co2Image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: images.co2)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
    }
    
    func setUpViews(){
        setupCo2View()
        setupWasteView()
    }
    
    func setupCo2View(){
        view.addSubview(co2View)
        NSLayoutConstraint.activate([
            co2View.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            co2View.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            co2View.heightAnchor.constraint(equalToConstant: 100),
            co2View.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        ])
        
        co2View.addSubview(co2Image)
        NSLayoutConstraint.activate([
            co2Image.leadingAnchor.constraint(equalTo: co2View.leadingAnchor, constant: 16),
            co2Image.centerYAnchor.constraint(equalTo: co2View.centerYAnchor)
        ])
        
        co2View.addSubview(co2Label)
        NSLayoutConstraint.activate([
            co2Label.leadingAnchor.constraint(equalTo: co2Image.trailingAnchor, constant: 16),
            co2Label.centerYAnchor.constraint(equalTo: co2View.centerYAnchor)
        ])
    }
    
    func setupWasteView(){
        view.addSubview(wasteView)
        NSLayoutConstraint.activate([
            wasteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            wasteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            wasteView.heightAnchor.constraint(equalToConstant: 100),
            wasteView.topAnchor.constraint(equalTo: co2View.bottomAnchor, constant: 16)
        ])
        
        wasteView.addSubview(wasteImage)
        NSLayoutConstraint.activate([
            wasteImage.leadingAnchor.constraint(equalTo: wasteView.leadingAnchor, constant: 16),
            wasteImage.centerYAnchor.constraint(equalTo: wasteView.centerYAnchor)
        ])
        
        wasteView.addSubview(wasteLabel)
        NSLayoutConstraint.activate([
            wasteLabel.leadingAnchor.constraint(equalTo: wasteImage.trailingAnchor, constant: 16),
            wasteLabel.centerYAnchor.constraint(equalTo: wasteView.centerYAnchor)
        ])

    }
}
