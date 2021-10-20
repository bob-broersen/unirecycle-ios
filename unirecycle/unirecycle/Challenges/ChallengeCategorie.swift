//
//  ChallengeCategorie.swift
//  unirecycle
//
//  Created by Bob Broersen on 03/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class ChallengeCategorie: UIViewController {
    
    var category: Category?
    
    func setCategory(category: Category) {
        self.category = category
    }
    
    var parentSegment: UIViewController?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.name
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 132
        tableView.separatorStyle = .none
        tableView.register(CategorieTableViewCell.self, forCellReuseIdentifier: "cell")
        setupLayout()
    }
    
    func setupLayout() {
        setUpTableView()
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }

}

extension ChallengeCategorie: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (category?.challenges.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategorieTableViewCell
        tableViewCell.selectionStyle = .none
        tableViewCell.setChallenge(challenge: (category?.challenges[indexPath.row])!, category: category!)
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt didSelectRowAtIndexPath: IndexPath) {

        let challengeStartVC = ChallengeStartViewController(challnge: (category?.challenges[didSelectRowAtIndexPath.row])!)
        print("challenge id 1 = " + (category?.challenges[didSelectRowAtIndexPath.row].id)!)
        self.parentSegment?.navigationController?.pushViewController(challengeStartVC, animated: true)
//        print(category?.challenges[didSelectRowAtIndexPath.row].id)
        challengeStartVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(challengeStartVC, animated: true)
        }
}
