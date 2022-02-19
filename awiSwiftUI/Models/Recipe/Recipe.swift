//
//  Recipe.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 15/02/2022.
//

import Foundation

class Recipe : Stepable{
    
    var id : Int?
    var title : String
    var nbOfServing : Int
    var personInCharge : String
    var specificEquipment : String
    var dressingEquipment : String
    
    internal init(id: Int? = nil, title: String, nbOfServing: Int, personInCharge: String, specificEquipment: String, dressingEquipment: String) {
        self.id = id
        self.title = title
        self.nbOfServing = nbOfServing
        self.personInCharge = personInCharge
        self.specificEquipment = specificEquipment
        self.dressingEquipment = dressingEquipment
    }
    
}

extension Recipe{
    static var recipes : [Recipe] = [
        Recipe(id: 1, title: "Pot au feu", nbOfServing: 7, personInCharge: "Saucier", specificEquipment: "Marmitte", dressingEquipment: ""),
        Recipe(id: 2, title: "Pizza", nbOfServing: 7, personInCharge: "Pizzaiomo", specificEquipment: "Pelle", dressingEquipment: ""),
        Recipe(id: 3, title: "Poulet roti", nbOfServing: 7, personInCharge: "Rotisseur", specificEquipment: "Broche", dressingEquipment: ""),
    ]
}

protocol RecipeDelegate{
    
    func RecipeChange(id : Int)
    func RecipeChange(title : String)
    func RecipeChange(nbOfServing : Int)
    func RecipeChange(personInCharge : String)
    func RecipeChange(specificEquipment : String)
    func RecipeChange(dressingEquipment : String)
    
}
