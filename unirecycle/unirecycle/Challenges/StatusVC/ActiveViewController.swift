//
//  ActiveViewController.swift
//  unirecycle
//
//  Created by Daron on 05/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class ActiveViewController: UIViewController {
    var parentSegment: UIViewController?
    
    var activeUser = Account()
    var tapGestureRecognizer = UIGestureRecognizer()
    var coins = 0
    
    let alert = UIAlertController(title: "you have already logged an action for this day", message: nil, preferredStyle: .alert)
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "empty_chall")
        return imageView
    }()
    
    let headLabel: UILabel = {
        let label = UILabel()
        label.text = "It seems empty"
        label.font = UIFont(name: "Roboto", size: 20)
        label.textAlignment = .center
        label.textColor = Colors.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let head2Label: UILabel = {
        let label = UILabel()
        label.text = "Start a challenge to find it here"
        label.font = UIFont(name: "Roboto", size: 12)
        label.textColor = Colors.gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emptyView: UIView = {
        let bView = UIView()
        bView.translatesAutoresizingMaskIntoConstraints = false
        return bView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(ActiveTableViewCell.self, forCellReuseIdentifier: ActiveTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeUser = userViewModel!.user
        
        tableView.delegate = self
        tableView.dataSource = self
        setupEmptyChallengeLayout()
        setupTableView()
        alert.addAction(UIAlertAction(title: "OKE", style: .default, handler: nil))
        if activeUser.activeChallenges?.count == 0 {
            self.emptyView.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.emptyView.isHidden = true
            self.tableView.isHidden = false
        }
        
    }
    
    func updateActiveChallenge(completion: @escaping () -> ()) {
        userViewModel?.fetchUser {
            self.activeUser = userViewModel!.user
            self.tableView.reloadData()
            self.dismiss(animated: true, completion: nil)
            completion()
        }
        
    }
    
    func updateView() {
        updateActiveChallenge(completion: {
            if self.activeUser.activeChallenges?.count == 0 {
                self.emptyView.isHidden = false
                self.tableView.isHidden = true
            } else {
                self.emptyView.isHidden = true
                self.tableView.isHidden = false
            }
        }
        )
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
    }
    
    @objc func openPopup(sender: UITapGestRecHelper) {
        
    }
    
    func setupEmptyChallengeLayout(){
        view.addSubview(emptyView)
        
        emptyView.addSubview(myImageView)
        NSLayoutConstraint.activate([
            myImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            myImageView.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
        ])
        emptyView.addSubview(headLabel)
        NSLayoutConstraint.activate([
            headLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 10),
            headLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
        ])
        emptyView.addSubview(head2Label)
        NSLayoutConstraint.activate([
            head2Label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            head2Label.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 10),
            head2Label.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
        ])
    }
    
    func checkIfLastChallenge(){
        print(String(tableView.visibleCells.count) + " count")
        if tableView.visibleCells.isEmpty {
            updateView()
        }
    }
}

extension ActiveViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeUser.activeChallenges?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActiveTableViewCell.identifier) as! ActiveTableViewCell
        
        cell.setChallenge(activeChallenge: (activeUser.activeChallenges?[indexPath.row])!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt didSelectRowAtIndexPath: IndexPath) {
        let lastDayCompleted = activeUser.activeChallenges?[didSelectRowAtIndexPath.row].daysCompleted.last
        let calendar = NSCalendar.current
        
        //make last day today at the start this is error handeling if there were no days completed yet
        var lastDay = calendar.dateComponents([.day], from: Date())
        var today = calendar.dateComponents([.day], from: Date())
        
        // if the dayscompleted array is not empty use the last day of completed days array
        if lastDayCompleted != nil {
            lastDay = calendar.dateComponents([.day], from: lastDayCompleted as! Date)
        }
        let endDate = calendar.dateComponents([.day], from: activeUser.activeChallenges?[didSelectRowAtIndexPath.row].endDate as! Date)
        
        //last day equals the enddate
        if  (lastDay.day == endDate.day) {
            //opens claim modal
            let slideVC = ClaimCoinsModal()
            slideVC.activeView = self
            slideVC.modalPresentationStyle = .custom
            slideVC.transitioningDelegate = self
            coins = (activeUser.activeChallenges?[didSelectRowAtIndexPath.row].value)! * (activeUser.activeChallenges?[didSelectRowAtIndexPath.row].daysCompleted.count)!
            slideVC.setupModal(coins: coins, completedChallenge: (activeUser.activeChallenges?[didSelectRowAtIndexPath.row])!)
            self.present(slideVC, animated: true, completion: nil)
            
        }
        //last day does not equal enddate
        else {
            //dayscompleted is not empty
            if lastDayCompleted != nil {
                //lastday logged is the same as today so warning is shown
                if (lastDay.day == today.day) {
                    self.present(alert, animated: true)
                } else{
                    //client can log todays action, navigates to action log page
                    let actionLogVC = ActionLogViewController()
                    actionLogVC.setActiveChallenge(activeChallenge: (activeUser.activeChallenges?[didSelectRowAtIndexPath.row])!)
                    parentSegment?.navigationController?.pushViewController(actionLogVC, animated: true)
                }
            }
            //last day equals empty
            else {
                // so we minus one to let the user logs todays action
                if (lastDay.day!-1 == today.day) {
                    self.present(alert, animated: true)
                } else{
                    //else they can log action for the same day they start a challenge
                    let actionLogVC = ActionLogViewController()
                    actionLogVC.setActiveChallenge(activeChallenge: (activeUser.activeChallenges?[didSelectRowAtIndexPath.row])!)
                    parentSegment?.navigationController?.pushViewController(actionLogVC, animated: true)
                }
            }
            
            
        }
        
    }
    
}
extension ActiveViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ClaimCoinsPresentationVC(presentedViewController: presented, presenting: presenting)
    }
    
}

