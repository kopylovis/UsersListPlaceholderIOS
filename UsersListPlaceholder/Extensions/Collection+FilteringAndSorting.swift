//
//  CollectionExtensions.swift
//  UsersListPlaceholder
//
//  Created by Ivan Kopylov on 13.07.2022.
//

import Foundation

extension Array where Element == UserEntity {
    
    func sortedByName() -> [UserEntity] {
        return self.sorted { $0.name.lowercased() < $1.name.lowercased() }
    }
    
    func filteredAndSortedByPredicate(predicate: String) -> [UserEntity] {
        return self.filter { $0.name.lowercased().contains(predicate.lowercased()) }.sortedByName()
    }
}
