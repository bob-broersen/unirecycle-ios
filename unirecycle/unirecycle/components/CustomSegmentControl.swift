//
//  CustomSegmentControl.swift
//  unirecycle
//
//  Created by Daron on 03/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

struct SegmentControlPage {
    let title: String
    var viewcontroller: UIViewController
}

class CustomSegmentControl: UIView {
    
     var segmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: [])
        sc.addTarget(self, action: #selector(segmentControlValueChange(_:)), for: .valueChanged)
        if #available(iOS 13.0, *) {
            let bg = UIImage(color: .clear, size: CGSize(width: 1, height: 32))
            let devider = UIImage(color: .clear, size: CGSize(width: 1, height: 32))
                        
            sc.setDividerImage(devider,
                                    forLeftSegmentState: .normal,
                                    rightSegmentState: .normal, barMetrics: .default)
            sc.setBackgroundImage(bg, for: .normal, barMetrics: .default)
            sc.setBackgroundImage(devider, for: .selected, barMetrics: .default)
        } else {
            sc.tintColor = .white
        }
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let bottomBar: UIView = {
        let bView = UIView()
        bView.translatesAutoresizingMaskIntoConstraints = false
        bView.backgroundColor = Colors.segmentGray
        return bView
    }()
    
    let switchBar: UIView = {
        let bView = UIView()
        bView.translatesAutoresizingMaskIntoConstraints = false
        bView.layer.cornerRadius = 2
        bView.backgroundColor = Colors.purple
        return bView
    }()
    
    func updateSegmentControlWithItems(_ items: [String]) {
        self.segmentControl.removeAllSegments()
        for (index, item) in items.enumerated() {
            self.segmentControl.insertSegment(withTitle: item, at: index, animated: true)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        addSubview(segmentControl)
        NSLayoutConstraint.activate([
            segmentControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            segmentControl.leftAnchor.constraint(equalTo: self.leftAnchor),
            segmentControl.widthAnchor.constraint(equalTo: widthAnchor),
        ])
        
        addSubview(bottomBar)
        NSLayoutConstraint.activate([
            bottomBar.centerXAnchor.constraint(equalTo: segmentControl.centerXAnchor),
            bottomBar.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 0),
            bottomBar.heightAnchor.constraint(equalToConstant: 4),
            bottomBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            bottomBar.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])

        bottomBar.addSubview(switchBar)
        NSLayoutConstraint.activate([
            switchBar.leftAnchor.constraint(equalTo: segmentControl.leftAnchor, constant: 50),
            switchBar.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 0),
            switchBar.heightAnchor.constraint(equalToConstant: 4),
            switchBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5 / CGFloat(segmentControl.numberOfSegments))
        ])
    }
    
    @objc func segmentControlValueChange(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            let originX = (self.segmentControl.frame.width / CGFloat(self.segmentControl.numberOfSegments)) * CGFloat(self.segmentControl.selectedSegmentIndex) + 50
            self.switchBar.frame.origin.x = originX
        }
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(data: image.pngData()!)!
    }
}
