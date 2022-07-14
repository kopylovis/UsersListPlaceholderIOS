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
}

extension UsersService: TargetType {
    
    var baseURL: URL {
        switch self {
        case .loadUsers:
            return URL(string: "https://run.mocky.io/v3")!
        }
    }
    
    var path: String {
        switch self {
        case .loadUsers: return "/c902289c-02a7-4d19-a713-f5a8a90548fe"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loadUsers:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .loadUsers: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
        
}
