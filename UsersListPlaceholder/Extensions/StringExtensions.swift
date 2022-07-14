//
//  StringExtensions.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 14.07.2022.
//

import Foundation

extension String {
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(result: @escaping (_ data: Data) -> ()) {
        getData(from: URL(string: self)!) { data, response, error in
            guard let data = data, error == nil else { return }
            result(data)
        }
    }
    
}
