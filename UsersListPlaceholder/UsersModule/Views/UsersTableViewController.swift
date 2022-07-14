//
//  UsersTableViewController.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import UIKit

class UsersTableViewController: UIViewController {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.sizeToFit()
        searchBar.placeholder = "Enter user's name..."
        searchBar.searchBarStyle = .prominent
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var usersTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        table.frame = view.frame
        return table
    }()
    
    var usersPresenter: UsersPresenter!
    
    private var users: [UserUI] = [] {
        didSet {
            reloadTableView()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        usersPresenter.loadUsers()
    }
    
    private func setupViews() {
        navigationItem.titleView = searchBar
        title = "Users"
        view.addSubview(usersTableView)
        view.addSubview(spinner)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

extension UsersTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        usersPresenter.filterUsers(searchText: searchText) { result in
            self.users = result
        }
    }
    
}

extension UsersTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.bindUser(user: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailViewController = UserDetailsViewController()
        userDetailViewController.user = users[indexPath.row]
        navigationController?.pushViewController(userDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 10
    }
}

extension UsersTableViewController: UsersViewProtocol {
    
    func setInitialState() {
        spinner.startAnimating()
        spinner.isHidden = false
        searchBar.isHidden = true
    }
    
    func setupData(with users: [UserUI]) {
        self.users = users
        setLoadedState()
    }
    
    func setLoadedState() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            self.searchBar.isHidden = false
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.usersTableView.reloadData()
        }
    }
}
