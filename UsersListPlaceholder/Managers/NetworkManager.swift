//
//  NetworkManager.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 13.07.2022.
//

import Foundation

class NetworkManager {
    
    private var cachedUsers: [UserUI] = []
    
    func getUsersList(result: @escaping (_ data: NetworkEnum) -> ()) {
        if (cachedUsers.isEmpty) {
            loadUsersFromNetwork(result: result)
        } else {
            result(NetworkEnum.success(users: cachedUsers))
        }
    }
    
    private func loadUsersFromNetwork(result: @escaping (_ data: NetworkEnum) -> ()) {
        if let url = URL(string: "https://run.mocky.io/v3/c902289c-02a7-4d19-a713-f5a8a90548fe") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let users = try JSONDecoder().decode([UserEntity].self, from: data)
                        var usersUI: [UserUI] = []
                        users.forEach { user in
                            URL(string: user.image)?.loadImageFromUrl(result: { data in
                                usersUI.append(user.toUserUIModel(imageData: data))
                                if (users.count == usersUI.count) {
                                    self.cachedUsers = usersUI
                                    result(NetworkEnum.success(users: usersUI))
                                }
                            })
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
