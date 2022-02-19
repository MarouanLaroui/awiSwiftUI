//
//  AllergenCategoryDTO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

class AllergenCategoryDTO : Decodable, Encodable{
    
    var id : Int?
    var name : String
    
    internal init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
}
