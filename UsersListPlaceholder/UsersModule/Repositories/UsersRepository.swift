//
//  NetworkManager.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 13.07.2022.
//

import Foundation
import Alamofire
import Moya

class UsersRepository {
    
    static let sharedInstance = UsersRepository()
    
    private var usersProvider: MoyaProvider<UsersService> = MoyaProvider()
        
    private var cachedUsers: [UserUI] = []
    
    func loadUsersFromNetwork(resultData: @escaping (_ data: Result) -> ()) {
        var usersEntity: [UserEntity] = []
        usersProvider.request(.loadUsers) { [weak self] result in
            guard let self = self else { return }
            usersEntity = try! JSONDecoder().decode([UserEntity].self, from: result.get().data)
            self.loadImagesForUsers(users: usersEntity, result: resultData)
        }
    }
    
    func loadImagesForUsers(users: [UserEntity], result: @escaping (_ data: Result) -> ()) {
        users.forEach { user in
            user.image.downloadImage { [weak self] data in
                guard let self = self else { return }
                self.cachedUsers.append(user.toUserUIModel(imageData: data))
                result(Result.success(users: self.cachedUsers))
            }
        }
    }
}
