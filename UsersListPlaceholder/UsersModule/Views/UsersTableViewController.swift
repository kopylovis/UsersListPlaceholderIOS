//
//  UsersTableViewController.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import UIKit

class UsersTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet private var spinner: UIActivityIndicatorView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!
    
    private var usersPresenter: UsersPresenter!
    
    private var users: [UserUI] = [] {
        didSet {
            reloadTableView()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        usersPresenter = UsersPresenter(view: self)
        usersPresenter.loadUsers()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.bindUser(user: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? UserDetailsViewController {
            detailViewController.user = users[indexPath.row]
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        usersPresenter.filterUsers(searchText: searchText) { result in
            self.users = result
        }
    }
}

extension UsersTableViewController: UsersViewProtocol {
    
    func setInitialState() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.isHidden = true
        searchBar.backgroundImage = UIImage()
        spinner.startAnimating()
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
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
            self.tableView.reloadData()
        }
    }
}
