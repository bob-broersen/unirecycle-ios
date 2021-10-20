//
//  SendTableViewCell.swift
//  unirecycle
//
//  Created by mark on 24/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class SendTableViewCell: UITableViewCell {
    static let identifier = "SendTableViewCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let fbImage: UIImageView = {
        let image = UIImage(named: images.fbhelpIcon)
        let profilePicture = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        profilePicture.image = image
        return profilePicture
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(fbImage)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .purple
        accessoryType = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        
        fbImage.sizeToFit()
        fbImage.frame = CGRect(x: contentView.frame.size.width - fbImage.frame.size.width - 20,
                                y: (contentView.frame.size.height - fbImage.frame.size.height) / 2,
                                width: fbImage.frame.size.width,
                                height: fbImage.frame.size.height)
        
        
        label.frame = CGRect(
            x: contentView.frame.size.width/2 ,
            y: 0,
            width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
            height: contentView.frame.size.height)
            }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        fbImage.image = nil
    }
    
    public func configure(with model: SendTableViewCell){
    }
    
}

