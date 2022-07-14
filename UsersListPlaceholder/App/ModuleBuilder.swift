//
//  ModuleBuilder.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 14.07.2022.
//

import Foundation
import UIKit

protocol Builder {
    
    static func createNavigateionController(rootViewController: UIViewController) -> UINavigationController
    
    static func createUsersModule() -> UIViewController
    
    static func createUserDetailsController() -> UIViewController
    
}

class ModuleBuilder: Builder {
    
    static func createNavigateionController(rootViewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: rootViewController)
    }
    
    static func createUsersModule() -> UIViewController {
        let view = UsersTableViewController()
        let presenter = UsersPresenter(view: view)
        view.usersPresenter = presenter
        return view
    }
    
    static func createUserDetailsController() -> UIViewController {
        return UserDetailsViewController()
    }
}
