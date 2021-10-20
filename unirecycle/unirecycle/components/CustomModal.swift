//
//  CustomModal.swift
//  unirecycle
//
//  Created by Daron on 24/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit
import RangeSeekSlider
import DropDown

class CustomModal: UIViewController {
    
    lazy var rewards = [Reward]()
    
    let rangeSeekSlider = RangeSeekSlider()
    let dropdownCategory = DropDown()
    let dropdownType = DropDown()
    let categoryVals = ["None", "Food", "Outdoor"]
    let typeVals = ["None", "a", "b"]
    
    var rewardController: RewardViewController?
    var activeView: ActiveViewController?

    var rewardsFilters = rewardsFilter(min: 0, max: 800, category: "", type: "")
    
    

    var minValue = 0
    var maxValue = 800
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var panGesture = UIPanGestureRecognizer()
    
    private let slideBar: UIView = {
        let slideBar = UIView()
        slideBar.backgroundColor = .lightGray
        slideBar.translatesAutoresizingMaskIntoConstraints = false
        slideBar.layer.cornerRadius = 3
        return slideBar
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.text = "Filters"
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.text = "Category"
        return label
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("None", for: .normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(categoryFilter), for: .touchUpInside)
        return button
    }()
    
    private let typeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitle("None", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(typeFilter), for: .touchUpInside)
        return button
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.text = "Type"
        return label
    }()
    
    private let rangeSliderView: UIView = {
        let slideBar = UIView()
        slideBar.translatesAutoresizingMaskIntoConstraints = false
        return slideBar
    }()
    
    private let priceRangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.text = "Price range"
        return label
    }()
    
    private let priceFilterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.textColor = Colors.purple
        label.text = "0 - 800"
        return label
    }()
    
    let rewardIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Sustainable-coin")
        image.layer.zPosition = 1
        return image
    }()
    
    private let applyButton: Button = {
        let button = Button()
        button.setTitle(Strings.Reward.applyButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDropDown()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        setUpViews()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func applyFilters() {
        rewardViewModel?.fetchFilteredRewards(filters: rewardsFilters)
        rewardController?.updateRewards()
    }
    
    @objc func categoryFilter() {
        dropdownCategory.show()
    }
    @objc func typeFilter() {
        dropdownType.show()
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        //disables the gesture when clicking on the range slider
        if rangeSeekSlider.isHighlighted {
            panGesture.isEnabled = false
            panGesture.isEnabled = true
        }
        
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    @objc func rangeValueChange(sender: UISlider) {
        priceFilterLabel.text = "\(Int(rangeSeekSlider.selectedMinValue.rounded())) - \(Int(rangeSeekSlider.selectedMaxValue.rounded()))"
        
        if (Int(rangeSeekSlider.selectedMaxValue.rounded())) != minValue {
            self.rewardsFilters.min = (Int(rangeSeekSlider.selectedMinValue.rounded()))
        }
        if (Int(rangeSeekSlider.selectedMaxValue.rounded())) != maxValue {
            self.rewardsFilters.max = (Int(rangeSeekSlider.selectedMaxValue.rounded()))
        }
    }
    
    func setUpViews() {
        setupRangeSlider()
        mainLayout()
//        formLayout()
        sliderLayout()
    }
    
    func setupRangeSlider() {
        rangeSeekSlider.tintColor = Colors.purple
        rangeSeekSlider.maxValue = CGFloat(maxValue)
        rangeSeekSlider.minValue = CGFloat(minValue)
        rangeSeekSlider.selectedMaxValue = CGFloat(maxValue)
        rangeSeekSlider.handleColor = .white
        rangeSeekSlider.handleBorderColor = Colors.purple
        rangeSeekSlider.lineHeight = 4
        rangeSeekSlider.addTarget(self, action: #selector(rangeValueChange(sender:)), for: UIControl.Event.allEvents)
        rangeSeekSlider.handleBorderWidth = 4
        rangeSeekSlider.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupDropDown() {
        dropdownCategory.dataSource = categoryVals
        dropdownCategory.anchorView = categoryButton
        dropdownCategory.selectionAction = { [unowned self]
            (index: Int, item: String) in
            if categoryVals[index] != "None" {
                self.rewardsFilters.category = categoryVals[index]
            }else {
                self.rewardsFilters.category = ""
            }
            self.categoryButton.setTitle(categoryVals[index], for: .normal)
        }
        
        dropdownType.dataSource = typeVals
        dropdownType.anchorView = typeButton
        dropdownType.selectionAction = { [unowned self]
            (index: Int, item: String) in
            if typeVals[index] != "None" {
                self.rewardsFilters.type = typeVals[index]
            }else {
                self.rewardsFilters.type = ""
            }
            self.typeButton.setTitle(typeVals[index], for: .normal)
        }
    }
    
    func mainLayout() {
        view.addSubview(slideBar)
        NSLayoutConstraint.activate([
            slideBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slideBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            slideBar.heightAnchor.constraint(equalToConstant: 5),
            slideBar.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: slideBar.bottomAnchor, constant: 20),
        ])
        
        
        view.addSubview(applyButton)
        NSLayoutConstraint.activate([
            applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            applyButton.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
            applyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            applyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func formLayout() {
        view.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            categoryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12)
        ])
        
        view.addSubview(categoryButton)
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            categoryButton.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
            categoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        view.addSubview(typeLabel)
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 20),
            typeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12)
        ])
        
        view.addSubview(typeButton)
        NSLayoutConstraint.activate([
            typeButton.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            typeButton.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
            typeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func sliderLayout() {
        
        view.addSubview(rangeSliderView)
        NSLayoutConstraint.activate([
            rangeSliderView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            rangeSliderView.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
            rangeSliderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rangeSliderView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        rangeSliderView.addSubview(priceRangeLabel)
        NSLayoutConstraint.activate([
            priceRangeLabel.topAnchor.constraint(equalTo: rangeSliderView.topAnchor, constant: 0),
            priceRangeLabel.leftAnchor.constraint(equalTo: rangeSliderView.leftAnchor, constant: 0)
        ])
        
        
        rangeSliderView.addSubview(rewardIcon)
        NSLayoutConstraint.activate([
            rewardIcon.topAnchor.constraint(equalTo: rangeSliderView.topAnchor, constant: 0),
            rewardIcon.rightAnchor.constraint(equalTo: rangeSliderView.rightAnchor, constant: 0)
        ])
        
        rangeSliderView.addSubview(priceFilterLabel)
        NSLayoutConstraint.activate([
            priceFilterLabel.topAnchor.constraint(equalTo: rangeSliderView.topAnchor, constant: 0),
            priceFilterLabel.rightAnchor.constraint(equalTo: rangeSliderView.rightAnchor, constant: -20)
        ])
        
        rangeSliderView.addSubview(rangeSeekSlider)
        NSLayoutConstraint.activate([
            rangeSeekSlider.bottomAnchor.constraint(equalTo: rangeSliderView.bottomAnchor, constant: 0),
            rangeSeekSlider.rightAnchor.constraint(equalTo: rangeSliderView.rightAnchor),
            rangeSeekSlider.leftAnchor.constraint(equalTo: rangeSliderView.leftAnchor)
        ])
    }
}

