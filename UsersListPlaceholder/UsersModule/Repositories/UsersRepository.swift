//
//  NetworkManager.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 13.07.2022.
//

import Foundation
import Alamofire
import Moya

protocol UsersRepositoryProtocol {
    func loadUsersFromNetwork(resultData: @escaping (_ data: Result) -> ())
    func filterUsersByPredicate(predicate: String) -> [UserEntity]
}

class UsersRepository: UsersRepositoryProtocol {
        
    private var usersProvider: MoyaProvider<UsersService> = MoyaProvider()
            
    private var cachedUsers: [UserEntity] = []
    
    func loadUsersFromNetwork(resultData: @escaping (_ data: Result) -> ()) {
        var usersEntity: [UserEntity] = []
        usersProvider.request(.loadUsers) { [weak self] result in
            guard let self = self else { return }
            usersEntity = try! JSONDecoder().decode([UserEntity].self, from: result.get().data)
            self.loadImagesForUsers(users: usersEntity, result: resultData)
        }
    }
    
    func filterUsersByPredicate(predicate: String) -> [UserEntity] {
        if (predicate.isEmpty) {
            return cachedUsers.sortedByName()
        } else {
            return cachedUsers.filteredAndSortedByPredicate(predicate: predicate)
        }
    }
    
    private func loadImagesForUsers(users: [UserEntity], result: @escaping (_ data: Result) -> ()) {
        users.forEach { [weak self] user in
            guard let self = self else { return }
            usersProvider.request(.loadRandomAvatar) { event in
                switch event {
                case let .success(response):
                    self.cachedUsers.append(user.setImageData(data: response.data))
                    result(Result.success(users: self.cachedUsers.sortedByName()))
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
