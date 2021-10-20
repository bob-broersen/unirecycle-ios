//
//  ChallengeHomeViewController.swift
//  unirecycle
//
//  Created by Daron on 11/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit



class ChallengeHomeViewController: UIViewController {
    
    var browse = BrowseViewController()
    var active = ActiveViewController()
    
    lazy var segmentControlls: [SegmentControlPage] = [
        SegmentControlPage(title: Strings.Challenge.segmentTitles[0], viewcontroller: browse),
        SegmentControlPage(title: Strings.Challenge.segmentTitles[1], viewcontroller: active),
    ]
    
    private lazy var customSegmentControl: CustomSegmentControl = {
        let sc = CustomSegmentControl()
        sc.updateSegmentControlWithItems(Strings.Challenge.segmentTitles)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.segmentControl.addTarget(self, action: #selector(changeView(_:)), for: .valueChanged)
        sc.segmentControl.selectedSegmentIndex = 0
        sc.setupLayout()
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = Strings.Challenge.title
        setUpViews()
        browse.parentSegment = self
        active.parentSegment = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.active.updateView()
    }
    
    func setUpViews(){
        view.addSubview(active.view)
        view.addSubview(browse.view)
        setupLayout()
    }
    
    func setupLayout(){
        view.addSubview(customSegmentControl)
        NSLayoutConstraint.activate([
            customSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            customSegmentControl.heightAnchor.constraint(equalToConstant: 50),
            customSegmentControl.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
    }
    
    @objc func changeView(_ sender: UISegmentedControl) {
        active.updateActiveChallenge(completion: {
            self.active.updateView()
            let index = sender.selectedSegmentIndex
            let selectedViewController = self.segmentControlls[index].viewcontroller
            for segmentControl in self.segmentControlls {
                if segmentControl.viewcontroller !== selectedViewController {
                    segmentControl.viewcontroller.view.isHidden = true
                } else {
                    selectedViewController.view.isHidden = false
                }
            }
        })
    }
}

