//
//  NetworkEnum.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import Foundation

enum Result {
    case success(users: [UserUI])
    case failed(error: String)
}
