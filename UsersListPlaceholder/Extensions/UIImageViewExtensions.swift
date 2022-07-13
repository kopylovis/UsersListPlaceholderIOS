//
//  UIImageViewExtensions.swift
//  JsonPlaceholder
//
//  Created by Ivan Kopylov on 12.07.2022.
//

import Foundation
import UIKit

extension URL {
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func loadImageFromUrl(result: @escaping (_ data: Data) -> ()) {
        getData(from: self) { data, response, error in
            guard let data = data, error == nil else { return }
            result(data)
        }
    }
}
