//
//  UserTableViewCell.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet private var userName: UILabel!
    @IBOutlet private var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        userImage.backgroundColor = .gray
    }
    
    func bindUser(user: UserUI?) {
        if let user = user {
            userName.text = user.name
            userImage.image = UIImage(data: user.image)
        }
    }
    
}
