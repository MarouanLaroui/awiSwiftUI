//
//  StepToIngredientDTO.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 26/02/2022.
//

import Foundation

struct StepToIngredientDTO : Encodable, Decodable{
    
    var id : Int?
    var ingredientId : Int
    var stepId : Int
    var quantity : Int
}
