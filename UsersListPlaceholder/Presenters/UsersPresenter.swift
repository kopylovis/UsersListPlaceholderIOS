//
//  UsersPresenter.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import Foundation
import UIKit

class UsersPresenter {
    
    private weak var usersInputDelegate: UsersViewDelegate?
    private var networkManager: NetworkManager!
    
    func setUserInputDelegate(delegate: UsersViewDelegate) {
        self.usersInputDelegate = delegate
        self.usersInputDelegate?.setInitialState()
    }
    
    init() {
        self.networkManager = NetworkManager()
    }
    
    private var cachedUsers: [UserUI] = []
    
    func getUsersData() {
        networkManager.getUsersList { [weak self] data in
            guard let self = self else { return }
            switch(data) {
            case .success(let users):
                let sorted = users.sortedByName()
                self.cachedUsers = sorted
                self.usersInputDelegate?.setupData(with: sorted)
                print("success:", users)
            case .failed(let error):
                print("error:", error)
            }
        }
    }
    
    func filterUsers(searchText: String, result: @escaping (_ users: [UserUI]) -> ()) {
        if (searchText.isEmpty) {
            result(cachedUsers)
        } else {
            result(cachedUsers.filteredAndSortedByPredicate(predicate: searchText))
        }
    }
}
