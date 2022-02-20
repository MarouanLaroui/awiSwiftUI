//
//  RecipeDTO.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 20/02/2022.
//

import Foundation

struct RecipeDTO : Encodable, Decodable{
    
    var id : Int?
    var title : String
    var nbOfServing : Int
    var personInCharge : String
    var specificEquipment : String
    var dressingEquipment : String
    var recipeCategory : RecipeCategoryDTO
    var author : UserDTO
    
}
