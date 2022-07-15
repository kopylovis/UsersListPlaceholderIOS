//
//  User.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import Foundation

struct UserEntity: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let image: Data?
}

extension UserEntity {
    func setImageData(data: Data) -> UserEntity {
        return UserEntity(id: self.id, name: self.name, username: self.username, email: self.email, image: data)
    }
}
