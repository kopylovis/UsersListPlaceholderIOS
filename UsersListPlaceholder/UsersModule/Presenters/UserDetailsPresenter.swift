//
//  UserDetailsPresenter.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 15.07.2022.
//

import Foundation

class UserDetailsPresenter: UserDetailsViewPresenterProtocol {
    
    private weak var view: UserDetailsViewProtocol?
    private var user: UserUI?
    
    required init(view: UserDetailsViewProtocol, user: UserUI?) {
        self.view = view
        self.user = user
    }
    
    func loadUserDetails() {
        guard let user = user else { return }
        view?.setupData(user: user)
    }
    
}
