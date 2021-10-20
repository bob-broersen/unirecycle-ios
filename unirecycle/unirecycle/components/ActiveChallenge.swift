//
//  LatestChallenge.swift
//  unirecycle
//
//  Created by Bob Broersen on 20/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class ActiveChallenge: UIView {
    var challenge: ActiveChallengeModel?
    
    var nilView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 4.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var nilTitle: UILabel = {
        let label = UILabel()
        label.text = "Start a challenge to see"
        //TODO font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    func setChallenge(challenge: ActiveChallengeModel){
        guard let imageUrl:URL = URL(string: challenge.imageUrl) else {
            return
        }
        
        iconView.load(url: imageUrl)
        
        self.challenge = challenge
        let totalDays = getTotalDays()
        let totaldaysLeft = getDaysLeft()
        
        title.text = challenge.title
        subTitle.text = challenge.subtitle
        coinValue.text = "+" + String(challenge.value * challenge.daysCompleted.count)
         
        daysLeft.text = String(format: "%.0f", totaldaysLeft) + " DAYS REMAINING"

        progressBar.progressTintColor = UIColor(hexString: challenge.category.darkHex)
        progressBar.trackTintColor = UIColor(hexString: challenge.category.lightHex)
        

        let percentageDone: Float = (totalDays - totaldaysLeft) / totalDays
        progressBar.setProgress(percentageDone, animated: false)

        
        iconView.backgroundColor = UIColor(hexString: challenge.category.lightHex)
        
    }
    
    func arrangeViews() {
        if challenge == nil {
            view.isHidden = true
            nilView.isHidden = false
        }
        else{
            view.isHidden = false
            nilView.isHidden = true
        }
    }
    
    func getTotalDays() -> Float{
        let calendar = NSCalendar.current

        let date1 = calendar.startOfDay(for: challenge!.startDate as Date)
        let date2 = calendar.startOfDay(for: challenge!.endDate as Date)

        let components = calendar.dateComponents([.day], from: date1, to: date2)

        return Float(components.day ?? 0)
    }
    
    func getDaysLeft() -> Float{
        let calendar = NSCalendar.current
        
        let thisDay = Date()
        
        let date1 = calendar.startOfDay(for: thisDay)
        let date2 = calendar.startOfDay(for: challenge!.endDate as Date)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
       
        return Float(components.day ?? 0)
    }
    
    private let progressBar: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .bar)
        bar.progressTintColor = Colors.red
        bar.trackTintColor = Colors.pink
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.layer.cornerRadius = 4
        bar.clipsToBounds = true
        bar.layer.sublayers![1].cornerRadius = 4
        bar.subviews[1].clipsToBounds = true
        return bar
    }()

    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 4.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: images.chefImage)
        imageView.backgroundColor = Colors.pink
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Roboto-Bold", size: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        title.numberOfLines = 1
        return title
    }()
    
    let subTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.lineBreakMode = .byWordWrapping
        return title
    }()
    
    let coinView: UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coinImage: UIImageView = {
        let image = UIImage(named: images.coinIcon)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let coinValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        return label
    }()
    
    let daysLeft: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RobotoCondensed-Regular", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        
        setupNilView()
        setupView()

            setupNilTitle()
     
        
            setupIconView()
            setUpTitle()
            setUpSubTitle()
            setUpCoinView()
            setUpProgressBar()
            setUpDaysLeft()
        
    }
    
    func setupNilTitle(){
        nilView.addSubview(nilTitle)
        NSLayoutConstraint.activate([
            nilTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nilTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupView(){
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)

        ])
    }
    
    func setupNilView(){
        addSubview(nilView)
        NSLayoutConstraint.activate([
            nilView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            nilView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            nilView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            nilView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)

        ])
    }
    
    func setupIconView(){
        view.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            iconView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            iconView.widthAnchor.constraint(equalToConstant: 68),
            iconView.heightAnchor.constraint(equalToConstant: 68)
        ])
    }
    
    func setUpTitle() {
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62)
        ])
    }
    
    func setUpSubTitle() {
        view.addSubview(subTitle)
        NSLayoutConstraint.activate([
            subTitle.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),


        ])
    }
    
    func setUpProgressBar() {
        view.addSubview(progressBar)
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressBar.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            progressBar.heightAnchor.constraint(equalToConstant: 8)

        ])
    }
    
    func setUpCoinView() {
        coinView.addSubview(coinValue)
        coinView.addSubview(coinImage)
        
        NSLayoutConstraint.activate([
            coinValue.leadingAnchor.constraint(equalTo: coinView.leadingAnchor, constant: 0),
            coinValue.bottomAnchor.constraint(equalTo: coinView.bottomAnchor, constant: 0),
            coinValue.topAnchor.constraint(equalTo: coinView.topAnchor, constant: 0),
            coinImage.trailingAnchor.constraint(equalTo: coinView.trailingAnchor, constant: 0),
            coinImage.bottomAnchor.constraint(equalTo: coinView.bottomAnchor, constant: 0),
            coinImage.topAnchor.constraint(equalTo: coinView.topAnchor, constant: 0),
            coinImage.leadingAnchor.constraint(equalTo: coinValue.trailingAnchor, constant: 4)
        ])
        
        view.addSubview(coinView)
        NSLayoutConstraint.activate([
            coinView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 3),
            coinView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            coinView.centerYAnchor.constraint(equalTo: title.centerYAnchor),
        ])
    }
    
    func setUpDaysLeft(){
        view.addSubview(daysLeft)
        NSLayoutConstraint.activate([
            daysLeft.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            daysLeft.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8),
            daysLeft.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),

        ])
    }
}
