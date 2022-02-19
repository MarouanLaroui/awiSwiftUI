//
//  UnityDTO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

class UnityDTO : Decodable, Encodable{
    
    
    var id : Int?
    var unityName : String
    
    internal init(id: Int? = nil, unityName: String) {
        self.id = id
        self.unityName = unityName
    }
    
}
