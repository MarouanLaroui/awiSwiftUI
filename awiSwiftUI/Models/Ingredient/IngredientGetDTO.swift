//
//  IngredientDTO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

struct IngredientGetDTO : Encodable, Decodable{
    
    var id : Int
    var name : String
    var unitaryPrice : Double
    var nbInStock : Double
    var quantity : Int?
    var allergen : AllergenCategoryDTO?
    var category : IngredientCategoryDTO
    var unity : UnityDTO
    
}
