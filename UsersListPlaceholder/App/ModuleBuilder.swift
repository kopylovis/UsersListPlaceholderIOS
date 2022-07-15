//
//  ModuleBuilder.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 14.07.2022.
//

import Foundation
import UIKit

protocol BuilderProtocol {
        
    func createUsersTableViewController(router: RouterUsersProtocol) -> UIViewController
    
    func createUserDetailsController(router: RouterUsersProtocol, user: UserUI?) -> UIViewController
    
}

class ModuleBuilder: BuilderProtocol {
    
    func createUsersTableViewController(router: RouterUsersProtocol) -> UIViewController {
        let view = UsersTableViewController()
        let usersRepository = UsersRepository.sharedInstance
        let presenter = UsersPresenter(view: view, usersRepository: usersRepository, router: router)
        view.usersPresenter = presenter
        return view
    }
    
    func createUserDetailsController(router: RouterUsersProtocol, user: UserUI?) -> UIViewController {
        let view = UserDetailsViewController()
        let presenter = UserDetailsPresenter(view: view, user: user)
        view.presenter = presenter
        return view
    }
}
