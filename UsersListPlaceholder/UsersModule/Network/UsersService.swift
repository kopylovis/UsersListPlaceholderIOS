//
//  UsersService.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 14.07.2022.
//

import Foundation
import Moya

enum UsersService {
    case loadUsers
    case loadRandomAvatar
}

extension UsersService: TargetType {
    
    var baseURL: URL {
        switch self {
        case .loadUsers:
            return URL(string: "https://run.mocky.io/v3")!
        case .loadRandomAvatar:
            return URL(string: "https://i.pravatar.cc")!
        }
    }
    
    var path: String {
        switch self {
        case .loadUsers:
            return "/80b32399-9b79-4b51-a5b9-b87d3a690d84"
        case .loadRandomAvatar:
            return "/300"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loadUsers, .loadRandomAvatar:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .loadUsers, .loadRandomAvatar: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
