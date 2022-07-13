//
//  UsersInputDelegate.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 13.07.2022.
//

import Foundation

protocol UsersViewDelegate: AnyObject {
    func setInitialState()
    func setLoadedState()
    func reloadTableView()
    func setupData(with users: [UserUI])
}
