//
//  Ingredient.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import Foundation

class Ingredient : Identifiable{
    
    var delegate : IngredientDelegate?
    
    var id : Int?
    var name : String
    var unitaryPrice : Double
    var nbInStock : Double
    var allergen : AllergenCategory?
    var category : IngredientCategory
    var unity : Unity
    
    
    internal init(id : Int? = nil,name: String, unitaryPrice: Double, nbInStock : Double, allergen: AllergenCategory? = nil, ingredientCategory: IngredientCategory, unity: Unity) {
        self.id = id
        self.name = name
        self.unitaryPrice = unitaryPrice
        self.nbInStock = nbInStock
        self.allergen = allergen
        self.category = ingredientCategory
        self.unity = unity
        
    }
    
}

extension Ingredient{
    static var ingredients : [Ingredient] = [
        Ingredient(id:0,name:"Carotte",unitaryPrice: 10 ,nbInStock : 1, allergen: nil, ingredientCategory: IngredientCategory.categories[0],unity: Unity.units[0]),
        Ingredient(id:1,name:"Patate",unitaryPrice: 7,nbInStock : 1 ,allergen: nil, ingredientCategory: IngredientCategory.categories[0],unity: Unity.units[0]),
        Ingredient(id:2,name:"Lait",unitaryPrice: 10,nbInStock : 1 ,allergen: AllergenCategory.allergens[2], ingredientCategory: IngredientCategory.categories[1],unity: Unity.units[1])
    ]
}


protocol IngredientDelegate{
    func ingredientChange(name : String)
    func ingredientChange(unitaryPrice : Double)
    func ingredientChange(allergenCategory : AllergenCategory)
    func ingredientChange(ingredientCategory : IngredientCategory)
    func ingredientChange(unity : Unity)
    func ingredientChange(id : Int)
}

