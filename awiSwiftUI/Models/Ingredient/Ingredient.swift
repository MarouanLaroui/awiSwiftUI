//
//  Ingredient.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import Foundation

class Ingredient : Identifiable, ObservableObject{
    
    var delegate : IngredientDelegate?
    
    var id : Int?
    @Published var name : String{
        didSet{
            print("didSet Ingredient")
            self.delegate?.ingredientChange(name: name)
        }
    }
    var unitaryPrice : Double{
        didSet{
            self.delegate?.ingredientChange(unitaryPrice: unitaryPrice)
        }
    }
    var nbInStock : Double{
        didSet{
            self.delegate?.ingredientChange(nbInStock: nbInStock)
        }
    }
    var allergen : AllergenCategory?{
        didSet{
            self.delegate?.ingredientChange(allergenCategory: allergen)
        }
    }
    var category : IngredientCategory{
        didSet{
            self.delegate?.ingredientChange(ingredientCategory: category)
        }
    }
    var unity : Unity{
        didSet{
            self.delegate?.ingredientChange(unity: unity)
        }
    }
    
    
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
        Ingredient(id:1,name:"TestPost",unitaryPrice: 10 ,nbInStock : 3, allergen: AllergenCategory.allergens[0], ingredientCategory: IngredientCategory.categories[0],unity: Unity.units[0]),
        Ingredient(id:2,name:"Patate",unitaryPrice: 7,nbInStock : 1 ,allergen: nil, ingredientCategory: IngredientCategory.categories[0],unity: Unity.units[0]),
        Ingredient(id:3,name:"Lait",unitaryPrice: 10,nbInStock : 1 ,allergen: AllergenCategory.allergens[2], ingredientCategory: IngredientCategory.categories[1],unity: Unity.units[1])
    ]
}


protocol IngredientDelegate{
    func ingredientChange(name : String)
    func ingredientChange(unitaryPrice : Double)
    func ingredientChange(nbInStock : Double)
    func ingredientChange(allergenCategory : AllergenCategory?)
    func ingredientChange(ingredientCategory : IngredientCategory)
    func ingredientChange(unity : Unity)
    func ingredientChange(id : Int)
}

