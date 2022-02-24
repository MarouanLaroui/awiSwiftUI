//
//  StepDTO.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 24/02/2022.
//

import Foundation

class StepDTO : Decodable, Encodable{
    
    var id: Int?
    var title: String
    var description : String
    var time : Int
    
    internal init(id: Int? = nil, title: String, description: String, time: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.time = time
    }
}
