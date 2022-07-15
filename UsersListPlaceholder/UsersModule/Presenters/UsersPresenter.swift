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
    private var usersRepository: UsersRepository?
    private var router: RouterProtocol?
    
    required init(view: UsersViewProtocol, usersRepository: UsersRepository, router: RouterProtocol) {
        self.view = view
        self.usersRepository = usersRepository
        self.router = router
        self.view?.setInitialState()
    }
    
    func loadUsers() {
        if let usersRepository = usersRepository {
            usersRepository.loadUsersFromNetwork { [weak self] data in
                guard let self = self else { return }
                switch(data) {
                case .success(let users):
                    self.view?.setupData(with: users.sortedByName())
                    print("success:", users)
                case .failed(let error):
                    print("error:", error)
                }
            }
        }
    }
        
    func filterUsers(searchText: String, result: @escaping (_ users: [UserUI]) -> ()) {
        if let cachedUsers = usersRepository?.cachedUsers {
            if (searchText.isEmpty) {
                result(cachedUsers)
            } else {
                result(cachedUsers.filteredAndSortedByPredicate(predicate: searchText))
            }
        }
    }
    
    func onUserClickListener(user: UserUI?) {
        router?.showUserDetails(user: user)
    }
    
}
