//
//  UserDetailsViewProtocol.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 15.07.2022.
//

import Foundation

protocol UserDetailsViewProtocol: AnyObject {
    func setupData(user: UserUI)
}

protocol UserDetailsViewPresenterProtocol: AnyObject {
    init(view: UserDetailsViewProtocol, user: UserUI?)
    func loadUserDetails()
}
