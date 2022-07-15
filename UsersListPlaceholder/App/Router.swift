//
//  Router.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 15.07.2022.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterUsersProtocol: RouterProtocol {
    func initialViewController()
    func showUserDetails(user: UserEntity?)
    func popToRoot()
}

class RouterUsers: RouterUsersProtocol {
    
    var navigationController: UINavigationController?
    
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let usersTabViewController = builder?.createUsersTableViewController(router: self) else { return }
            navigationController.viewControllers = [usersTabViewController]
        }
    }
    
    func showUserDetails(user: UserEntity?) {
        if let navigationController = navigationController {
            guard let userDetailsViewController = builder?.createUserDetailsController(router: self, user: user) else { return }
            navigationController.pushViewController(userDetailsViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
}

