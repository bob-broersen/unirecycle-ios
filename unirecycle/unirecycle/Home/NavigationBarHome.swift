//
//  NavigationBarHome.swift
//  unirecycle
//
//  Created by Bob Broersen on 16/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

struct tabBarViewItem{
    let viewController: UIViewController
    let image: UIImage
}

class NavigationBarHome: UITabBarController, UITabBarControllerDelegate {

    let barHeight: CGFloat = 400
    
    var controllers: [tabBarViewItem] = [
        tabBarViewItem(viewController: IntroNavigationController(rootViewController: HomeViewController()), image: UIImage(named: images.homeIcon)!),
        tabBarViewItem(viewController: IntroNavigationController(rootViewController: ChallengeHomeViewController()), image: UIImage(named: images.challengeIcon)!),
        tabBarViewItem(viewController: IntroNavigationController(rootViewController: LeaderboardViewController()), image: UIImage(named: images.leaderboardIcon)!),
        tabBarViewItem(viewController: IntroNavigationController(rootViewController: RewardViewController()), image: UIImage(named: images.rewardsIcon)!),
        tabBarViewItem(viewController: IntroNavigationController(rootViewController: CommunityViewController()), image: UIImage(named: images.community)!)
    ]
    
    var tabBarItems: [UIViewController] = []
    
    func addControllers() {
        for tabBarItem in controllers {
            let icon = UITabBarItem(title: tabBarItem.viewController.title, image: tabBarItem.image, selectedImage: tabBarItem.image)
            tabBarItem.viewController.tabBarItem = icon
            tabBarItems.append(tabBarItem.viewController)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        tabBar.frame.size.height = barHeight
        tabBar.frame.origin.y = view.frame.height - barHeight
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.tintColor = Colors.purple
        tabBar.unselectedItemTintColor = Colors.purple
        addControllers()
        viewControllers = tabBarItems
    }
    
    override var selectedViewController: UIViewController? {
    didSet {

        guard let viewControllers = viewControllers else {
            return
        }

        for viewController in viewControllers {

            if viewController == selectedViewController {

                
                viewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.purple, NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 16)!], for:.normal)

            } else {

                viewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
            }
        }
        }
    }

}
