//
//  UsersViewProtocol.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 14.07.2022.
//

import Foundation

protocol UsersViewProtocol: AnyObject {
    func setInitialState()
    func setLoadedState()
    func reloadTableView()
    func setupData(with users: [UserUI])
}

protocol UsersViewPresenterProtocol: AnyObject {
    init(view: UsersViewProtocol)
    func loadUsers()
}