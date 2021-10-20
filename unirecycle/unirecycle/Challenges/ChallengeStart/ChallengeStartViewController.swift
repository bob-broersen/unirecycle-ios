//
//  ChallengeStartViewController.swift
//  unirecycle
//
//  Created by Ryno on 10/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit //framework
import Firebase //framework
import FirebaseStorage // framework

class ChallengeStartViewController: UIViewController {
    
    private lazy var viewModel = CategoryViewModel()
    
    var challenge: Challenge? {
        didSet {
            collectionView.reloadData()
            tableView.reloadData()
        }
    }

    var parentSegment: UIViewController?
    var userVM = ProfileViewModel()
    var user = UserViewModel()
    var active = ActiveViewController()
    var challDict: [String: Any] = [:]
    var activeUser = Account()
    var waste = 0
    var co2 = 0
    var value = 0
    var mondayButtonChange = Bool()
    var tuesdayButtonChange = Bool()
    var wednesdayButtonChange = Bool()
    var thursdayButtonChange = Bool()
    var fridayButtonChange = Bool()
    var saturdayButtonChange = Bool()
    var sundayButtonChange = Bool()

    var difficultyInDays = 0 {
        didSet {
            changeDifficultyLabel()
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 4
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        tableView.layer.shadowOpacity = 0.2
        tableView.layer.shadowRadius = 4.0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: view.frame.size.width/2.2, height: view.frame.size.width/4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ChallengeStartCollectionViewCell.self, forCellWithReuseIdentifier: ChallengeStartCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let tipsView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.green
        view.layer.cornerRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 4.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tipsIconLeaf: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Strings.Challenge.leaffill)
        imageView.tintColor = Colors.greenLeaf
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tipsIconRight: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Strings.Challenge.chevronright)
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tipsTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Roboto-Regular", size: 15)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        title.numberOfLines = 1
        title.text = Strings.Challenge.tipsTitle
        title.textAlignment = .center
        return title
    }()
    
    private let tipsSubTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont(name: "Roboto-Regular", size: 12)
        title.text = Strings.Challenge.subTitle
        title.textColor = .gray
        title.textAlignment = .center
        return title
    }()
    
    private  let frequancyLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Challenge.frequancyHeadTitle
        label.font = UIFont(name: "Roboto", size: 20)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    private let frequencyView: UIView = {
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
    
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Challenge.difficultyBeginnener
        label.font = UIFont(name: "Roboto", size: 14)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    private let difficultFrequencyTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont(name: "Roboto-Regular", size: 12)
        title.text = Strings.Challenge.difficultyBeginnener
        title.textColor = .black
        title.textAlignment = .center
        return title
    }()
    
    private let mondayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        button.setTitle(Strings.Challenge.mondayButton, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTappedMondayButton), for: .touchUpInside)
        return button
    }()
    
    private let tuesdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        button.setTitle(Strings.Challenge.tuesdayButton, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTappedTuesdayButton), for: .touchUpInside)
        return button
    }()
    
    private let wednesdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        button.setTitle(Strings.Challenge.wednesdayButton, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTappedWednesdayButton), for: .touchUpInside)
        return button
    }()
    
    private let thursdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        button.setTitle(Strings.Challenge.thursdayButton, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTappedThursdayButton), for: .touchUpInside)
        return button
    }()
    
    private let fridayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        button.setTitle(Strings.Challenge.firdayButton, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTappedFridayButton), for: .touchUpInside)
        return button
    }()
    
    private let saturdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        button.setTitle(Strings.Challenge.saturdayButton, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTappedSaturdayButton), for: .touchUpInside)
        return button
    }()
    
    private let sundayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        button.setTitle(Strings.Challenge.sundayButton, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTappedSundayButton), for: .touchUpInside)
        return button
    }()
    
    private let letsDoTtButton: Button = {
        let button = Button()
        button.setTitle(Strings.Challenge.letsdoitButtonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(letsDoitPopUp), for: .touchUpInside)
        return button
    }()
    
