//
//  IngredientCategory.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import Foundation

class IngredientCategory : Identifiable, Hashable, Equatable{
    
    static func == (lhs: IngredientCategory, rhs: IngredientCategory) -> Bool {
        return lhs.category_name == rhs.category_name && rhs.id == lhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(category_name)
    }
    
    
    var delegate : IngredientCategoryDelegate?
    
    var id : Int?
    var category_name : String
    
    internal init(id: Int? = nil, category_name: String) {
        self.id = id
        self.category_name = category_name
    }
}

extension IngredientCategory{
    static var categories : [IngredientCategory] = [
        IngredientCategory(id: 2, category_name: "Légumes"),IngredientCategory(id: 2, category_name: "Fruits"),IngredientCategory(id: 3, category_name: "Viande")
    ]
}

protocol IngredientCategoryDelegate{
    
    func ingredientCategoryChange(category_name : String)
    func ingredientCategoryChange(id : Int)
    
}
