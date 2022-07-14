//
//  UsersPresenter.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import Foundation
import UIKit

class UsersPresenter: UsersViewPresenterProtocol {
    
    private weak var view: UsersViewProtocol?
    private var usersRepository = UsersRepository.sharedInstance
    private var cachedUsers: [UserUI] = []
    
    required init(view: UsersViewProtocol) {
        self.view = view
        self.view?.setInitialState()
    }
    
    func loadUsers() {
        usersRepository.loadUsersFromNetwork { [weak self] data in
            guard let self = self else { return }
            switch(data) {
            case .success(let users):
                let sorted = users.sortedByName()
                self.cachedUsers = sorted
                self.view?.setupData(with: sorted)
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
