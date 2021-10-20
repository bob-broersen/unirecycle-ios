//
//  IntroNavigationController.swift
//  unirecycle
//
//  Created by Bob Broersen on 03/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class IntroNavigationController: UINavigationController, UINavigationControllerDelegate {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.delegate = self
    
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
        let navigationTitleFont = UIFont(name: "Roboto-Regular", size: 30)!
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white]
//        makeCorners()
        makeSeeTrough()
        changeBarImage()
    }
    

    func makeCorners(){
        let cornerView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.height, width: navigationBar.frame.width, height: 84 - navigationBar.frame.height))
        cornerView.backgroundColor = Colors.purple
        cornerView.layer.cornerRadius = 25
        cornerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        navigationBar.addSubview(cornerView)
    }
    
    private func makeSeeTrough(){
        navigationBar.barTintColor = Colors.purple
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
    }
    
    private func changeBarImage(){
        navigationBar.backIndicatorImage = UIImage(named: images.backButtonImage)?.withRenderingMode(.alwaysOriginal)
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: images.backButtonImage)?.withRenderingMode(.alwaysOriginal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
    
    
}
