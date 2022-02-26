//
//  Step.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 15/02/2022.
//

import Foundation

class Step : Stepable, ObservableObject, Identifiable{
    
    var delegate : StepDelegate?
    
    var id: Int?{
        didSet{
            self.delegate?.stepChange(id: self.id)
        }
    }
    var title: String{
        didSet{
            self.delegate?.stepChange(title: self.title)
        }
    }
    var description : String{
        didSet{
            self.delegate?.stepChange(description: self.description)
        }
    }
    var time : Int{
        didSet{
            self.delegate?.stepChange(time: self.time)
        }
    }
    
    var ingredients : [Ingredient : Int]
    
    internal init(id: Int? = nil, title: String, description: String, time: Int, ingredients : [Ingredient : Int]) {
        self.id = id
        self.title = title
        self.description = description
        self.time = time
        self.ingredients = ingredients
    }
    
}


protocol StepDelegate{
    func stepChange(id : Int?)
    func stepChange(title : String)
    func stepChange(description : String)
    func stepChange(time : Int)
}
protocol Stepable{
    
    var id : Int? {get set}
    var title : String {get set}
    
}
