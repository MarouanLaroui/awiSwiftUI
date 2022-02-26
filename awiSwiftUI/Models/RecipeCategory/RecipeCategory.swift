//
//  IngredientCategory.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import Foundation

class RecipeCategory : Identifiable, Hashable, Equatable{
    
    static func == (lhs: RecipeCategory, rhs: RecipeCategory) -> Bool {
        return lhs.name == rhs.name && rhs.id == lhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    
    var delegate : RecipeCategoryDelegate?
    
    var id : Int?
    var name : String
    
    internal init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
/*
class RecipeCategoryDTO : Decodable{
    
    var id : Int
    var name : String
    
    internal init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    static func DTOtoIngredientCategory(dto : IngredientCategoryDTO) -> IngredientCategory{
        return IngredientCategory(id : dto.id, category_name : dto.category_name)
    }
    
    static func DTOsToIngredientCategories(dtos : [IngredientCategoryDTO]) -> [IngredientCategory]{
        var ingredientCategories : [IngredientCategory] = []
        dtos.forEach(){
            dto in
            ingredientCategories.append(IngredientDAO.DTOtoIngredientCategory( dto :dto))
        }
        return ingredientCategories
    }
}
*/

extension RecipeCategory{
    static var categories : [RecipeCategory] = [
        RecipeCategory(id: 1, name: "Entrée"),RecipeCategory(id: 2, name: "Plat"),RecipeCategory(id: 3, name: "Dessert")
    ]
}

protocol RecipeCategoryDelegate{
    
    func ingredientCategoryChange(name : String)
    func ingredientCategoryChange(id : Int)
    
}
