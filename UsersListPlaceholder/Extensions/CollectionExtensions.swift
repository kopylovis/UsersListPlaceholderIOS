//
//  CollectionExtensions.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 13.07.2022.
//

import Foundation

extension Array where Element == UserUI {
    
    func sortedByName() -> [UserUI] {
        return self.sorted { $0.name.lowercased() < $1.name.lowercased() }
    }
    
    func filteredAndSortedByPredicate(predicate: String) -> [UserUI] {
        return self.filter { $0.name.lowercased().contains(predicate.lowercased()) }.sortedByName()
    }
}
