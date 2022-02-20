//
//  Step.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 15/02/2022.
//

import Foundation

class Step : Stepable{
    
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

import Foundation

protocol Stepable{
    
    var id : Int? {get set}
    var title : String {get set}
    
}
