
//
//  PencilTableViewCell.swift
//  unirecycle
//
//  Created by mark on 14/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class PencilTableViewCell: UITableViewCell {
    static let identifier = "PencilTableViewCell"
    
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
    
    public let label: UITextField = {
        let label = UITextField()
        return label
    }()
    
    private let fbImage: UIImageView = {
        let image = UIImage(named: images.pencilIcon)
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
            x: 25 ,
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
    
    public func configure(with model: SettingsPencilOption){
        label.text = model.title
    }
    
}

