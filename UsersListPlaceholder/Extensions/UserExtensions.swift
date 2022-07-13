//
//  UserExtensions.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import Foundation

extension UserEntity {
    
    func toUserUIModel(imageData: Data) -> UserUI {
        return UserUI(id: self.id, name: self.name, username: self.username, email: self.email, image: imageData)
    }
}
