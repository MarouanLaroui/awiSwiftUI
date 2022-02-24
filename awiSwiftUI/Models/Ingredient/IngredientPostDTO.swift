//
//  IngredientPostDTO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

struct IngredientPostDTO : Decodable, Encodable{
    
    var id : Int?
    var name : String
    var unitaryPrice : Int
    var quantity : Int?
    var nbInStock : Int
    var allergen : Int?
    var category : Int
    var unity : Int
    
    
    internal init(id : Int? = nil, name: String, unitaryPrice: Int, nbInStock: Int, allergen: Int? = nil, category: Int, unity: Int) {
        self.id = id
        self.name = name
        self.unitaryPrice = unitaryPrice
        self.nbInStock = nbInStock
        self.allergen = allergen
        self.category = category
        self.unity = unity
    }
}
