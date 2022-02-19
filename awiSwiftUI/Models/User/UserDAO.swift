//
//  UserDAO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

struct UserDAO{
    
    static func dtoToUser(dto : UserDTO)->User{
        return User(id: dto.id, name: dto.name, last_name: dto.last_name, mail: dto.mail, phone: dto.phone, isAdmin: dto.isAdmin, birthdate: dto.birthdate)
    }
    
    static func userToDTO(user : User)->UserDTO{
        return UserDTO(id: user.id, name: user.name, last_name: user.last_name, mail: user.mail, phone: user.phone, birthdate: user.birthdate, isAdmin: user.isAdmin)
    }
    
}
