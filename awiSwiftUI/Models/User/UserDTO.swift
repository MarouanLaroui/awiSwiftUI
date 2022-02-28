//
//  UserDTO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

struct UserDTO : Encodable, Decodable{
    
    var id : Int?
    var name : String
    var last_name : String
    var mail : String
    var phone : String
    var birthdate : String
    var isAdmin : Bool
    var access_token : String?
    
}
