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
    private var users: [UserUI] = []
    private let userPresenter = UsersPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.isHidden = true
        searchBar.backgroundImage = UIImage()
        spinner.startAnimating()
        userPresenter.getUsersList { [weak self] data in
            switch(data) {
            case let .success(users):
                guard let welf = self else { return }
                welf.users = users
                DispatchQueue.main.async {
                    welf.tableView.reloadData()
                    welf.spinner.stopAnimating()
                    welf.spinner.isHidden = true
                    welf.searchBar.isHidden = false
                }
            case let .failed(error):
                print("error:", error)
            }
        }
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
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
        userPresenter.filterUsers(searchText: searchText) { result in
            self.users = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
