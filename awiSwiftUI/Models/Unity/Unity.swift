//
//  Unity.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import Foundation

class Unity : Identifiable, Hashable{
    
    var delegate : UnityDelegate?
    var id : Int?
    var unityName : String
    
    internal init(id: Int? = nil, unityName: String) {
        self.id = id
        self.unityName = unityName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(unityName)
    }
    
    static func == (lhs: Unity, rhs: Unity) -> Bool {
        return lhs.id == rhs.id && lhs.unityName == rhs.unityName
    }
    

    
    
}

extension Unity{
    static var units = [
        Unity(id: 0, unityName: "Kg"),Unity(id: 1, unityName: "L"),Unity(id: 2, unityName: "unit")
    ]
}


protocol UnityDelegate{
    
    func unityChange(unityName : String)
    func unityChange(id : Int)
    
}

