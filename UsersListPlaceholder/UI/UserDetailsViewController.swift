//
//  UserDetailsViewController.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var name: UITextField!
    @IBOutlet private var email: UITextField!
    
    var user: UserUI?
    
//    convenience init(user: UserUI) {
//        self.init()
//        self.user = user
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        if let user = user {
            imageView.image = UIImage(data: user.image)
            name.text = user.name
            email.text = user.email
            self.title = "\(user.name)'s profile"
        }
    }

}
