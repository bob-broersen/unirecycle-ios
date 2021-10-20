//
//  LeaderboardViewController.swift
//  unirecycle
//
//  Created by Emre Efe on 17/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardViewController: UIViewController {
    struct Cells{
        static let personCell = "PersonCell"
    }
    
    var weekLeaderboard: [LeaderboardPerson] = []
    var monthLeaderboard: [LeaderboardPerson] = []
    var persons: [LeaderboardPerson] = []
    
    var firstPlace: LeaderboardPerson!
    var secondPlace: LeaderboardPerson!
    var thirdPlace: LeaderboardPerson!
    
    private lazy var customSegmentControl: CustomSegmentControl = {
        let sc = CustomSegmentControl()
        sc.updateSegmentControlWithItems(["WEEK", "MONTH"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.segmentControl.addTarget(self, action: #selector(changeView(_:)), for: .valueChanged)
        sc.segmentControl.selectedSegmentIndex = 0
        sc.setupLayout()
        return sc
    }()
    
    private let personStackView: UIView = {
        let personStackView = UIView()
        personStackView.translatesAutoresizingMaskIntoConstraints = false
        personStackView.layer.backgroundColor = UIColor.white.cgColor
        return personStackView
    }()
    
    private let seperator: UIView = {
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        
        seperator.layer.borderWidth = 1.0
        seperator.layer.borderColor = Colors.lightGray.cgColor
        
        return seperator
    }()
    
    private let firstPlaceCrown: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "crown")
        return image
    }()
    private let firstPlaceCircle: Circle = {
        let circle = Circle()
        circle.setAttributes(rect: CGRect(x: 0, y: 0, width: 100, height: 100), color: Colors.firstPlaceColor)
        return circle
    }()
    private let firstPlaceImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let firstPlaceText: CircleText = {
        let firstPlaceText = CircleText()
        return firstPlaceText
    }()
    
    private let secondPlaceRank: UILabel = {
        let rank = UILabel()
        rank.font = UIFont(name: "Roboto-Regular", size: 16)
        rank.text = "2."
        rank.translatesAutoresizingMaskIntoConstraints = false
        return rank
    }()
    private let secondPlaceCircle: Circle = {
        let circle = Circle()
        circle.setAttributes(rect: CGRect(x: 0, y: 0, width: 72, height: 72), color: Colors.secondPlaceColor)
        return circle
    }()
    private let secondPlaceImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let secondPlaceText: CircleText = {
        let firstPlaceText = CircleText()
        return firstPlaceText
    }()
    
    private let thirdPlaceRank: UILabel = {
        let rank = UILabel()
        rank.font = UIFont(name: "Roboto-Regular", size: 16)
        rank.text = "3."
        rank.translatesAutoresizingMaskIntoConstraints = false
        return rank
    }()
    private let thirdPlaceImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let thirdPlaceCircle: Circle = {
        let circle = Circle()
        circle.setAttributes(rect: CGRect(x: 0, y: 0, width: 72, height: 72), color: Colors.thirdPlaceColor)
        
        return circle
    }()
    private let thirdPlaceText: CircleText = {
        let firstPlaceText = CircleText()
        return firstPlaceText
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Leaderboard"
        self.weekLeaderboard = leaderboardViewModel!.weekLeaderboard
        self.monthLeaderboard = leaderboardViewModel!.monthLeaderboard
        self.persons = weekLeaderboard
        tableView.reloadData()
        setUpViews()
        setRanks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.weekLeaderboard = leaderboardViewModel!.weekLeaderboard
        self.monthLeaderboard = leaderboardViewModel!.monthLeaderboard
        self.persons = weekLeaderboard
        tableView.reloadData()
        setRanks()
    }

    
    func setUpViews(){
        view.addSubview(customSegmentControl)
        view.addSubview(personStackView)
        view.addSubview(seperator)
        
        personStackView.addSubview(secondPlaceCircle)
        personStackView.addSubview(firstPlaceCircle)
        personStackView.addSubview(thirdPlaceCircle)
        
        personStackView.addSubview(firstPlaceCrown)
        personStackView.addSubview(secondPlaceRank)
        personStackView.addSubview(thirdPlaceRank)
        
        personStackView.addSubview(firstPlaceText)
        personStackView.addSubview(secondPlaceText)
        personStackView.addSubview(thirdPlaceText)
        
        firstPlaceCircle.addSubview(firstPlaceImage)
        secondPlaceCircle.addSubview(secondPlaceImage)
        thirdPlaceCircle.addSubview(thirdPlaceImage)
        
        setupLayout()
        configureTableView()
    }
    
    func setupLayout(){
        firstPlaceText.setFirstPlaceFont(size: 24, difference: 4)
        secondPlaceText.setFont(size: 22, difference: 2)
        thirdPlaceText.setFont(size: 20, difference: 0)
        
        NSLayoutConstraint.activate([
            customSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            customSegmentControl.heightAnchor.constraint(equalToConstant: 50),
            customSegmentControl.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            personStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personStackView.topAnchor.constraint(equalTo: customSegmentControl.bottomAnchor),
            personStackView.heightAnchor.constraint(equalToConstant: 130),
            personStackView.widthAnchor.constraint(equalToConstant: view.frame.width),

            secondPlaceCircle.centerYAnchor.constraint(equalTo: personStackView.centerYAnchor),
            secondPlaceCircle.heightAnchor.constraint(equalToConstant: secondPlaceCircle.frame.height),
            secondPlaceCircle.widthAnchor.constraint(equalToConstant: secondPlaceCircle.frame.width),
            secondPlaceCircle.leftAnchor.constraint(equalTo: personStackView.leftAnchor, constant: 30),

            firstPlaceCircle.centerYAnchor.constraint(equalTo: personStackView.centerYAnchor),
            firstPlaceCircle.centerXAnchor.constraint(equalTo: personStackView.centerXAnchor),
            firstPlaceCircle.heightAnchor.constraint(equalToConstant: firstPlaceCircle.frame.height),
            firstPlaceCircle.widthAnchor.constraint(equalToConstant: firstPlaceCircle.frame.width),

            thirdPlaceCircle.centerYAnchor.constraint(equalTo: personStackView.centerYAnchor),
            thirdPlaceCircle.heightAnchor.constraint(equalToConstant: thirdPlaceCircle.frame.height),
            thirdPlaceCircle.widthAnchor.constraint(equalToConstant: thirdPlaceCircle.frame.width),
            thirdPlaceCircle.rightAnchor.constraint(equalTo: personStackView.rightAnchor, constant: -30),
            
            seperator.topAnchor.constraint(equalTo: firstPlaceText.bottomAnchor, constant: 10),
            seperator.centerXAnchor.constraint(equalTo: personStackView.centerXAnchor),
            seperator.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
            seperator.heightAnchor.constraint(equalToConstant: 1),
            
            firstPlaceCrown.bottomAnchor.constraint(equalTo: firstPlaceCircle.topAnchor, constant: 11),
            firstPlaceCrown.centerXAnchor.constraint(equalTo: firstPlaceCircle.centerXAnchor),
            
            firstPlaceImage.heightAnchor.constraint(equalToConstant: firstPlaceCircle.frame.height),
            firstPlaceImage.widthAnchor.constraint(equalToConstant: firstPlaceCircle.frame.width),
            
            firstPlaceText.topAnchor.constraint(equalTo: firstPlaceCircle.bottomAnchor, constant: 5),
            firstPlaceText.centerXAnchor.constraint(equalTo: firstPlaceCircle.centerXAnchor),
            
            secondPlaceRank.bottomAnchor.constraint(equalTo: secondPlaceCircle.topAnchor),
            secondPlaceRank.centerXAnchor.constraint(equalTo: secondPlaceCircle.centerXAnchor),
            
            secondPlaceImage.heightAnchor.constraint(equalToConstant: secondPlaceCircle.frame.height),
            secondPlaceImage.widthAnchor.constraint(equalToConstant: secondPlaceCircle.frame.width),
            
            secondPlaceText.topAnchor.constraint(equalTo: secondPlaceCircle.bottomAnchor, constant: 5),
            secondPlaceText.centerXAnchor.constraint(equalTo: secondPlaceCircle.centerXAnchor),
            
            thirdPlaceRank.bottomAnchor.constraint(equalTo: thirdPlaceCircle.topAnchor),
            thirdPlaceRank.centerXAnchor.constraint(equalTo: thirdPlaceCircle.centerXAnchor),
            
            thirdPlaceImage.heightAnchor.constraint(equalToConstant: thirdPlaceCircle.frame.height),
            thirdPlaceImage.widthAnchor.constraint(equalToConstant: thirdPlaceCircle.frame.width),
            
            thirdPlaceText.topAnchor.constraint(equalTo: thirdPlaceCircle.bottomAnchor, constant: 5),
            thirdPlaceText.centerXAnchor.constraint(equalTo: thirdPlaceCircle.centerXAnchor),
            
            
         ])
    }
    
    func fetchWeekData(){
        persons = weekLeaderboard
    }

    func fetchMonthData(){
        persons = monthLeaderboard
    }
    
    @objc func changeView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            fetchWeekData()
            setRanks()
            tableView.reloadData()
            break
        case 1:
            fetchMonthData()
            setRanks()
            tableView.reloadData()
            break
        // show week
        default:
            fetchWeekData()
            setRanks()
            tableView.reloadData()
        }
    }
    
    
    var tableView = UITableView()
    
    func configureTableView(){
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.separatorStyle = .none
        
        tableView.register(PersonCell.self, forCellReuseIdentifier: Cells.personCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pinToTop(to: view, currentView: tableView, top: seperator)
        
       
    }
    
    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setRanks(){
        let firstPlace = persons.remove(at: 0)
        let secondPlace = persons.remove(at: 0)
        let thirdPlace = persons.remove(at: 0)

        firstPlaceImage.image = firstPlace.image
        secondPlaceImage.image = secondPlace.image
        thirdPlaceImage.image = thirdPlace.image

        firstPlaceText.setAttributes(name: firstPlace.title, amount: firstPlace.coins.description)
        secondPlaceText.setAttributes(name: secondPlace.title, amount: secondPlace.coins.description)
        thirdPlaceText.setAttributes(name: thirdPlace.title, amount: thirdPlace.coins.description)
    }
    
}

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.personCell) as! PersonCell
        let person = persons[indexPath.row]
        cell.set(person: person)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