//    var mondayButtonChange = Bool()
//    var tuesdayButtonChange = Bool()
//    var wednesdayButtonChange = Bool()
//    var thursdayButtonChange = Bool()
//    var fridayButtonChange = Bool()
//    var saturdayButtonChange = Bool()
//    var sundayButtonChange = Bool()
//
//    var difficultyInDays = 0 {
//        didSet {
//            changeDifficultyLabel()
//        }
//    }
    
    func setChallenge(challenge: Challenge) {
        print("challenge id 2 = " + challenge.id)
        self.challenge = challenge
        tableView.reloadData()

    }
    
     func changeDifficultyLabel(){
        let THREE_DAYS: Int = 3
        let WASTE_VALUES: Int = 20
        let CO2_VALUES: Int = 30
        let SP_VALUES: Int = 9

        
        if (difficultyInDays < THREE_DAYS) {
            challenge?.waste = waste
            challenge?.co2 = co2
            challenge?.value = value
        }else {
            challenge?.waste = (difficultyInDays * WASTE_VALUES)
            challenge?.co2 = (difficultyInDays * CO2_VALUES)
            challenge?.value = (difficultyInDays * SP_VALUES)
            collectionView.reloadData()
        }
        
        switch difficultyInDays {
        case 0...2:
            difficultyLabel.text = Strings.Challenge.difficultyBeginnener
        case 3:
            difficultyLabel.text = Strings.Challenge.difficultyIntermediate
        case 4:
            difficultyLabel.text = Strings.Challenge.difficultyAdvanced
        case 5...7:
            difficultyLabel.text = Strings.Challenge.difficultyExpert
        default:
            difficultyLabel.text = Strings.Challenge.difficultyBeginnener
        }
        collectionView.reloadData()
    }
       
    @objc func checkIfChallengesIsTwo() {
        let TWO_ACTIVE_CHALLENGES: Int = 2
        
        if(userViewModel?.user.activeChallenges?.count == TWO_ACTIVE_CHALLENGES){
            
        let alertController = UIAlertController(title: Strings.Challenge.pop_upTitleAlready2Days, message: Strings.Challenge.pop_upMessageAlready2Days, preferredStyle: .alert)
        
            present(alertController, animated: true) {

                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                alertController.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
            }

        }else{
            userViewModel?.updateActiveChallenge(challengeId: self.challenge!.id)
        }
        self.navigateToActiveChallengeAction()

    }
    
    @objc func tips_Pop_Up(_ sender: UITapGestureRecognizer) {
        
        let alertController = UIAlertController(title: Strings.Challenge.tipsTitle, message: Strings.Challenge.tipsMessage, preferredStyle: .alert)
        
        present(alertController, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alertController.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func letsDoitPopUp(){
        let ZERO: Int = 0
        
        if difficultyInDays == ZERO {
            let alertController = UIAlertController(title: Strings.Challenge.pop_upTitleNoDays, message: Strings.Challenge.pop_upMessageNoDays, preferredStyle: .alert)
            
            present(alertController, animated: true) {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                alertController.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
            }
            
        } else {
            let alertController = UIAlertController(title: Strings.Challenge.pop_upTitleFirstStap, message: Strings.Challenge.pop_upMessageFirstStap, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: Strings.Challenge.continueButtonTitle, style: .default, handler: { (UIAlertAction) in
                self.checkIfChallengesIsTwo()
                self.navigateToActiveChallengeAction()

            }))
            present(alertController, animated: true)
            }
        }
    
    @objc func navigateToActiveChallengeAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func didTappedMondayButton() {
        mondayButtonChange.toggle()
        mondayButton.backgroundColor = mondayButtonChange ? Colors.purple : .white
        difficultyInDays = mondayButtonChange ? difficultyInDays+1 : difficultyInDays-1
        mondayButton.setTitleColor(mondayButtonChange ? .white : .black, for: .normal)
    }
    
    @objc func didTappedTuesdayButton() {
        tuesdayButtonChange.toggle()
        tuesdayButton.backgroundColor = tuesdayButtonChange ? Colors.purple : .white
        difficultyInDays = tuesdayButtonChange ? difficultyInDays+1 : difficultyInDays-1
        tuesdayButton.setTitleColor(tuesdayButtonChange ? .white : .black, for: .normal)
    }
    
    @objc func didTappedWednesdayButton() {
        wednesdayButtonChange.toggle()
        wednesdayButton.backgroundColor = wednesdayButtonChange ? Colors.purple : .white
        difficultyInDays = wednesdayButtonChange ? difficultyInDays+1 : difficultyInDays-1
        wednesdayButton.setTitleColor(wednesdayButtonChange ? .white : .black, for: .normal)
        changeDifficultyLabel()
    }
    
    @objc func didTappedThursdayButton() {
        thursdayButtonChange.toggle()
        thursdayButton.backgroundColor = thursdayButtonChange ? Colors.purple : .white
        difficultyInDays = thursdayButtonChange ? difficultyInDays+1 : difficultyInDays-1
        thursdayButton.setTitleColor(thursdayButtonChange ? .white : .black, for: .normal)
    }
    
    @objc func didTappedFridayButton() {
        fridayButtonChange.toggle()
        fridayButton.backgroundColor = fridayButtonChange ? Colors.purple : .white
        difficultyInDays = fridayButtonChange ? difficultyInDays+1 : difficultyInDays-1
        fridayButton.setTitleColor(fridayButtonChange ? .white : .black, for: .normal)
    }
    
    @objc func didTappedSaturdayButton() {
        saturdayButtonChange.toggle()
        saturdayButton.backgroundColor = saturdayButtonChange ? Colors.purple : .white
        difficultyInDays = saturdayButtonChange ? difficultyInDays+1 : difficultyInDays-1
        saturdayButton.setTitleColor(saturdayButtonChange ? .white : .black, for: .normal)
    }
    
    @objc func didTappedSundayButton() {
        sundayButtonChange.toggle()
        sundayButton.backgroundColor = sundayButtonChange ? Colors.purple : .white
        difficultyInDays = sundayButtonChange ? difficultyInDays+1 : difficultyInDays-1
        sundayButton.setTitleColor(sundayButtonChange ? .white : .black, for: .normal)
    }
    
    /*
     Wanneer ChallengeStartVieController gebruikt dient te worden, moet er een challenge meegegeven worden.
     */
    public init(challnge: Challenge){
        self.challenge = challnge
        self.co2 = challenge!.co2
        self.value = challenge!.value
        self.waste = challenge!.waste
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Challenge"
        view.backgroundColor = .white
        view.bringSubviewToFront(tipsView)
        let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action: #selector(tips_Pop_Up(_:)))
        tipsView.addGestureRecognizer(gestureSwift2AndHigher)
        collectionView.dataSource = self
        collectionView.delegate = self
        setUpViews()
    }
        
    func setUpViews(){
        setupLayout()
    }
    
    func setupLayout(){
        setupLetsdoitButton()
        setUpTableView()
        setupCollectionViewLayout()
        setupFrequancy()
        
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: 120),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 124
        tableView.separatorStyle = .none
        tableView.register(ChallengeStartTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupCollectionViewLayout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(tipsView)
        NSLayoutConstraint.activate([
            tipsView.heightAnchor.constraint(equalToConstant: 60),
            tipsView.widthAnchor.constraint(equalToConstant: 150),
            tipsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            tipsView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -85)
        ])
        
        view.addSubview(tipsIconLeaf)
        NSLayoutConstraint.activate([
            tipsIconLeaf.leftAnchor.constraint(equalTo: tipsView.leftAnchor, constant: 15),
            tipsIconLeaf.topAnchor.constraint(equalTo: tipsView.topAnchor, constant: 20),
            tipsIconLeaf.bottomAnchor.constraint(equalTo: tipsView.bottomAnchor, constant: -10),
        ])
        
        view.addSubview(tipsTitle)
        NSLayoutConstraint.activate([
            tipsTitle.leftAnchor.constraint(equalTo: tipsIconLeaf.rightAnchor, constant: 10),
            tipsTitle.topAnchor.constraint(equalTo: tipsView.topAnchor, constant: 10),
        ])
        
        view.addSubview(tipsSubTitle)
        NSLayoutConstraint.activate([
            tipsSubTitle.leftAnchor.constraint(equalTo: tipsIconLeaf.rightAnchor, constant: 10),
            tipsSubTitle.topAnchor.constraint(equalTo: tipsTitle.bottomAnchor, constant: 0)
        ])
        
        view.addSubview(tipsIconRight)
        NSLayoutConstraint.activate([
            tipsIconRight.rightAnchor.constraint(equalTo: tipsView.rightAnchor, constant: -5),
            tipsIconRight.topAnchor.constraint(equalTo: tipsView.topAnchor, constant: 20),
            tipsIconRight.bottomAnchor.constraint(equalTo: tipsView.bottomAnchor, constant: -10),
        ])
        
    }
    
    func setupFrequancy(){
        view.addSubview(frequancyLabel)
        NSLayoutConstraint.activate([
            frequancyLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0),
            frequancyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
        ])
        
        view.addSubview(frequencyView)
        NSLayoutConstraint.activate([
            frequencyView.topAnchor.constraint(equalTo: frequancyLabel.bottomAnchor, constant: 10),
            frequencyView.widthAnchor.constraint(equalToConstant: view.frame.width - 30 ),
            frequencyView.heightAnchor.constraint(equalToConstant: 100),
            frequencyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            frequencyView.bottomAnchor.constraint(equalTo: letsDoTtButton.topAnchor, constant: -190)
        ])
        
        view.addSubview(mondayButton)
        NSLayoutConstraint.activate([
            mondayButton.leftAnchor.constraint(equalTo: frequencyView.leftAnchor, constant: 5),
            mondayButton.bottomAnchor.constraint(equalTo: frequencyView.bottomAnchor, constant: -35),
            mondayButton.widthAnchor.constraint(equalToConstant: 40),
            mondayButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(tuesdayButton)
        NSLayoutConstraint.activate([
            tuesdayButton.leftAnchor.constraint(equalTo: mondayButton.leftAnchor, constant: 49),
            tuesdayButton.bottomAnchor.constraint(equalTo: frequencyView.bottomAnchor, constant: -35),
            tuesdayButton.widthAnchor.constraint(equalToConstant: 40),
            tuesdayButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(wednesdayButton)
        NSLayoutConstraint.activate([
            wednesdayButton.leftAnchor.constraint(equalTo: tuesdayButton.leftAnchor, constant: 49),
            wednesdayButton.bottomAnchor.constraint(equalTo: frequencyView.bottomAnchor, constant: -35),
            wednesdayButton.widthAnchor.constraint(equalToConstant: 40),
            wednesdayButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(thursdayButton)
        NSLayoutConstraint.activate([
            thursdayButton.leftAnchor.constraint(equalTo: wednesdayButton.leftAnchor, constant: 49),
            thursdayButton.bottomAnchor.constraint(equalTo: frequencyView.bottomAnchor, constant: -35),
            thursdayButton.widthAnchor.constraint(equalToConstant: 40),
            thursdayButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(fridayButton)
        NSLayoutConstraint.activate([
            fridayButton.leftAnchor.constraint(equalTo: thursdayButton.leftAnchor, constant: 49),
            fridayButton.bottomAnchor.constraint(equalTo: frequencyView.bottomAnchor, constant: -35),
            fridayButton.widthAnchor.constraint(equalToConstant: 40),
            fridayButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(saturdayButton)
        NSLayoutConstraint.activate([
            saturdayButton.leftAnchor.constraint(equalTo: fridayButton.leftAnchor, constant: 49),
            saturdayButton.bottomAnchor.constraint(equalTo: frequencyView.bottomAnchor, constant: -35),
            saturdayButton.widthAnchor.constraint(equalToConstant: 40),
            saturdayButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(sundayButton)
        NSLayoutConstraint.activate([
            sundayButton.leftAnchor.constraint(equalTo: saturdayButton.leftAnchor, constant: 49),
            sundayButton.bottomAnchor.constraint(equalTo: frequencyView.bottomAnchor, constant: -35),
            sundayButton.widthAnchor.constraint(equalToConstant: 40),
            sundayButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(difficultyLabel)
        NSLayoutConstraint.activate([
            difficultyLabel.rightAnchor.constraint(equalTo: frequencyView.rightAnchor, constant: -10),
            difficultyLabel.bottomAnchor.constraint(equalTo: frequencyView.bottomAnchor, constant: -5),
        ])
    }
    
    func setupLetsdoitButton(){
        view.addSubview(letsDoTtButton)
        NSLayoutConstraint.activate([
            letsDoTtButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letsDoTtButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            letsDoTtButton.widthAnchor.constraint(equalToConstant: 303),
            letsDoTtButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    


    @objc func infoPopUp(){
        
        let alertController = UIAlertController(title: Strings.Challenge.infoTitlePop_up, message: Strings.Challenge.infomessagePop_up, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: Strings.Challenge.done, style: .default, handler: { (UIAlertAction) in

        }))
        present(alertController, animated: true)
    }
    
}

extension ChallengeStartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChallengeStartTableViewCell
        
        tableViewCell.infoButton.addTarget(self, action: #selector(infoPopUp), for: .touchUpInside)
        
        tableViewCell.setChallenge(challenge: self.challenge!)
        
        if challenge != nil {
            guard let cellChallenge = challenge else { preconditionFailure() }
            tableViewCell.title.text = cellChallenge.title
            tableViewCell.subTitle.text = cellChallenge.subtitle
        }
        return tableViewCell
    }
}

extension ChallengeStartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeStartCollectionViewCell.identifier, for: indexPath) as! ChallengeStartCollectionViewCell
        
        
        if challenge != nil {
            
            switch indexPath.row {
            case 1:
                cell.myImageView.image = UIImage(named: images.co2Icon)
                cell.titleValue.text = String(challenge!.co2) + Strings.Challenge.gram
                cell.subTitle.text = Strings.Challenge.ofCo2Saved
            case 2:
                cell.myImageView.image = UIImage(named: images.spIcon)
                cell.titleValue.text = String(challenge!.value) + Strings.Challenge.sp
                cell.subTitle.text = Strings.Challenge.earned
            default:
                cell.myImageView.image = UIImage(named: images.wasteIcon)
                cell.titleValue.text = String(challenge!.waste) + Strings.Challenge.gram
                cell.subTitle.text = Strings.Challenge.ofWasteSaved
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

