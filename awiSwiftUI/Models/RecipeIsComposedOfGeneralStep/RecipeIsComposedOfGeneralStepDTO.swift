//
//  RecipeIsComposedOfGeneralStepDTO.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 26/02/2022.
//

import Foundation

struct RecipeIsComposedOfGeneralStepDTO : Encodable, Decodable{
    var id : Int?
    var recipeId : Int
    var generalStepId : Int
    var stepNbOfOrder : Int
}
