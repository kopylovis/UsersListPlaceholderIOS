//
//  ImageService.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 15.07.2022.
//

import Foundation
import Moya

enum ImageService {
    case random
}

extension ImageService: TargetType {
    var baseURL: URL { return URL(string: "https://i.pravatar.cc")! }

    var path : String {
        switch self {
        case .random:
            return "/300"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return "Something went wrong".data(using: .utf8)!
    }

    var task: Task {
        switch self {
        case .random: return .requestPlain
        }
    }

    var validate: Bool {
        return true
    }

    var headers: [String : String]? {
        return nil
    }
}
