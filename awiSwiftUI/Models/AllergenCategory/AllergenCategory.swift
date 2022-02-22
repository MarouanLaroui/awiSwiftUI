//
//  AllergenCategory.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import Foundation

class AllergenCategory : Identifiable, Hashable{
    
    var delegate : AllergenCategoryDelegate?
    
    var id : Int?
    var name : String
    
    internal init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: AllergenCategory, rhs: AllergenCategory) -> Bool {
        lhs.name == rhs.name && rhs.id == lhs.id
    }
    
}

extension AllergenCategory{
    static var allergens : [AllergenCategory] = [
        AllergenCategory(id: 10, name: "Mollusques"),AllergenCategory(id: 1, name: "Fruits à coque"),AllergenCategory(id: 2, name: "Diary products")
    ]
}


protocol AllergenCategoryDelegate{
    
    func allergenCategoryChange(name : String)
    func allergenCategoryChange(id : Int)
    
}

