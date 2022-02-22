//
//  IngredientPostDTO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

struct IngredientPostDTO : Decodable, Encodable{
    //var id : Int?
    var name : String
    var unitaryPrice : Int
    var nbInStock : Int
    var allergen : Int?
    var category : Int
    var unity : Int
}
