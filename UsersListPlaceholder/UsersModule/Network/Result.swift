//
//  NetworkEnum.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import Foundation

enum Result {
    case success(users: [UserEntity])
    case failed(error: String)
}
