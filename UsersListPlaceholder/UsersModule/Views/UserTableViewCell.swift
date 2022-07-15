//
//  UserTableViewCell.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    private let userName = UILabel()
    
    private let userImage = UIImageView()
    
    private func setupUI() {
        addSubview(userImage)
        addSubview(userName)
        userImage.clipsToBounds = true
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.backgroundColor = .gray
        userImage.frame.size.width = 64
        userImage.layer.cornerRadius = (userImage.frame.width) / 2
        userName.textColor = .black
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.sizeToFit()
    }
    
    private func setupConstraints() {
        userImage.widthAnchor.constraint(equalToConstant: 64).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 64).isActive = true
        userImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        userImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userName.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 20).isActive = true
        userName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func bindUser(user: UserEntity?) {
        if let user = user {
            userName.text = user.name
            guard let image = user.image else { return }
            userImage.image = UIImage(data: image)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
