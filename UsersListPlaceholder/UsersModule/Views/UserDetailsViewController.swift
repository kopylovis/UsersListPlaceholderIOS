//
//  UserDetailsViewController.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    var presenter: UserDetailsPresenter!
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.frame.size.width = 250
        imageView.frame.size.height = 250
        imageView.layer.cornerRadius = imageView.frame.width / 2
        return imageView
    }()
    
    private lazy var nameView: UILabel = {
        let nameView = UILabel()
        nameView.textColor = .black
        nameView.font = UIFont.boldSystemFont(ofSize: 28)
        nameView.sizeToFit()
        nameView.textAlignment = .center
       return nameView
    }()
    
    private lazy var emailView: UILabel = {
        let emailView = UILabel()
        emailView.textColor = .darkGray
        emailView.sizeToFit()
        emailView.textAlignment = .center
        return emailView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        presenter.loadUserDetails()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

    }
    
    private func setupUI() {
        view.backgroundColor = .white
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(emailView)
        self.view.addSubview(stackView)
    }

}

extension UserDetailsViewController: UserDetailsViewProtocol {
    
    func setupData(user: UserEntity) {
        if let image = user.image {
            imageView.image = UIImage(data: image)
        }
        nameView.text = user.name
        emailView.text = user.email
        self.title = "\(user.name)'s profile"
    }
    
}
