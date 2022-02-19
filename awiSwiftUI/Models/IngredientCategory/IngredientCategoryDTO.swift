//
//  IngredientCategoryGetDTO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

class IngredientCategoryDTO : Decodable, Encodable{
    
    var id : Int?
    var category_name : String
    
    internal init(id: Int? = nil,  category_name: String) {
        self.id = id
        self.category_name =  category_name
    }
}
